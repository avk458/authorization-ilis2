package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;

/**
 * @author chenlm
 */
public class PostgreSqlDumper implements Exporter {

    @Override
    public InitFile export(InitialConfig config) throws BusinessException {
        return null;
    }

    @Override
    public void restore(InitialConfig activeConfig, UnitDatabase database, InitFile initFile) throws Exception {

    }
}
