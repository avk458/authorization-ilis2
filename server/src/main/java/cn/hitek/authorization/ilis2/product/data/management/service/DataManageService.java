package cn.hitek.authorization.ilis2.product.data.management.service;

import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.data.management.domain.Schema;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

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
     * 根据配置，获取数据库schema
     * @param config 配置实体
     * @return 数据库databases
     * @throws SQLException SQLException
     */
    Map<String, List<Schema>> getSourceSchemaList(InitialConfig config) throws SQLException;

    /**
     * 同步数据库字段
     * @param configId 使用配置
     * @param sourceSchema form
     * @param targetSchemas to 多个target以半角逗号分隔
     */
    void sync(String configId, String sourceSchema, String targetSchemas);
}
