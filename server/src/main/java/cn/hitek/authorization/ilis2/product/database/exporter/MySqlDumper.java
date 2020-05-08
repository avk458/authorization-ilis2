package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import lombok.extern.slf4j.Slf4j;
import org.springframework.util.CollectionUtils;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * @author chenlm
 */
@Slf4j
public class MySqlDumper implements Exporter {

    @Override
    public InitFile export(InitialConfig config) throws BusinessException {
        long millis = System.currentTimeMillis();
        List<String> command = commandBuilder(config);
        ProcessBuilder processBuilder = new ProcessBuilder(command);
        String sqlFilePath = getCurrentWorkDirectory(InitFile.SQL_FILE, millis, config.getPath());
        String errorLogPath = getCurrentWorkDirectory(InitFile.LOG_FILE, millis, config.getPath());
        File sqlFile = new File(sqlFilePath);
        File error = new File(errorLogPath);
        processBuilder.redirectOutput(ProcessBuilder.Redirect.appendTo(sqlFile));
        processBuilder.redirectError(ProcessBuilder.Redirect.appendTo(error));
        Process process = null;
        try {
            process = processBuilder.start();
            process.waitFor();
            if (!config.getInitWithData() && !CollectionUtils.isEmpty(config.getInitDataTableSet())) {
                config.setNeedSecondCommands(true);
                List<String> secondCommands = commandBuilder(config);
                processBuilder.command(secondCommands);
                process = processBuilder.start();
                process.waitFor();
            }
            return createInitFile(config, sqlFilePath, errorLogPath);
        } catch (IOException e) {
            log.warn("mysql dump processor fatal");
            throw new BusinessException("mysql dump 失败！");
        } catch (InterruptedException e) {
            log.warn("Interrupted!!! Processor will hang");
            throw new BusinessException("Interrupted!!! Processor will hang");
        } finally {
            if (null != process && process.isAlive()) {
                process.destroy();
            }
        }
    }

    private String getCurrentWorkDirectory(int fileType, long millis, String path) {
        path += File.separator + millis;
        File file = new File(path);
        file.mkdir();
        if (InitFile.SQL_FILE == fileType) {
            return path + File.separator + "init.sql";
        } else {
            return path + File.separator + "process.log";
        }
    }

    @Override
    public List<String> commandBuilder(InitialConfig config) {
        ArrayList<String> command = new ArrayList<>(8);
        command.add(Constant.MYSQL_DUMP);
        command.add("-h" + config.getHost());
        command.add("-P" + config.getPort());
        command.add("-u" + config.getUsername());
        command.add("-p" + config.getPassword());
        if (!config.getInitWithData() && !config.isNeedSecondCommands()) {
            command.add("-d");
        }
        command.add(config.getSchemaName());
        List<String> initDataTableSet = config.getInitDataTableSet();
        if (!CollectionUtils.isEmpty(initDataTableSet) && !config.getInitWithData() && !config.isNeedSecondCommands()) {
            initDataTableSet.forEach(s -> command.add("--ignore-table=" + config.getSchemaName() + "." + s));
        } else {
            command.addAll(initDataTableSet);
        }
        return command;
    }
}
