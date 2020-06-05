package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;

import java.util.Collections;
import java.util.List;

/**
 * @author chenlm
 */
public interface Exporter {

    /**
     * 从数据库中导出
     * @param config 配置信息
     * @return init file
     * @throws Exception runtime exception
     */
    InitFile export(MainSourceProfile config) throws Exception;

    /**
     * restore database base on dump file
     * @param targetSource active config
     * @param initFile etc sql file log file
     * @param database database info
     * @throws Exception runtime exception
     */
    void restore(TargetSourceProfile targetSource, UnitDatabase database, InitFile initFile) throws Exception;

    /**
     * 从配置类实体构建processBuilder dump命令
     * @param config 配置类
     * @return command
     */
    default List<String> commandBuilder(MainSourceProfile config){
        // do nothing
        return Collections.emptyList();
    }

    /**
     * 创建完成导出后文件
     * @param config 配置类
     * @param sqlPath sql地址
     * @param logPath log地址
     * @return init
     */
    default InitFile createInitFile(MainSourceProfile config, String sqlPath, String logPath) {
        InitFile initFile = new InitFile();
        initFile.setConfigId(config.getId());
        initFile.setConfigName(config.getProfileName());
        initFile.setSqlFilePath(sqlPath);
        initFile.setProcessLogPath(logPath);
        return initFile;
    }

}
