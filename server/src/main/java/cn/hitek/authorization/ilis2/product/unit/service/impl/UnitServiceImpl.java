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
import cn.hitek.authorization.ilis2.product.unit.domain.vo.OnlineLog;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.UnitAccount;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.UnitInfo;
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
import org.springframework.data.redis.core.BoundListOperations;
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
     * 每个小时统计单位活跃用户
     */
    @Scheduled(cron = "0 0 0/1 * * ? ")
    public void logUnitOnlineUsersEveryHour() {
        LocalDateTime now = LocalDateTime.now();
        List<Unit> units = query().list();
        for (Unit unit : units) {
            Integer onlineUsers = this.userLogger.getUnitOnlineUsers(unit.getUniqCode());
            OnlineLog log = new OnlineLog(now, unit.getUniqCode(), onlineUsers);
            BoundListOperations<String, Object> listOps = this.redisTemplate
                    .boundListOps(unit.getUniqCode() + Constant.USER_ONLINE_SUFFIX);
            listOps.rightPush(log);
        }
    }

    @Scheduled(cron = "0 30 0 * * ? ")
    public void logUnitOnlineUsersEachDay() {
        Set<String> keys = this.redisTemplate.keys("*" + Constant.USER_ONLINE_SUFFIX);
        if (keys != null && !keys.isEmpty()) {
            for (String key : keys) {
                BoundListOperations<String, Object> listOps = this.redisTemplate.boundListOps(key);
                List<Object> logs = listOps.range(0, -1);
                if (logs != null && !logs.isEmpty()) {
                    OnlineLog log = (OnlineLog) logs.get(0);
                    LocalDateTime time = log.getTime();
                    String unitCode = log.getUnitCode();
                    Integer topOnlineMembers = logs
                            .stream()
                            .map(o -> (OnlineLog) o)
                            .map(OnlineLog::getMembers)
                            .max(Integer::compareTo)
                            .orElse(0);
                    // delete unit online user log redis list
                    listOps.trim(-1, 0);
                    this.onlineLogMapper.insert(new UnitUserOnlineLog(time.toLocalDate(), unitCode, topOnlineMembers));
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
            String key = unit.getUniqCode() + Constant.USER_ONLINE_SUFFIX;
            List<Object> logs = this.redisTemplate.boundListOps(key).range(0, -1);
            if (logs != null && !logs.isEmpty()) {
                // @formatter:off
                logs
                    .stream()
                    .map(l -> (OnlineLog)l)
                    .forEach(l -> {
                        int hourIndex = l.getTime().getHour() - 1;
                        membersArray[hourIndex] = l.getMembers();
                    });
                // @formatter:on
                data.put(unit.getName(), membersArray);
            }
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
}
