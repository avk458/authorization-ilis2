package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.enums.DatabaseType;

/**
 * @author chenlm
 */
public class Exporters {

    public static Exporter init(DatabaseType type) {
        switch (type) {
            case POSTGRE_SQL:
                return new PostgreSqlDumper();
            case MICROSOFT_SQL:
                return new MicrosoftSqlDumper();
            default:
                return new MySqlDumper();
        }
    }
}
