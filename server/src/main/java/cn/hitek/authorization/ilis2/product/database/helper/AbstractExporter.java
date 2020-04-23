package cn.hitek.authorization.ilis2.product.database.helper;

import cn.hitek.authorization.ilis2.product.constants.DatabaseType;

/**
 * @author chenlm
 */
public abstract class AbstractExporter  implements Exporter {

    @Override
    public void export() throws RuntimeException {

    }

    protected static Exporter getExporter(DatabaseType type) {
        switch (type.getType()) {
            default:
                return new MySqlDumper();
        }
    }
}
