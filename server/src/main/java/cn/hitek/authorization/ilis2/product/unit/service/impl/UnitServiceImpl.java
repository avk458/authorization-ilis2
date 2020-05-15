package cn.hitek.authorization.ilis2.product.unit.service.impl;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hitek.authorization.ilis2.product.unit.mapper.UnitMapper;
import cn.hitek.authorization.ilis2.product.unit.service.UnitService;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * @author chenlm
 */
@Service
public class UnitServiceImpl extends BaseServiceImpl<UnitMapper, Unit> implements UnitService {

    private final UnitDatabaseService databaseService;

    public UnitServiceImpl(UnitDatabaseService databaseService) {
        this.databaseService = databaseService;
    }

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
    public void insertUnitInfo(Unit unit) {
        save(unit);
        this.databaseService.createUnitDatabaseInfo(unit);
    }
}
