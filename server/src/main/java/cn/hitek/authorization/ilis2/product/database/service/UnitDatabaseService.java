package cn.hitek.authorization.ilis2.product.database.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.domain.vo.UpdateEchoLog;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;

import java.util.List;

/**
 * @author chenlm
 */
public interface UnitDatabaseService extends BaseService<UnitDatabase> {

    /**
     * 初始化单位数据库
     * @param unitDatabaseId 单位数据库id
     */
    void initUnitDatabase(String unitDatabaseId);

    /**
     * 检查单位是否拥有已初始化的数据库
     * 已初始化就视为正在使用
     * @param unitId 单位id
     * @return 检测结果
     */
    boolean isUnitDatabaseInitialized(String unitId);

    /**
     * 验证数据库名是否合规
     * @param name 数据库名
     * @return 检测结果
     */
    boolean isDatabaseNameIllegally(String name);

    /**
     * 根据单位id删除对应数据库信息
     * @param unitId 单位id
     */
    void removeUnitDatabaseInfoViaUnitId(String unitId);

    /**
     * 根据单位信息新增单位默认数据库信息
     * @param unit 单位实体
     * @return unit database id
     */
    String createUnitDatabaseInfo(Unit unit);

    /**
     * 更新单位数据库
     * @param id 数据库id
     * @return 执行结果
     */
    List<UpdateEchoLog> updateDatabase(String id);
}
