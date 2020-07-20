package cn.hitek.authorization.ilis2.product.database.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.enums.DatabaseType;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtil;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.event.UpdateDatabaseEvent;
import cn.hitek.authorization.ilis2.product.configuration.service.ConfigService;
import cn.hitek.authorization.ilis2.product.data.script.domain.DataScript;
import cn.hitek.authorization.ilis2.product.data.script.service.DataScriptService;
import cn.hitek.authorization.ilis2.product.database.domain.UnitDatabase;
import cn.hitek.authorization.ilis2.product.database.domain.vo.UpdateEchoLog;
import cn.hitek.authorization.ilis2.product.database.exporter.Exporter;
import cn.hitek.authorization.ilis2.product.database.exporter.Exporters;
import cn.hitek.authorization.ilis2.product.database.helper.ConnectionHandler;
import cn.hitek.authorization.ilis2.product.database.mapper.UnitDatabaseMapper;
import cn.hitek.authorization.ilis2.product.database.service.UnitDatabaseService;
import cn.hitek.authorization.ilis2.product.init.file.domain.InitFile;
import cn.hitek.authorization.ilis2.product.init.file.service.InitFileService;
import cn.hitek.authorization.ilis2.product.unit.domain.Unit;
import cn.hutool.core.io.file.FileReader;
import cn.hutool.core.io.file.FileWriter;
import cn.hutool.core.util.RandomUtil;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import lombok.SneakyThrows;
import lombok.extern.log4j.Log4j2;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.event.EventListener;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.jdbc.datasource.DriverManagerDataSource;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import javax.sql.DataSource;
import java.io.File;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
import java.util.concurrent.CompletableFuture;
import java.util.concurrent.Executor;
import java.util.stream.Collectors;


/**
 * @author chenlm
 */
@Service
@Log4j2
@AllArgsConstructor
public class UnitDatabaseServiceImpl extends BaseServiceImpl<UnitDatabaseMapper, UnitDatabase> implements UnitDatabaseService {

    private final InitFileService initFileService;
    private final ConfigService configService;
    private final DataScriptService scriptService;
    @Qualifier("asyncExecutor")
    private final Executor asyncExecutor;

    @SneakyThrows
    @Override
    public void initUnitDatabase(String unitDatabaseId) {
        InitFile initFile = null;
        try {
            UnitDatabase database = getById(unitDatabaseId);
            Objects.requireNonNull(database, "database info error");
            if (!database.getManageAble()) {
                return;
            }
            detectUnitDatabaseQualified(database);
            MainSourceProfile mainProfile = this.configService.getActiveConfig();
            Objects.requireNonNull(mainProfile, "can't find active database initial configuration");
            Exporter dumper = Exporters.init(database.getDatabaseEnum());
            // 1. export
            initFile = dumper.export(mainProfile);
            readProcessLogAndSent2Client(initFile);
            initFile.setUnitDatabaseId(database.getId());
            initFile.setUnitDatabaseName(database.getDatabaseName());
            TargetSourceProfile targetProfile = this.configService.getTargetProfileViaId(database.getTargetProfileId());
            initializeDatabaseUser(ConnectionHandler.getTargetConnection(targetProfile), database);
            // 2. initialize
            dumper.restore(targetProfile, database, initFile);
            this.initFileService.save(initFile);
            database.setIsInitialized(UnitDatabase.INITIALIZED);
            super.updateById(database);
        } catch (BusinessException | SQLException e) {
            if (null != initFile) {
                File sql = new File(initFile.getSqlFilePath());
                if (sql.exists()) {
                    deleteFileWhenCatchException(sql.getParent());
                }
            }
            throw e;
        } catch (Exception e) {
            e.printStackTrace();
            throw new BusinessException("数据库初始化失败！");
        }
    }

