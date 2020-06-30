package cn.hitek.authorization.ilis2.product.unit.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.unit.domain.LoginInfo;
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

    /**
     * 新增单位信息并新增单位数据库信息
     * @param unit 单位实体
     * @return unit database id
     */
    String insertUnitInfo(Unit unit);

    /**
     * ilis2 程序根据单位识别码获取单位信息单位数据库信息
     * @param code 单位识别码
     * @return 加密字符串
     */
    String getUnitInfo(String code);

    /**
     * 修改单位单点登录状态
     * @param unitId 单位id
     */
    void updateUnitLoginPolicy(String unitId);

    /**
     * 记录单位用户登录日志
     * @param loginInfo 登录信息
     */
    void logUserLogin(LoginInfo loginInfo);
}
