package cn.hitek.authorization.ilis2.product.database.helper;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import org.apache.commons.lang3.StringUtils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author chenlm
 */
public class ConnectionHandler {

    public static Connection getTargetConnection(InitialConfig config) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(config.getTargetDatabaseHost())
                .setPort(config.getTargetDatabasePort())
                .getPath();
        path += Constant.PARAMS;
        return DriverManager.getConnection(path, EncryptUtils.decrypt(config.getTargetDatabaseUsername()), EncryptUtils.decrypt(config.getTargetDatabasePwd()));
    }

    public static Connection getConnection(InitialConfig config) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(config.getHost())
                .setPort(config.getPort())
                .setSchema(config.getSchemaName())
                .getPath();
        path += Constant.PARAMS;
        return DriverManager.getConnection(path, config.getUsername(), EncryptUtils.decrypt(config.getPassword()));
    }

    public static void initializeDatabaseUser(InitialConfig config, UnitDatabase unitDatabase) throws SQLException {
        final String schema = unitDatabase.getDatabaseName();
        final String user = EncryptUtils.decrypt(unitDatabase.getDatabaseUsername()) + "@'%'";
        final String decryptPwd = EncryptUtils.decrypt(unitDatabase.getDatabasePwd());
        final Connection connection = getTargetConnection(config);
        Statement statement = connection.createStatement();
        statement.execute("CREATE USER " + user + " IDENTIFIED BY '" + decryptPwd + "'");
        // statement.execute("GRANT ALL PRIVILEGES ON " + schema +".* " + "TO " + user);
        statement.execute("GRANT INSERT,DELETE,UPDATE,SELECT ON " + schema +".* " + "TO " + user);
        statement.execute("FLUSH PRIVILEGES ");
        statement.execute("CREATE DATABASE " + schema + " CHARACTER SET utf8 COLLATE utf8_general_ci");
    }

    private static class DatabasePathLinear {

        private static DatabasePathLinear instance;
        private String host;
        private Integer port;
        private String params;
        private String schema;

        private DatabasePathLinear() {

        }

        public static DatabasePathLinear getInstance() {
            if (null == instance) {
                synchronized (DatabasePathLinear.class) {
                    if (null == instance) {
                        instance = new DatabasePathLinear();
                    }
                }
            }
            return instance;
        }

        DatabasePathLinear setHost(String host) {
            this.host = host;
            return this;
        }

        DatabasePathLinear setPort(Integer port) {
            this.port = port;
            return this;
        }

        DatabasePathLinear setParams(String params) {
            this.params = params;
            return this;
        }

        DatabasePathLinear setSchema(String schema) {
            this.schema = schema;
            return this;
        }

        String getPath() {
            String path = Constant.MYSQL_PATH_PREFIX + this.host + Constant.COLON + this.port;
            if (StringUtils.isNotBlank(schema)) {
                path += Constant.SLASH + schema;
            }
            return this.params == null ? path : path + this.params;
        }
    }
}