    public void initializeDatabaseUser(Connection connection, UnitDatabase unitDatabase) throws SQLException {
        try {
            final String schema = unitDatabase.getDatabaseName();
            final String user = EncryptUtil.decrypt(unitDatabase.getDatabaseUsername()) + "@'%'";
            final String decryptPwd = EncryptUtil.decrypt(unitDatabase.getDatabasePwd());
            Statement statement = connection.createStatement();
            statement.execute("CREATE USER " + user + " IDENTIFIED BY '" + decryptPwd + "'");
            // statement.execute("GRANT ALL PRIVILEGES ON " + schema +".* " + "TO " + user);
            statement.execute("GRANT INSERT,DELETE,UPDATE,SELECT ON " + schema + ".* " + "TO " + user);
            statement.execute("FLUSH PRIVILEGES ");
            statement.execute("CREATE DATABASE " + schema + " CHARACTER SET utf8 COLLATE utf8_general_ci");
        } finally {
            connection.close();
        }
    }

    private void readProcessLogAndSent2Client(InitFile initFile) {
        FileReader fileReader = FileReader.create(initFile.getLogFile());
        List<String> logs = fileReader.readLines();
        for (String log : logs) {
            if (log.contains("error") || log.contains("ERROR")) {
                throw new BusinessException("Got error");
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

    @Override
    public boolean isDatabaseNameIllegally(String name) {
        String path = UnitDatabaseServiceImpl.class.getResource("MySQLKeyWords.txt").getPath();
        File file = new File(path);
        if (!file.exists()) {
            FileWriter.create(file).writeFromStream(UnitDatabaseServiceImpl.class.getClassLoader().getResourceAsStream("classpath:MySQLKeyWords.txt"));
        }
        FileReader fileReader = FileReader.create(file);
        Set<String> mySqlDatabaseNameKeyWords = new HashSet<>(fileReader.readLines());
        return mySqlDatabaseNameKeyWords.contains(name.toLowerCase());
    }

    @Override
    public void removeUnitDatabaseInfoViaUnitId(String unitId) {
        boolean existInitialized = query().eq(UnitDatabase::getUnitId, unitId)
                .eq(UnitDatabase::getIsInitialized, UnitDatabase.INITIALIZED).exist();
        if (existInitialized) {
            throw new BusinessException("删除失败！不能删除正在使用的数据库信息");
        }
        remove(Wrappers.lambdaQuery(UnitDatabase.class).eq(UnitDatabase::getUnitId, unitId));
    }

    @Override
    public boolean save(UnitDatabase entity) {
        entity.setDatabaseUsername(EncryptUtil.encrypt(entity.getDatabaseUsername()));
        entity.setDatabasePwd(EncryptUtil.encrypt(entity.getDatabasePwd()));
        return super.save(entity);
    }

    @Override
    public boolean updateById(UnitDatabase entity) {
        UnitDatabase dbEntity = getById(entity.getId());
        String databaseUsername = entity.getDatabaseUsername();
        String databasePwd = entity.getDatabasePwd();
        if (StrUtil.isNotBlank(databaseUsername)) {
            renameDatabaseUsername(EncryptUtil.decrypt(dbEntity.getDatabaseUsername()), databaseUsername, entity.getTargetProfileId());
            databaseUsername = EncryptUtil.encrypt(databaseUsername);
        }
        if (StrUtil.isNotBlank(databasePwd)) {
            alterDatabasePassword(dbEntity, entity, entity.getTargetProfileId());
            databasePwd = EncryptUtil.encrypt(databasePwd);
        }
        entity.setDatabaseUsername(databaseUsername);
        entity.setDatabasePwd(databasePwd);
        return super.updateById(entity);
    }

    private void alterDatabasePassword(UnitDatabase dbEntity, UnitDatabase entity, String profileId) {
        try (Connection connection = this.configService.getTargetSourceConnection(profileId)) {
            String username = EncryptUtil.decrypt(dbEntity.getDatabaseUsername()).equals(entity.getDatabaseUsername())
                    ? dbEntity.getDatabaseUsername() : entity.getDatabaseUsername();
            Statement statement = connection.createStatement();
            statement.execute("ALTER USER '" + username + "'@'%' IDENTIFIED BY '" + entity.getDatabasePwd() + "'");
            statement.execute("FLUSH PRIVILEGES ");
        } catch (SQLException e) {
            throw new BusinessException("修改数据密码出错：" + e.getMessage());
        }
    }

    private void renameDatabaseUsername(String dbUsername, String username, String profileId) {
        try (Connection connection = this.configService.getTargetSourceConnection(profileId)) {
            Statement statement = connection.createStatement();
            statement.execute("RENAME USER '" + dbUsername + "'@'%'" +
                    "TO '" + username + "'@'%'");
            statement.execute("FLUSH PRIVILEGES ");
        } catch (SQLException e) {
            throw new BusinessException("修改数据用户名出错：" + e.getMessage());
        }
    }

    @Override
    public String createUnitDatabaseInfo(Unit unit) {
        TargetSourceProfile targetProfile = this.configService.getTargetProfileViaId(unit.getTargetSourceId());
        String defaultName = "ilis_" + unit.getUniqCode();
        UnitDatabase ud = new UnitDatabase();
        ud.setDatabaseUsername(defaultName);
        ud.setDatabasePwd(defaultName);
        ud.setDatabaseName(defaultName);
        ud.setDatabaseType(DatabaseType.MYSQL.getType());
        ud.setDatabaseVersion("5.7");
        ud.setHost(targetProfile.getHost());
        ud.setPort(targetProfile.getPort());
        ud.setParams(Constant.PARAMS);
        ud.setUnitId(unit.getId());
        ud.setUnitName(unit.getName());
        ud.setTargetProfile(targetProfile.getProfileName());
        ud.setTargetProfileId(targetProfile.getId());
        // 有前置保障，每次提交脚本在标准库执行
        ud.setDataVersion(this.scriptService.getLastDataScriptId());
        ud.setManageAble(targetProfile.getAvailable());
        save(ud);
        return ud.getId();
    }

    @Async("asyncExecutor")
    @EventListener
    public void updateDatabaseManageAbleListener(UpdateDatabaseEvent event) {
        String targetProfileId = event.getTargetProfileId();
        List<UnitDatabase> list = query().eq(UnitDatabase::getTargetProfileId, targetProfileId).list();
        list.stream().filter(ud -> !ud.getManageAble()).forEach(ud -> ud.setManageAble(UnitDatabase.MANAGE_ABLE));
        super.updateBatchById(list);
    }

    @Override
    public List<UpdateEchoLog> updateDatabase(String id) {
        UnitDatabase database = getById(id);
        return updateEachDatabase(database);
    }

    private List<UpdateEchoLog> updateEachDatabase(UnitDatabase database) {
        DataSource dataSource = initTargetDataSource(database);
        JdbcTemplate template = new JdbcTemplate(dataSource);
        DataSourceTransactionManager manager = new DataSourceTransactionManager(dataSource);
        ArrayList<UpdateEchoLog> results = new ArrayList<>(0);
        List<DataScript> scripts = this.scriptService.getScriptRange(database.getDataVersion());
        for (DataScript script : scripts) {
            UpdateEchoLog execute = executeScript(manager, template, script, database.getUnitName());
            results.add(execute);
            if (!execute.getSuccess()) {
                break;
            }
            database.setDataVersion(script.getId());
        }
        if (!database.isStandardSchema()) {
            super.updateById(database);
        }
        return results;
    }

    private DataSource initTargetDataSource(UnitDatabase database) {
        final String path = ConnectionHandler.getTargetPath(database);
        final String username;
        final String password;
        if (database.isStandardSchema()) {
            username = database.getDatabaseUsername();
            password = database.getDatabasePwd();
        } else {
            TargetSourceProfile profile = this.configService.getTargetProfileViaId(database.getTargetProfileId());
            username = profile.getUsername();
            password = EncryptUtil.decrypt(profile.getPassword());
        }
        return new DriverManagerDataSource(path, username, password);
    }

    private UpdateEchoLog executeScript(DataSourceTransactionManager manager,
                                        JdbcTemplate template,
                                        DataScript dataScript,
                                        String unitName) {
        String script = dataScript.getScript();
        UpdateEchoLog log = new UpdateEchoLog(dataScript.getId(), script, unitName);
        TransactionStatus status = null;
        try {
            switch (dataScript.getType()) {
                case DDL:
                    template.execute(script);
                    log.setSuccess(Boolean.TRUE);
                    break;
                case DML:
                    status = manager.getTransaction(new DefaultTransactionDefinition());
                    template.batchUpdate(script.split(";"));
                    log.setSuccess(Boolean.TRUE);
                    manager.commit(status);
                    break;
                default:
            }
        } catch (DataAccessException e) {
            log.setSuccess(Boolean.FALSE);
            e.printStackTrace();
            SQLException se = (SQLException) e.getCause();
            log.setMsg(se.getMessage());
            if (status != null) {
                manager.rollback(status);
            }
        }
        return log;
    }

    @Override
    public Map<String, Long> getDatabaseVersionAndScriptVersion(Unit unit) {
        Long version = this.scriptService.getLastDataScriptId();
        UnitDatabase database = query().eq(UnitDatabase::getUnitId, unit.getId()).getOne();
        HashMap<String, Long> result = new HashMap<>(0);
        result.put("databaseVersion", database.getDataVersion());
        result.put("scriptVersion", version);
        return result;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void updateDatabaseDataVersion(String unitId, Long version) {
        UnitDatabase database = query().eq(UnitDatabase::getUnitId, unitId).getOne();
        database.setDataVersion(version);
        baseMapper.updateDataVersion(database.getId(), version);
    }

    @Override
    public List<UpdateEchoLog> batchUpdateDatabase() {
        List<UnitDatabase> databases = query().eq(UnitDatabase::getManageAble, UnitDatabase.MANAGE_ABLE).list();
        List<CompletableFuture<List<UpdateEchoLog>>> futures = databases
                .stream()
                .map(d -> CompletableFuture.completedFuture(d)
                        .thenApplyAsync(this::updateEachDatabase, asyncExecutor))
                .collect(Collectors.toList());
        return futures
                .stream()
                .map(CompletableFuture::join)
                .flatMap(List::stream)
                .collect(Collectors.toList());
    }

    @Override
    public boolean executeInStandardSchemas(DataScript script) {
        script.setId(RandomUtil.randomLong());
        List<MainSourceProfile> profiles = configService.query().list();
        List<CompletableFuture<UpdateEchoLog>> futures = profiles
                .stream()
                .map(this::generateStandardDatabase)
                .map(sd -> CompletableFuture.completedFuture(sd)
                        .thenApplyAsync(sdf -> this.preExecute(sdf, script)))
                .collect(Collectors.toList());
        List<UpdateEchoLog> logs = futures.stream().map(CompletableFuture::join).collect(Collectors.toList());
        return logs.stream().allMatch(UpdateEchoLog::getSuccess);
    }

    private UpdateEchoLog preExecute(UnitDatabase sd, DataScript script) {
        DataSource dataSource = initTargetDataSource(sd);
        JdbcTemplate template = new JdbcTemplate(dataSource);
        DataSourceTransactionManager manager = new DataSourceTransactionManager(dataSource);
        return executeScript(manager, template, script, "standard");
    }

    private UnitDatabase generateStandardDatabase(MainSourceProfile mainSourceProfile) {
        UnitDatabase standardDatabase = new UnitDatabase();
        standardDatabase.setDatabaseName(mainSourceProfile.getSourceSchema());
        standardDatabase.setHost(mainSourceProfile.getHost());
        standardDatabase.setPort(mainSourceProfile.getPort());
        standardDatabase.setDatabaseUsername(mainSourceProfile.getUsername());
        standardDatabase.setDatabasePwd(mainSourceProfile.getDecryptPassword());
        standardDatabase.setStandardSchema(true);
        return standardDatabase;
    }

    private UnitDatabase generateStandardDatabase(MainSourceProfile mainSourceProfile, Long dataVersion) {
        UnitDatabase standardDatabase = generateStandardDatabase(mainSourceProfile);
        standardDatabase.setDataVersion(dataVersion);
        standardDatabase.setUnitName("standard");
        return standardDatabase;
    }

    @Override
    public void updateStandardSchema(Long dataVersion) {
        List<MainSourceProfile> profiles = configService.query().list();
        List<CompletableFuture<List<UpdateEchoLog>>> futures = profiles
                .stream()
                .map(profile -> this.generateStandardDatabase(profile, dataVersion))
                .map(d -> CompletableFuture.completedFuture(d)
                        .thenApplyAsync(this::updateEachDatabase, asyncExecutor))
                .collect(Collectors.toList());
        List<UpdateEchoLog> logs = futures.stream().map(CompletableFuture::join).flatMap(List::stream).collect(Collectors.toList());
        log.info("标准库执行脚本更新完毕，执行脚本 {} 条", logs.size());
    }
}
