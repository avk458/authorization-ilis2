package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;

import java.util.ArrayList;
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
    default List<String> commandBuilder(InitialConfig config) {
        ArrayList<String> command = new ArrayList<>(8);
        command.add(Constant.MYSQL_DUMP);
        command.add("-h" + config.getHost());
        command.add("-P" + config.getPort());
        command.add("-u" + config.getUsername());
        command.add("-p" + config.getPassword());
        if (config.getInitWithData()) {
            command.add("-d");
        }
        command.add(config.getSchemaName());
        return command;
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
        initFile.setConfigName(config.getName());
        initFile.setSqlFilePath(sqlPath);
        initFile.setErrorLogPath(logPath);
        return initFile;
    }

}
