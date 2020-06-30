package cn.hitek.authorization.ilis2.product.unit.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtil;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.unit.domain.vo.UnitInfo;
import cn.hitek.authorization.ilis2.product.unit.mapper.LoginInfoMapper;
import cn.hitek.authorization.ilis2.product.unit.mapper.UnitMapper;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import org.springframework.data.redis.core.BoundHashOperations;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.Objects;

/**
 * @author chenlm
 */
@Service
@AllArgsConstructor
public class UnitServiceImpl extends BaseServiceImpl<UnitMapper, Unit> implements UnitService {

    private final UnitDatabaseService databaseService;
    private final RedisTemplate<String, Object> redisTemplate;
    private final LoginInfoMapper loginInfoMapper;

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
        info.setUserMaxLimits(false);
        info.setUserOnlineMaxLimits(false);
        UnitDatabase database = this.databaseService.query().eq(UnitDatabase::getUnitId, unit.getId()).getOne();
        DatabaseInfo databaseInfo = new DatabaseInfo(database);
        info.setData(databaseInfo);
        ObjectMapper mapper = new ObjectMapper();
        String json = mapper.writeValueAsString(info);
        return EncryptUtil.encrypt(json);
    }

    @Override
    public void updateUnitLoginPolicy(String unitId) {
        Unit unit = getById(unitId);
        unit.setSingleLogin(!unit.getSingleLogin());
        super.updateById(unit);
    }

    @Async("asyncExecutor")
    @Override
    public void logUserLogin(LoginInfo loginInfo) {
        String key = Constant.UNIT_USER_LOGIN_LOG_PREFIX + loginInfo.getUnitCode();
        BoundHashOperations<String, Object, Object> hashOps = this.redisTemplate.boundHashOps(key);
        if (loginInfo.getLogin()) {
            hashOps.put(loginInfo.getUserId(), loginInfo);
        } else {
            hashOps.delete(loginInfo.getUserId());
        }
        loginInfo.setOperationTime(LocalDateTime.now());
        this.loginInfoMapper.insert(loginInfo);
    }
}
