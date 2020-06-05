package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;

/**
 * @author chenlm
 */
public class PostgreSqlDumper implements Exporter {

    @Override
    public InitFile export(MainSourceProfile config) throws BusinessException {
        return null;
    }

    @Override
    public void restore(TargetSourceProfile targetSource, UnitDatabase database, InitFile initFile) throws Exception {

    }
}
