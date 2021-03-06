package cn.hitek.authorization.ilis2.product.database.helper;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtil;
import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.StringPool;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author chenlm
 */
public class ConnectionHandler {

    public synchronized static Connection getTargetConnection(TargetSourceProfile profile) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(profile.getHost())
                .setPort(profile.getPort())
                .setSchema(null)
                .getPath();
        path += Constant.PARAMS;
        return DriverManager.getConnection(
                path,
                profile.getUsername(),
                EncryptUtil.decrypt(profile.getPassword()));
    }

    public static Connection getConnection(UnitDatabase unitDatabase) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(unitDatabase.getHost())
                .setPort(unitDatabase.getPort())
                .setSchema(unitDatabase.getDatabaseName())
                .setParams(unitDatabase.getParams())
                .getPath();
        return DriverManager.getConnection(path, EncryptUtil.decrypt(unitDatabase.getDatabaseUsername()), EncryptUtil.decrypt(unitDatabase.getDatabasePwd()));
    }

    public static Connection getConnection(MainSourceProfile config) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(config.getHost())
                .setPort(config.getPort())
                .setSchema(config.getSourceSchema())
                .getPath();
        path += Constant.PARAMS;
        return DriverManager.getConnection(path, config.getUsername(), config.getDecryptPassword());
    }

    public synchronized static String getTargetPath(UnitDatabase unitDatabase) {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        return linear.setHost(unitDatabase.getHost())
                .setPort(unitDatabase.getPort())
                .setSchema(unitDatabase.getDatabaseName())
                .setParams(Constant.PARAMS)
                .getPath();
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
            String path = Constant.MYSQL_PATH_PREFIX + this.host + StringPool.COLON + this.port;
            if (StrUtil.isNotBlank(schema)) {
                path += StringPool.SLASH + schema;
            }
            return this.params == null ? path : path + this.params;
        }
    }
}
