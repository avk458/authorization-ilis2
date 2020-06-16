package cn.hitek.authorization.ilis2.product.data.management.service.impl;

import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.service.ConfigService;
import cn.hitek.authorization.ilis2.product.data.management.compare.Comparer;
import cn.hitek.authorization.ilis2.product.data.management.domain.DatabaseInfo;
import cn.hitek.authorization.ilis2.product.data.management.domain.meta.MetaData;
import cn.hitek.authorization.ilis2.product.data.management.service.DataManageService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.helper.ConnectionHandler;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.CompletableFuture;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import static cn.hitek.authorization.ilis2.product.database.helper.SqlUtil.executeQuery;

/**
 * @author chenlm
 */
@Service
@Log4j2
@AllArgsConstructor
public class DataManageServiceImpl implements DataManageService {

    private final ConfigService configService;

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
        try (Connection connection = this.configService.getTargetSourceConnection(unitDatabase.getTargetProfileId())) {
            info.setOnline(true);
            String schema = unitDatabase.getDatabaseName();
            String tableCount = "SELECT COUNT(*) FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + schema + "'";
            ResultSet resultSet = executeQuery(connection, tableCount);
            int tables = 0;
            while (resultSet.next()) {
                tables = resultSet.getInt(1);
            }
            info.setTables(tables);
            String dataSizeSql = "SELECT CONCAT(ROUND(SUM(DATA_LENGTH)/(1024*1024),2) + ROUND(SUM(INDEX_LENGTH)/(1024*1024),2),'MB') FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + schema + "'";
            resultSet = executeQuery(connection, dataSizeSql);
            String dataSize = "";
            while (resultSet.next()) {
                dataSize = resultSet.getString(1);
            }
            info.setDataSize(dataSize);
            String indexSizeSql = "SELECT CONCAT(ROUND(SUM(INDEX_LENGTH)/(1024*1024),2),'MB') FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = '" + schema + "'";
            resultSet = executeQuery(connection, indexSizeSql);
            String indexSize = "";
            while (resultSet.next()) {
                indexSize = resultSet.getString(1);
            }
            info.setIndexSize(indexSize);
            String uptimeSql = "SHOW GLOBAL STATUS LIKE 'Uptime'";
            resultSet = executeQuery(connection, uptimeSql);
            long uptime = 0L;
            while (resultSet.next()) {
                uptime = resultSet.getLong(2);
            }
            info.setUptime(uptime);
            resultSet = executeQuery(connection, "SHOW VARIABLES LIKE '%max_connections%'");
            int maxConnections = 0;
            while (resultSet.next()) {
                maxConnections = resultSet.getInt(2);
            }
            info.setMaxConnections(maxConnections);
            resultSet = executeQuery(connection, "SHOW STATUS LIKE 'Threads%'");
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
    public void sync(String mainProfileId, String targetProfileId, String sourceSchema, String targetSchemas) {
        MainSourceProfile mainProfile = this.configService.getById(mainProfileId);
        Connection sourceConnection = ConnectionHandler.getConnection(mainProfile);
        MetaData source = initTargetMetaData(sourceSchema, sourceConnection);
        Connection targetConnection = this.configService.getTargetSourceConnection(targetProfileId);
        CompletableFuture.allOf(Stream.of(targetSchemas.split(","))
                .map(targetSchema -> CompletableFuture
                        .supplyAsync(() -> initTargetMetaData(targetSchema, targetConnection))
                        .whenCompleteAsync((target, th) -> compareAndExecute(source, target)))
                .toArray(CompletableFuture[]::new))
                .whenComplete((v, th) -> afterSync(sourceConnection, targetConnection))
                .join();
    }

    @SneakyThrows
    private void afterSync(Connection sourceConnection, Connection targetConnection) {
        if (!sourceConnection.isClosed()) {
            sourceConnection.close();
        }
        if (!targetConnection.isClosed()) {
            targetConnection.close();
        }
    }

    private void compareAndExecute(MetaData source, MetaData target) {
        Comparer comparer = new Comparer(source, target);
        comparer.compare();
        comparer.execute();
    }

    @SneakyThrows
    private MetaData initTargetMetaData(String schema, Connection connection) {
        MetaData metaData = MetaData.builder().build();
        metaData.setSchema(schema);
        metaData.setConnection(connection);
        metaData.init();
        return metaData;
    }

}
