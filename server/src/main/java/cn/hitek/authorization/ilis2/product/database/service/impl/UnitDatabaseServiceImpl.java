package cn.hitek.authorization.ilis2.product.database.service.impl;

import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.common.utils.FileUtil;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.exporter.Exporter;
import cn.hitek.authorization.ilis2.product.database.exporter.Exporters;
import cn.hitek.authorization.ilis2.product.database.helper.ConnectionHandler;
import cn.hitek.authorization.ilis2.product.database.helper.LogType;
import cn.hitek.authorization.ilis2.product.database.manager.Messenger;
import cn.hitek.authorization.ilis2.product.database.mapper.UnitDatabaseMapper;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.configuration.service.InitialConfigService;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import cn.hitek.authorization.ilis2.product.init.file.service.InitFileService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.ibatis.jdbc.ScriptRunner;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.Connection;
import java.util.Objects;
import java.util.Set;


/**
 * @author chenlm
 */
@Service
@Slf4j
public class UnitDatabaseServiceImpl extends BaseServiceImpl<UnitDatabaseMapper, UnitDatabase> implements UnitDatabaseService {

    private final InitFileService initFileService;
    private final InitialConfigService configService;

    public UnitDatabaseServiceImpl(InitialConfigService configService, InitFileService initFileService) {
        this.configService = configService;
        this.initFileService = initFileService;
    }

    @SneakyThrows
    @Override
    public void initUnitDatabase(String unitDatabaseId) {
        InitFile initFile = null;
        try {
            Messenger.sendMessage(LogType.NORMAL, "准备获取单位数据库信息");
            UnitDatabase database = getById(unitDatabaseId);
            Objects.requireNonNull(database, "database info error");
            Messenger.sendMessage(LogType.SUCCESS, "获取单位数据库信息成功");
            detectUnitDatabaseQualified(database);
            Messenger.sendMessage(LogType.SUCCESS, "单位数据库验证成功");
            Messenger.sendMessage(LogType.NORMAL, "准备获取单位配置信息");
            InitialConfig config = this.configService.getActiveConfig();
            Objects.requireNonNull(config, "can't find active database initial configuration");
            Messenger.sendMessage(LogType.SUCCESS, "获取单位配置信息成功");
            Messenger.sendMessage(LogType.NORMAL, "准备主数据源");
            // 1. export
            Exporter dumper = Exporters.init(database.getDatabaseEnum());
            initFile = dumper.export(config);
            try (BufferedReader logReader = new BufferedReader(new FileReader(new File(initFile.getProcessLogPath())))) {
                String line;
                while (StringUtils.isNotBlank(line = logReader.readLine())) {
                    if (line.contains("error")) {
                        Messenger.sendMessage(LogType.ERROR, line);
                        throw new BusinessException("Got error");
                    } else {
                        Messenger.sendMessage(LogType.WARN, line);
                    }
                }
            }
            Messenger.sendMessage(LogType.SUCCESS,
                    String.format("从主数据源导出数据成功，sql文件：%s，日志文件：%s",
                            initFile.getSqlFilePath(),
                            initFile.getProcessLogPath()));
            // 2. initialize
            Messenger.sendMessage(LogType.NORMAL, "准备初始化数据库");
            Connection connection = ConnectionHandler.getConnection(database);
            ScriptRunner runner = new ScriptRunner(connection);
            File sql = new File(initFile.getSqlFilePath());
            Messenger.sendMessage(LogType.NORMAL, "准备运行脚本");
            try (BufferedReader sqlReader = new BufferedReader(new FileReader(sql))) {
                runner.runScript(sqlReader);
            }
            Messenger.sendMessage(LogType.SUCCESS, String.format("数据库：%s 初始化成功！", database.getDatabaseName()));
            initFile.setUnitDatabaseId(database.getId());
            initFile.setUnitDatabaseName(database.getDatabaseName());
            this.initFileService.save(initFile);
            database.setIsInitialized(UnitDatabase.INITIALIZED);
            super.updateById(database);
        } catch (BusinessException e) {
            Messenger.sendMessage(LogType.ERROR, String.format("业务错误：%s", e.getMessage()));
            if (null != initFile) {
                File sql = new File(initFile.getSqlFilePath());
                if (sql.exists()) {
                    deleteFileWhenCatchException(sql.getParent());
                }
            }
            Messenger.sendMessage(LogType.NORMAL, "工作文件夹已清空");
            throw e;
        } catch (Exception e) {
            Messenger.sendMessage(LogType.ERROR, String.format("系统错误：%s", e.getMessage()));
            throw e;
        }
    }

    private void deleteFileWhenCatchException(String path) {
        File file = new File(path);
        File[] files = file.listFiles();
        if (null != files) {
            for (File f : files) {
                if (f.isDirectory()) {
                    deleteFileWhenCatchException(f.getPath());
                } else {
                    boolean delete = f.delete();
                    if (!delete) {
                        log.warn("删除文件失败：{}", f.getPath());
                    }
                }
            }
        }
        boolean delete = file.delete();
        if (!delete) {
            log.warn("删除文件失败：{}", file.getPath());
        }
    }

    private void detectUnitDatabaseQualified(UnitDatabase database) {
        boolean exist = query().eq(UnitDatabase::getUnitId, database.getUnitId())
                .eq(UnitDatabase::getIsInitialized, UnitDatabase.INITIALIZED)
                .exist();
        if (exist) {
            throw new BusinessException("检测到该单位下有已初始化的数据库不允许再次初始化");
        }
    }

    @Override
    public boolean isUnitDatabaseInitialized(String unitId) {
        return query().eq(StringUtils.isNotBlank(unitId), UnitDatabase::getUnitId, unitId)
                .eq(UnitDatabase::getIsInitialized, UnitDatabase.INITIALIZED)
                .exist();
    }

    @Override
    public boolean isDatabaseNameIllegally(String name) {
        Set<String> mySqlDatabaseNameKeyWords = FileUtil.getMySqlDatabaseNameKeyWords();
        return mySqlDatabaseNameKeyWords.contains(name.toLowerCase());
    }

    @Override
    public void removeUnitDatabaseInfoViaUnitId(String unitId) {
        boolean existInitialized = query().eq(UnitDatabase::getUnitId, unitId)
                .eq(UnitDatabase::getIsInitialized, !UnitDatabase.INITIALIZED).exist();
        if (existInitialized) {
            throw new BusinessException("删除失败！不能删除正在使用的数据库信息");
        }
        remove(Wrappers.lambdaQuery(UnitDatabase.class).eq(UnitDatabase::getUnitId, unitId));
    }

    @Override
    public boolean save(UnitDatabase entity) {
        entity.setDatabaseUsername(EncryptUtils.encrypt(entity.getDatabaseUsername()));
        entity.setDatabasePwd(EncryptUtils.encrypt(entity.getDatabasePwd()));
        return super.save(entity);
    }

    @Override
    public boolean updateById(UnitDatabase entity) {
        String databaseUsername = entity.getDatabaseUsername();
        String databasePwd = entity.getDatabasePwd();
        if (StringUtils.isNotBlank(databaseUsername)) {
            databaseUsername = EncryptUtils.encrypt(databaseUsername);
        }
        if (StringUtils.isNotBlank(databasePwd)) {
            databasePwd = EncryptUtils.encrypt(databasePwd);
        }
        entity.setDatabaseUsername(databaseUsername);
        entity.setDatabasePwd(databasePwd);
        return super.updateById(entity);
    }
}
