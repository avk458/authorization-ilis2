package cn.hitek.authorization.ilis2.product.database.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.domain.vo.UpdateEchoLog;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import java.util.List;
import java.util.Map;

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
     * @param updateVersion 所选升级到的版本
     * @return 执行结果
     */
    List<UpdateEchoLog> updateDatabase(String id, Long updateVersion);

    /**
     * 获取当前单位数据库数据版本以及数据库脚本版本
     * @param unit 单位信息实体
     * @return 查询结果
     */
    Map<String, Long> getDatabaseVersionAndScriptVersion(Unit unit);


    /**
     * ilis主程序升级数据库回执
     * @param unitId 单位id
     * @param version 执行成功脚本id
     */
    void updateDatabaseDataVersion(String unitId, Long version);

    /**
     * 批量更新可管控的单位数据库
     * @return execute log
     */
    List<UpdateEchoLog> batchUpdateDatabase();

    /**
     * 升级标准库
     * @param script 数据脚本
     * @return 执行结果
     */
    boolean executeInStandardSchemas(DataScript script);

    /**
     * 外网环境中导入内网脚本数据时更新标准库
     * @param dataVersion 导入前的数据版本
     */
    void updateStandardSchema(Long dataVersion);

    /**
     * 新增脚本预先在标准库执行
     * @param script 数据脚本
     */
    void insertScriptIfExecuted(DataScript script);

    /**
     * 同步更新修改后的单位信息
     * @param entity 单位信息实体
     */
    void updateCenterUnitInfo(Unit entity);

    /**
     * 获取单位数据库信息分页集合
     * @param page 分页参数
     * @return 分页集合
     */
    IPage<UnitDatabase> getPageRecords(Page<UnitDatabase> page);
}
