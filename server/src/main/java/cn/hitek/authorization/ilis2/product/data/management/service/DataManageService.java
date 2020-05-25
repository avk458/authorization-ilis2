package cn.hitek.authorization.ilis2.product.data.management.service;

import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.data.management.domain.SchemaInfo;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;

import java.sql.SQLException;
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
     * 根据配置，获取数据库schema
     * @param config 配置实体
     * @return 数据库databases
     * @throws SQLException SQLException
     */
    List<SchemaInfo> getSourceSchemaList(InitialConfig config) throws SQLException;
}
