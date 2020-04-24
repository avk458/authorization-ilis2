package cn.hitek.authorization.ilis2.product.database.exporter;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.product.init.config.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.io.IOException;
import java.util.List;

/**
 * @author chenlm
 */
@Slf4j
public class MySqlDumper implements Exporter {

    @Override
    public InitFile export(InitialConfig config) throws BusinessException {
        List<String> command = commandBuilder(config);
        ProcessBuilder processBuilder = new ProcessBuilder(command);
        String sqlFilePath = config.getPath() + File.separator + System.currentTimeMillis() + ".sql";
        String errorLogPath = config.getPath() + File.separator + "error.log";
        File sqlFile = new File(sqlFilePath);
        File error = new File(errorLogPath);
        processBuilder.redirectOutput(sqlFile);
        processBuilder.redirectError(error);
        Process process = null;
        try {
            process = processBuilder.start();
            process.waitFor();
            // new BufferedReader()
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
}
