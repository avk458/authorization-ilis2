package cn.hitek.authorization.ilis2.product.unit.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;

/**
 * @author chenlm
 */
public interface UnitService extends BaseService<Unit>{

    /**
     * 检测单位唯一识别码是否存在
     * @param code 识别码
     * @return 检测结果
     */
    boolean validateCode(String code);

    /**
     * 根据单位id，删除单位信息和单位数据库信息
     * @param unitId 单位id
     */
    void removeUnitInfoAndDatabaseInfoViaUnitId(String unitId);
}
