package cn.hitek.authorization.ilis2.product.unit.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtil;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.domain.UnitUserOnlineLog;
import cn.hitek.authorization.ilis2.product.unit.domain.dto.WeekOnline;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.UnitAccount;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.UnitInfo;
import cn.hitek.authorization.ilis2.product.unit.event.AutoInsertMainProfileEvent;
import cn.hitek.authorization.ilis2.product.unit.helper.UnitOnlineBucket;
import cn.hitek.authorization.ilis2.product.unit.mapper.UnitMapper;
import cn.hitek.authorization.ilis2.product.unit.mapper.UnitUserOnlineLogMapper;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import cn.hitek.authorization.ilis2.product.unit.service.UnitUserLogger;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.redis.core.BoundSetOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.*;

/**
 * @author chenlm
 */
@EnableScheduling
@Service
@AllArgsConstructor
public class UnitServiceImpl extends BaseServiceImpl<UnitMapper, Unit> implements UnitService {

    private final UnitDatabaseService databaseService;
    private final RedisTemplate<String, Object> redisTemplate;
    private final UnitUserLogger userLogger;
    private final UnitUserOnlineLogMapper onlineLogMapper;
    private final ApplicationEventPublisher eventPublisher;

    final String[] weeks = new String[]{"周一", "周二", "周三", "周四", "周五", "周六", "周日"};

    @Override
    public boolean validateCode(String code) {
        return query().eq(StringUtils.isNotBlank(code), Unit::getUniqCode, code).exist();
    }

    @Transactional(rollbackFor = BusinessException.class)
    @Override
    public void removeUnitInfoAndDatabaseInfoViaUnitId(String unitId) {
        boolean remove = remove(Wrappers.lambdaQuery(Unit.class)
                .eq(Unit::getId, unitId)
                .eq(Unit::getIsAuthorized, !Unit.AUTHORIZED));
        if (!remove) {
            throw new BusinessException("删除失败！已经授权的单位不能删除");
        } else {
            this.databaseService.removeUnitDatabaseInfoViaUnitId(unitId);
        }
    }

    @Transactional(rollbackFor = RuntimeException.class)
    @Override
    public String insertUnitInfo(Unit unit) {
        save(unit);
        if (unit.getMainSource()) {
            AutoInsertMainProfileEvent event = new AutoInsertMainProfileEvent(this, unit);
            this.eventPublisher.publishEvent(event);
        }
        return this.databaseService.createUnitDatabaseInfo(unit);
    }

    @SneakyThrows
    @Override
    public String getUnitInfo(String code) {
        Unit unit = query().eq(Unit::getUniqCode, code).getOne();
        Objects.requireNonNull(unit, "单位编码错误");
        UnitInfo info = new UnitInfo();
        info.setExpired(LocalDate.now().isAfter(unit.getExpireDate()));
        info.setSingleLogin(unit.getSingleLogin());
        Long totalUsers = getUnitTotalUsers(unit);
        info.setUserMaxLimits(totalUsers >= unit.getMaxAccount());
        Integer unitOnlineUsers = this.userLogger.getUnitOnlineUsers(unit.getUniqCode());
        info.setUserOnlineMaxLimits(unitOnlineUsers >= unit.getMaxOnlineAccount());
        UnitDatabase database = this.databaseService.query().eq(UnitDatabase::getUnitId, unit.getId()).getOne();
        info.setData(new DatabaseInfo(database));
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(info);
        return EncryptUtil.encrypt(json);
    }

    private Long getUnitTotalUsers(Unit unit) {
        String totalUsersKey = this.userLogger.getTotalUsersKey(unit.getUniqCode());
        BoundSetOperations<String, Object> setOps = this.redisTemplate.boundSetOps(totalUsersKey);
        return setOps.size();
    }

    @Override
    public void updateUnitLoginPolicy(String unitId) {
        Unit unit = getById(unitId);
        unit.setSingleLogin(!unit.getSingleLogin());
        super.updateById(unit);
    }

    @Override
    public void logUserLogin(LoginInfo loginInfo) {
        loginInfo.setOperationTime(LocalDateTime.now());
        this.userLogger.handleLoginLog(loginInfo);
        this.userLogger.handleLoginStatisticLog(loginInfo);
    }

    @Override
    public Long combineUnitUsers(String type) {
        Long counter = 0L;
        Set<String> keys = this.redisTemplate.keys(type + "*");
        if (keys != null) {
            switch (type) {
                case Constant.ILIS_LOGIN_TOTAL_PREFIX:
                    for (String key : keys) {
                        counter += this.redisTemplate.boundSetOps(key).size();
                    }
                    break;
                case Constant.ILIS_LOGIN_ONLINE_PREFIX:
                    counter += keys.size();
                    break;
                default:
            }
        }
        return counter;
    }

