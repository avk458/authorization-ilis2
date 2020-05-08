package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
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
     * @throws BusinessException 抛出让用户知晓的业务异常
     */
    InitFile export(InitialConfig config) throws BusinessException;

    /**
     * 从配置类实体构建processBuilder dump命令
     * @param config 配置类
     * @return command
     */
    default List<String> commandBuilder(InitialConfig config){
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
    default InitFile createInitFile(InitialConfig config, String sqlPath, String logPath) {
        InitFile initFile = new InitFile();
        initFile.setConfigId(config.getId());
        initFile.setConfigName(config.getProfileName());
        initFile.setSqlFilePath(sqlPath);
        initFile.setProcessLogPath(logPath);
        return initFile;
    }

}
