package cn.hitek.authorization.ilis2.product.data.management.service;

import cn.hitek.authorization.ilis2.product.data.management.domain.DataScript;
import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;

import java.util.List;

/**
 * @author chenlm
 */
public interface DataManageService {

    /**
     * 获取单位数据库相关信息
     * @param unitDatabaseList 单位数据库集合
     * @return result
     */
    List<DatabaseInfo> getUnitDatabaseList(List<UnitDatabase> unitDatabaseList);

    /**
     * 同步数据库字段
     * @param targetProfileId 目标数据源id
     * @param mainProfileId 主数据源id
     * @param sourceSchema form
     * @param targetSchemas to 多个target以半角逗号分隔
     */
    void sync(String mainProfileId, String targetProfileId, String sourceSchema, String targetSchemas);

    /**
     * 新增数据库脚本
     * @param script sql
     */
    void insertDataScript(DataScript script);

    /**
     * 获取当前数据库数据版本到最新版本
     * @param dataVersion 当前数据库数据库版本
     * @return 脚本
     */
    List<DataScript> getScriptRange(Long dataVersion);
}