    @Override
    public List<Map<String, Object>> getUnitUserPie() {
        List<Unit> units = query().list();
        ArrayList<Map<String, Object>> list = new ArrayList<>(units.size());
        for (Unit unit : units) {
            HashMap<String, Object> data = new HashMap<>(1);
            data.put("name", unit.getName());
            String key = this.userLogger.getTotalUsersKey(unit.getUniqCode());
            Long count = this.redisTemplate.boundSetOps(key).size();
            data.put("value", count);
            list.add(data);
        }
        return list;
    }

    /**
     * 每天0点过10秒开始执行
     */
    @Scheduled(cron = "10 0 0 * * ?")
    public void logUnitOnlineUsersEachDay() {
        Set<String> keys = this.redisTemplate.keys(Constant.ILIS_ONLINE_BUCKET_PREFIX + "*");
        if (keys != null && !keys.isEmpty()) {
            for (String key : keys) {
                Map<String, HashSet<LoginInfo>> periods = UnitOnlineBucket.get(this.redisTemplate, key);
                if (null != periods && !periods.isEmpty()) {
                    Integer topOnlineMembers = periods
                            .values()
                            .stream()
                            .map(HashSet::size)
                            .max(Integer::compareTo)
                            .orElse(0);
                    LocalDate yesterday = LocalDate.now().minusDays(1);
                    String unitCode = key.substring(key.lastIndexOf(".") + 1);
                    this.onlineLogMapper.insert(new UnitUserOnlineLog(yesterday, unitCode, topOnlineMembers));
                    // delete yesterday unit online bucket
                    this.redisTemplate.delete(key);
                }
            }
        }
    }

    @Override
    public Map<String, Integer> getWeekOnlineStatisticData() {
        Map<String, Integer> data = generateMapData();
        List<WeekOnline> onlineData = this.onlineLogMapper.getWeekStatisticData();
        for (WeekOnline online : onlineData) {
            int weekDayIndex = online.getLogTime().getDayOfWeek().getValue() - 1;
            data.put(weeks[weekDayIndex], online.getMembers());
        }
        return data;
    }

    private Map<String, Integer> generateMapData() {
        TreeMap<String, Integer> map = new TreeMap<>((Comparator.comparingInt(o -> Arrays.asList(weeks).indexOf(o))));
        for (String week : weeks) {
            map.put(week, 0);
        }
        return map;
    }

    @Override
    public Map<String, int[]> getCurrentOnlineData() {
        List<Unit> units = query().list();
        HashMap<String, int[]> data = new HashMap<>(units.size());
        for (Unit unit : units) {
            int[] membersArray = new int[24];
            final String bucketKey = Constant.ILIS_ONLINE_BUCKET_PREFIX + unit.getUniqCode();
            Map<String, HashSet<LoginInfo>> unitLogs = UnitOnlineBucket.get(this.redisTemplate, bucketKey);
            if (unitLogs != null && !unitLogs.isEmpty()) {
                unitLogs.forEach((k, v) -> membersArray[Integer.parseInt(k)] = v.size());
            }
            data.put(unit.getName(), membersArray);
        }
        return data;
    }

    @Override
    public List<UnitAccount> getUnitAccountData() {
        List<Unit> units = query().list();
        ArrayList<UnitAccount> list = new ArrayList<>(units.size());
        for (Unit unit : units) {
            UnitAccount account = new UnitAccount();
            account.setUnitCode(unit.getUniqCode());
            account.setUnitName(unit.getName());
            account.setMaxAccount(unit.getMaxAccount());
            Long totalUsers = getUnitTotalUsers(unit);
            account.setTotalAccount(totalUsers.intValue());
            account.setMaxOnlineAccount(unit.getMaxOnlineAccount());
            Integer unitOnlineUsers = this.userLogger.getUnitOnlineUsers(unit.getUniqCode());
            account.setOnlineAccount(unitOnlineUsers);
            list.add(account);
        }
        return list;
    }

    @Override
    public IPage<LoginInfo> getUnitLoginLog(String unitCode, Page<LoginInfo> page) {
        return this.userLogger.getLogsViaUnitCode(unitCode, page);
    }

    @Override
    public Boolean isUnitSessionOnline(String sessionId, String code) {
        final String key = Constant.ILIS_LOGIN_ONLINE_PREFIX + code + "." + sessionId;
        return this.redisTemplate.hasKey(key);
    }
}
