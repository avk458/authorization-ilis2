package cn.hitek.authorization.ilis2.product.database.helper;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import org.apache.commons.lang3.StringUtils;

import java.sql.*;
import java.util.ArrayList;

/**
 * @author chenlm
 */
public class ConnectionHandler {

    public static Connection getConnection(UnitDatabase database) throws SQLException {
        DatabasePathLinear linear = DatabasePathLinear.getInstance();
        String path = linear.setHost(database.getHost())
                .setPort(database.getPort())
                .setParams(database.getParams())
                .getPath();
        String username = EncryptUtils.decrypt(database.getDatabaseUsername());
        String pwd = EncryptUtils.decrypt(database.getDatabasePwd());
        Connection connection = DriverManager.getConnection(path, username, pwd);
        connection.setAutoCommit(false);
        Statement statement = connection.createStatement();
        ResultSet dbResultSet = statement.executeQuery("SHOW DATABASES ");
        ArrayList<String> databases = new ArrayList<>(0);
        while (dbResultSet.next()) {
            databases.add(dbResultSet.getString("database"));
        }
        if (databases.contains(database.getDatabaseName())) {
            throw new BusinessException("数据库中有相同schema");
        } else {
            int rows = statement.executeUpdate("CREATE DATABASE " + database.getDatabaseName() + " CHARACTER SET utf8 COLLATE utf8_general_ci");
            if (1 == rows) {
                connection.commit();
                statement.execute("USE " + database.getDatabaseName());
            }
        }
        return connection;
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
