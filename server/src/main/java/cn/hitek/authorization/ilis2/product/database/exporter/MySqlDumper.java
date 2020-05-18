package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import lombok.extern.log4j.Log4j2;
import org.springframework.util.CollectionUtils;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author chenlm
 */
@Log4j2
public class MySqlDumper implements Exporter {

    @Override
    public InitFile export(InitialConfig config) throws Exception {
        long millis = System.currentTimeMillis();
        List<String> command = commandBuilder(config);
        ProcessBuilder processBuilder = new ProcessBuilder(command);
        String sqlFilePath = getCurrentWorkDirectory(InitFile.SQL_FILE, millis, config.getPath());
        String errorLogPath = getCurrentWorkDirectory(InitFile.LOG_FILE, millis, config.getPath());
        File sqlFile = new File(sqlFilePath);
        File error = new File(errorLogPath);
        processBuilder.redirectOutput(ProcessBuilder.Redirect.appendTo(sqlFile));
        processBuilder.redirectError(ProcessBuilder.Redirect.appendTo(error));
        Process process = processBuilder.start();
        process.waitFor();
        if (!config.getInitWithData() && !CollectionUtils.isEmpty(config.getInitDataTableSet())) {
            config.setNeedSecondCommands(true);
            List<String> secondCommands = commandBuilder(config);
            processBuilder.command(secondCommands);
            process = processBuilder.start();
            process.waitFor();
        }
        return createInitFile(config, sqlFilePath, errorLogPath);
    }

    @Override
    public void restore(InitialConfig activeConfig, UnitDatabase database, InitFile initFile) throws Exception {
        final List<String> commands = buildRestoreCommands(activeConfig, database);
        final ProcessBuilder builder = new ProcessBuilder(commands);
        builder.redirectError(ProcessBuilder.Redirect.appendTo(initFile.getLogFile()));
        builder.redirectInput(initFile.getSqlFile());
        Process process = builder.start();
        process.waitFor();
    }

    private List<String> buildRestoreCommands(InitialConfig activeConfig, UnitDatabase database) {
        ArrayList<String> command = new ArrayList<>(6);
        command.add(Constant.MYSQL);
        command.add("-h" + database.getHost());
        command.add("-P" + database.getPort());
        command.add("-u" + EncryptUtils.decrypt(activeConfig.getTargetDatabaseUsername()));
        command.add("-p" + EncryptUtils.decrypt(activeConfig.getTargetDatabasePwd()));
        command.add(database.getDatabaseName());
        return command;
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
        String password = config.getPassword();
        password = EncryptUtils.decrypt(password);
        command.add(Constant.MYSQL_DUMP);
        command.add("-h" + config.getHost());
        command.add("-P" + config.getPort());
        command.add("-u" + config.getUsername());
        command.add("-p" + password);
        if (!config.getInitWithData() && !config.isNeedSecondCommands()) {
            command.add("-d");
        }
        // dump with Database routines
        command.add("-R");
        // make sure this progress will not hang in metadata lock
        command.add("--single-transaction");
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
