package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.product.constants.DatabaseType;

/**
 * @author chenlm
 */
public abstract class AbstractExporter  implements Exporter {

    @Override
    public void export() throws RuntimeException {

    }

    public static Exporter getExporter(DatabaseType type) {
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
