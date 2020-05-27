package cn.hitek.authorization.ilis2.product.database.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.enums.DatabaseType;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
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
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hutool.core.io.file.FileReader;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.SneakyThrows;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.util.ResourceUtils;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.HashSet;
import java.util.List;
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
            Exporter dumper = Exporters.init(database.getDatabaseEnum());
            // 1. export
            Messenger.sendMessage(LogType.NORMAL, "正在从主数据源导出数据");
            initFile = dumper.export(config);
            readProcessLogAndSent2Client(initFile);
            Messenger.sendMessage(LogType.SUCCESS,
                    String.format("从主数据源导出数据成功，sql文件：%s，日志文件：%s",
                            initFile.getSqlFilePath(),
                            initFile.getProcessLogPath()));
            initFile.setUnitDatabaseId(database.getId());
            initFile.setUnitDatabaseName(database.getDatabaseName());
            Messenger.sendMessage(LogType.NORMAL, "开始新增数据库用户信息");
            initializeDatabaseUser(ConnectionHandler.getTargetConnection(config), database);
            Messenger.sendMessage(LogType.SUCCESS, "新增数据库用户信息成功");
            // 2. initialize
            Messenger.sendMessage(LogType.NORMAL, "开始初始化目标数据库");
            dumper.restore(config, database, initFile);
            Messenger.sendMessage(LogType.SUCCESS, String.format("数据库：%s 初始化成功！", database.getDatabaseName()));
            this.initFileService.save(initFile);
            database.setIsInitialized(UnitDatabase.INITIALIZED);
            super.updateById(database);
        } catch (BusinessException | SQLException e) {
            Messenger.sendMessage(LogType.ERROR, String.format("操作失败：%s", e.getMessage()));
            if (null != initFile) {
                File sql = new File(initFile.getSqlFilePath());
                if (sql.exists()) {
                    deleteFileWhenCatchException(sql.getParent());
                }
            }
            Messenger.sendMessage(LogType.NORMAL, "工作文件夹已清空");
            throw e;
        } catch (Exception e) {
            Messenger.sendMessage(LogType.ERROR, String.format("程序异常：%s", e.getMessage()));
            throw e;
        }
    }

    public void initializeDatabaseUser(Connection connection, UnitDatabase unitDatabase) throws SQLException {
        try {
            final String schema = unitDatabase.getDatabaseName();
            final String user = EncryptUtils.decrypt(unitDatabase.getDatabaseUsername()) + "@'%'";
            final String decryptPwd = EncryptUtils.decrypt(unitDatabase.getDatabasePwd());
            Statement statement = connection.createStatement();
            statement.execute("CREATE USER " + user + " IDENTIFIED BY '" + decryptPwd + "'");
            // statement.execute("GRANT ALL PRIVILEGES ON " + schema +".* " + "TO " + user);
            statement.execute("GRANT INSERT,DELETE,UPDATE,SELECT ON " + schema +".* " + "TO " + user);
            statement.execute("FLUSH PRIVILEGES ");
            statement.execute("CREATE DATABASE " + schema + " CHARACTER SET utf8 COLLATE utf8_general_ci");
        } finally {
            connection.close();
        }
    }

    private void readProcessLogAndSent2Client(InitFile initFile) throws IOException {
        FileReader fileReader = FileReader.create(initFile.getLogFile());
        List<String> logs = fileReader.readLines();
        for (String log : logs) {
            if (log.contains("error") || log.contains("ERROR")) {
                Messenger.sendMessage(LogType.ERROR, log);
                throw new BusinessException("Got error");
            } else {
                Messenger.sendMessage(LogType.WARN, log);
            }
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
        return query()
                .eq(StrUtil.isNotBlank(unitId), UnitDatabase::getUnitId, unitId)
                .eq(UnitDatabase::getIsInitialized, UnitDatabase.INITIALIZED)
                .exist();
    }

    @SneakyThrows
    @Override
    public boolean isDatabaseNameIllegally(String name) {
        File file = ResourceUtils.getFile("classpath:MySQLKeyWords.txt");
        FileReader fileReader = FileReader.create(file);
        Set<String> mySqlDatabaseNameKeyWords = new HashSet<>(fileReader.readLines());
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
        if (StrUtil.isNotBlank(databaseUsername)) {
            databaseUsername = EncryptUtils.encrypt(databaseUsername);
        }
        if (StrUtil.isNotBlank(databasePwd)) {
            databasePwd = EncryptUtils.encrypt(databasePwd);
        }
        entity.setDatabaseUsername(databaseUsername);
        entity.setDatabasePwd(databasePwd);
        return super.updateById(entity);
    }

    @Override
    public void createUnitDatabaseInfo(Unit unit) {
        String defaultName = "ilis_" + unit.getUniqCode();
        String encrypt = EncryptUtils.encrypt(defaultName);
        InitialConfig activeConfig = this.configService.getActiveConfig();
        UnitDatabase ud = new UnitDatabase();
        ud.setDatabaseUsername(encrypt);
        ud.setDatabasePwd(encrypt);
        ud.setDatabaseName(defaultName);
        ud.setDatabaseType(DatabaseType.MYSQL.getType());
        ud.setDatabaseVersion("5.7");
        ud.setHost(activeConfig.getTargetDatabaseHost());
        ud.setPort(activeConfig.getTargetDatabasePort());
        ud.setParams(Constant.PARAMS);
        ud.setUnitId(unit.getId());
        ud.setUnitName(unit.getName());
        save(ud);
    }
}
