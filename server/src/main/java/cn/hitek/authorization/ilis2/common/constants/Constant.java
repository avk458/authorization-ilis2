package cn.hitek.authorization.ilis2.common.constants;

import java.util.Arrays;
import java.util.List;

/**
 * @author chenlm
 */
public class Constant {

    public static final String DRIVER = "com.mysql.jdbc.Driver";
    public static final String MYSQL_PATH_PREFIX = "jdbc:mysql://";
    public static final List<String> SYSTEM_SCHEMA = Arrays.asList("mysql", "information_schema", "performance_schema", "sys");

    public static final String MYSQL_DUMP = "mysqldump";
    public static final String MYSQL = "mysql";
    public static final String PARAMS = "?characterEncoding=utf8&serverTimezone=Asia/Shanghai";
    public static final String ILIS_LOGIN_ONLINE_PREFIX = "ilis.login.log.online.";
    public static final String ILIS_LOGIN_OFFLINE_PREFIX = "ilis.login.log.offline.";
    public static final String ILIS_LOGIN_TOTAL_PREFIX = "ilis.login.log.total.";
    public static final String USER_ONLINE_SUFFIX = ".user.online.log";
}
