package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtil;
import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import lombok.extern.log4j.Log4j2;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

/**
 * @author chenlm
 */
@Log4j2
public class MySqlDumper implements Exporter {

    @Override
    public InitFile export(MainSourceProfile profile) throws Exception {
        long millis = System.currentTimeMillis();
        List<String> command = commandBuilder(profile);
        ProcessBuilder processBuilder = new ProcessBuilder(command);
        String sqlFilePath = getCurrentWorkDirectory(InitFile.SQL_FILE, millis, profile.getPath());
        String errorLogPath = getCurrentWorkDirectory(InitFile.LOG_FILE, millis, profile.getPath());
        File sqlFile = new File(sqlFilePath);
        File error = new File(errorLogPath);
        processBuilder.redirectOutput(ProcessBuilder.Redirect.appendTo(sqlFile));
        processBuilder.redirectError(ProcessBuilder.Redirect.appendTo(error));
        Process process = processBuilder.start();
        process.waitFor();
        return createInitFile(profile, sqlFilePath, errorLogPath);
    }

    @Override
    public void restore(TargetSourceProfile targetSource, UnitDatabase database, InitFile initFile) throws Exception {
        final List<String> commands = buildRestoreCommands(targetSource, database);
        final ProcessBuilder builder = new ProcessBuilder(commands);
        builder.redirectError(ProcessBuilder.Redirect.appendTo(initFile.getLogFile()));
        builder.redirectInput(initFile.getSqlFile());
        Process process = builder.start();
        process.waitFor();
    }

    private List<String> buildRestoreCommands(TargetSourceProfile targetSource, UnitDatabase database) {
        ArrayList<String> command = new ArrayList<>(6);
        command.add(Constant.MYSQL);
        command.add("-h" + database.getHost());
        command.add("-P" + database.getPort());
        command.add("-u" + targetSource.getUsername());
        command.add("-p" + EncryptUtil.decrypt(targetSource.getPassword()));
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
    public List<String> commandBuilder(MainSourceProfile config) {
        ArrayList<String> command = new ArrayList<>(8);
        String password = config.getDecryptPassword();
        command.add(Constant.MYSQL_DUMP);
        command.add("-h" + config.getHost());
        command.add("-P" + config.getPort());
        command.add("-u" + config.getUsername());
        command.add("-p" + password);
        // make sure this progress will not hang in metadata lock
        command.add("--single-transaction");
        command.add("--hex-blob");
        command.add(config.getSourceSchema());
        return command;
    }
}
