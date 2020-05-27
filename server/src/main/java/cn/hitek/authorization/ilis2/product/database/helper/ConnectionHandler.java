package cn.hitek.authorization.ilis2.product.database.helper;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hutool.core.util.StrUtil;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author chenlm
 */
public class ConnectionHandler {

    public static Connection getTargetConnection(InitialConfig config) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(config.getTargetDatabaseHost())
                .setPort(config.getTargetDatabasePort())
                .setSchema(null)
                .getPath();
        path += Constant.PARAMS;
        return DriverManager.getConnection(path, config.getDecryptTargetDatabaseUsername(), config.getDecryptTargetDatabasePwd());
    }

    public static Connection getConnection(UnitDatabase unitDatabase) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(unitDatabase.getHost())
                .setPort(unitDatabase.getPort())
                .setSchema(unitDatabase.getDatabaseName())
                .setParams(unitDatabase.getParams())
                .getPath();
        return DriverManager.getConnection(path, EncryptUtils.decrypt(unitDatabase.getDatabaseUsername()), EncryptUtils.decrypt(unitDatabase.getDatabasePwd()));
    }

    public static Connection getConnection(InitialConfig config) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(config.getHost())
                .setPort(config.getPort())
                .setSchema(config.getSchemaName())
                .getPath();
        path += Constant.PARAMS;
        return DriverManager.getConnection(path, config.getUsername(), config.getDecryptPassword());
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
            if (StrUtil.isNotBlank(schema)) {
                path += Constant.SLASH + schema;
            }
            return this.params == null ? path : path + this.params;
        }
    }
}
