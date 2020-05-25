package cn.hitek.authorization.ilis2.product.data.management.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.data.management.domain.SchemaInfo;
import cn.hitek.authorization.ilis2.product.data.management.service.DataManageService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.helper.ConnectionHandler;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.configuration.service.InitialConfigService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.SneakyThrows;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;

/**
 * @author chenlm
 */
@Service
@Log4j2
public class DataManageServiceImpl implements DataManageService {

    private final static String SOURCE = "source";
    private final static String TARGET = "target";

    private final InitialConfigService configService;

    public DataManageServiceImpl(InitialConfigService configService) {
        this.configService = configService;
    }

    @SneakyThrows
    @Override
    public List<DatabaseInfo> getUnitDatabaseList(List<UnitDatabase> unitDatabaseList) {
        List<CompletableFuture<DatabaseInfo>> futures = unitDatabaseList
                .stream()
                .filter(UnitDatabase::getIsInitialized)
                .map(ud -> CompletableFuture.completedFuture(ud).thenApplyAsync(this::queryDatabaseInfo))
                .collect(Collectors.toList());
        return futures.stream().map(CompletableFuture::join).collect(Collectors.toList());
    }

    private DatabaseInfo queryDatabaseInfo(UnitDatabase unitDatabase) {
        DatabaseInfo info = new DatabaseInfo();
        info.setName(unitDatabase.getDatabaseName());
        InitialConfig config = this.configService.getOne(Wrappers.lambdaQuery(InitialConfig.class)
                .eq(InitialConfig::getId, unitDatabase.getInitializeProfile()));
        try (Connection connection = ConnectionHandler.getTargetConnection(config)) {
            info.setOnline(true);
            Statement statement = connection.createStatement();
            String schema = unitDatabase.getDatabaseName();
            ResultSet resultSet = statement.executeQuery("SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + schema + "'");
            int tables = 0;
            while (resultSet.next()) {
                tables = resultSet.getInt(1);
            }
            info.setTables(tables);
            resultSet = statement.executeQuery("SELECT CONCAT(ROUND(SUM(DATA_LENGTH)/(1024*1024),2) + ROUND(SUM(INDEX_LENGTH)/(1024*1024),2),'MB') FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + schema + "'");
            String dataSize = "";
            while (resultSet.next()) {
                dataSize = resultSet.getString(1);
            }
            info.setDataSize(dataSize);
            resultSet = statement.executeQuery("SELECT CONCAT(ROUND(SUM(INDEX_LENGTH)/(1024*1024),2),'MB') FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + schema + "'");
            String indexSize = "";
            while (resultSet.next()) {
                indexSize = resultSet.getString(1);
            }
            info.setIndexSize(indexSize);
            resultSet = statement.executeQuery("SHOW GLOBAL STATUS LIKE 'Uptime'");
            long uptime = 0L;
            while (resultSet.next()) {
                uptime = resultSet.getLong(2);
            }
            info.setUptime(uptime);
            resultSet = statement.executeQuery("SHOW VARIABLES LIKE '%max_connections%'");
            int maxConnections = 0;
            while (resultSet.next()) {
                maxConnections = resultSet.getInt(2);
            }
            info.setMaxConnections(maxConnections);
            resultSet = statement.executeQuery("SHOW STATUS LIKE 'Threads%'");
            HashMap<String, Integer> threadResultContainer = new HashMap<>(4);
            while (resultSet.next()) {
                threadResultContainer.put(resultSet.getString(1), resultSet.getInt(2));
            }
            info.setThreadsCached(threadResultContainer.get("Threads_cached"));
            info.setThreadConnected(threadResultContainer.get("Threads_connected"));
            info.setThreadCreated(threadResultContainer.get("Threads_created"));
            info.setThreadRunning(threadResultContainer.get("Threads_running"));
        } catch (SQLException e) {
            log.warn(e.getMessage());
            e.printStackTrace();
        }
        return info;
    }

    @SneakyThrows
    @Override
    public List<SchemaInfo> getSourceSchemaList(InitialConfig config) {
        ArrayList<SchemaInfo> list = new ArrayList<>(0);
        try (Connection connection = ConnectionHandler.getConnection(config)) {
            list.add(getSchemaFromDatabase(connection, SOURCE));
        }
        try (Connection connection = ConnectionHandler.getTargetConnection(config)) {
            list.add(getSchemaFromDatabase(connection, TARGET));
        }
        return list;
    }

    private SchemaInfo getSchemaFromDatabase(Connection connection, String schemaType) throws SQLException {
        Statement statement = connection.createStatement();
        ResultSet rs = statement.executeQuery("SHOW DATABASES ");
        SchemaInfo schemaInfo = new SchemaInfo();
        schemaInfo.setSchemaType(schemaType);
        ArrayList<SchemaInfo.Schema> schemas = new ArrayList<>();
        while (rs.next()) {
            String s = rs.getString(1);
            SchemaInfo.Schema schema = new SchemaInfo.Schema();
            schema.setKey(s);
            schema.setLabel(s);
            schema.setDisabled(Constant.SYSTEM_SCHEMA.contains(s));
            schemas.add(schema);
        }
        schemaInfo.setSchemaList(schemas);
        return schemaInfo;
    }
}
