package cn.hitek.authorization.ilis2.product.database.helper;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * @author chenlm
 */
public class ConnectionHandler {

    public static Connection getConnection(UnitDatabase database) throws SQLException {
        DatabasePathLiner linear = DatabasePathLiner.getInstance();
        String path = linear.setHost(database.getHost())
                .setPort(database.getPort())
                .setParams(database.getParams())
                .getPath();
        String username = EncryptUtils.decrypt(database.getDatabaseUsername());
        String pwd = EncryptUtils.decrypt(database.getDatabasePwd());
        return DriverManager.getConnection(path, username, pwd);
    }

    private static class DatabasePathLiner {

        private static DatabasePathLiner instance;
        private String host;
        private Integer port;
        private String params;

        private DatabasePathLiner() {

        }

        public static DatabasePathLiner getInstance() {
            if (null == instance) {
                synchronized (DatabasePathLiner.class) {
                    if (null == instance) {
                        instance = new DatabasePathLiner();
                    }
                }
            }
            return instance;
        }

        DatabasePathLiner setHost(String host) {
            this.host = host;
            return this;
        }

        DatabasePathLiner setPort(Integer port) {
            this.port = port;
            return this;
        }

        DatabasePathLiner setParams(String params) {
            this.params = params;
            return this;
        }

        String getPath() {
            String path = Constant.MYSQL_PATH_PREFIX + this.host + Constant.COLON + this.port;
            return this.params == null ? path : path + this.params;
        }
    }
}
