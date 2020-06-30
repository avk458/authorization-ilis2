package cn.hitek.authorization.ilis2.product.configuration.service.impl;

import cn.hitek.authorization.ilis2.common.constants.Constant;
import cn.hitek.authorization.ilis2.common.exception.BusinessException;
import cn.hitek.authorization.ilis2.common.utils.EncryptUtil;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.domain.vo.Folder;
import cn.hitek.authorization.ilis2.product.configuration.mapper.MainSourceProfileMapper;
import cn.hitek.authorization.ilis2.product.configuration.mapper.TargetSourceProfileMapper;
import cn.hitek.authorization.ilis2.product.configuration.service.ConfigService;
import cn.hitek.authorization.ilis2.product.data.management.domain.Schema;
import cn.hitek.authorization.ilis2.product.database.helper.ConnectionHandler;
import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;

import static cn.hitek.authorization.ilis2.product.database.helper.SqlUtil.executeQuery;

/**
 * @author chenlm
 */
@Service
@AllArgsConstructor
public class ConfigServiceImpl extends BaseServiceImpl<MainSourceProfileMapper, MainSourceProfile> implements ConfigService {

    private final TargetSourceProfileMapper targetSourceProfileMapper;

    @Override
    public void saveMainProfile(MainSourceProfile config) {
        config.setPassword(EncryptUtil.encrypt(config.getPassword()));
        if (MainSourceProfile.ACTIVE == config.getActive()) {
            setOtherConfigInactive();
        }
        save(config);
    }

    @Override
    public MainSourceProfile getActiveConfig() {
        return query().eq(MainSourceProfile::getActive, MainSourceProfile.ACTIVE).getOne();
    }

    @Override
    public List<Folder> getSystemFilePath(String path) {
        ArrayList<Folder> folders = new ArrayList<>(0);
        File[] files;
        Folder folder;
        if (StrUtil.isBlank(path)) {
            files = File.listRoots();
            for (File file : files) {
                folder = new Folder(file);
                folders.add(folder);
            }
            return folders;
        } else {
            File file = new File(path);
            files = file.listFiles();
        }
        if (null != files) {
            for (File file : files) {
                if (file.isDirectory() && file.canWrite() && !file.isHidden()) {
                    folders.add(new Folder(file));
                }
            }
        }
        return folders;
    }

    @Override
    public List<Map<String, String>> getTableList(MainSourceProfile config) throws SQLException {
        ArrayList<Map<String, String>> tables = new ArrayList<>(0);
        try (Connection connection = ConnectionHandler.getConnection(config)) {
            Statement statement = connection.createStatement();
            ResultSet rs = statement.executeQuery("SHOW TABLES ");
            int count = 0;
            while (rs.next()) {
                HashMap<String, String> table = new HashMap<>(8);
                table.put("value", count + "");
                table.put("label", rs.getString(1));
                tables.add(table);
                count++;
            }
        }
        return tables;
    }

    @Transactional(rollbackFor = Exception.class)
    @Override
    public void activeProfile(String configId) {
        MainSourceProfile config = getById(configId);
        if (!MainSourceProfile.ACTIVE == config.getActive()) {
            setOtherConfigInactive();
            config.setActive(MainSourceProfile.ACTIVE);
        } else {
            config.setActive(!MainSourceProfile.ACTIVE);
        }
        super.updateById(config);
    }

    private void setOtherConfigInactive() {
        MainSourceProfile activeConfig = this.getActiveConfig();
        if (null != activeConfig) {
            activeConfig.setActive(!MainSourceProfile.ACTIVE);
            super.updateById(activeConfig);
        }
    }

    @Override
    public boolean updateById(MainSourceProfile entity) {
        if (MainSourceProfile.ACTIVE == entity.getActive()) {
            setOtherConfigInactive();
        }
        String password = entity.getPassword();
        if (StrUtil.isNotBlank(password)) {
            entity.setPassword(EncryptUtil.encrypt(password));
        }
        return super.updateById(entity);
    }

    @Override
    public List<Map<String, String>> getDatabases(MainSourceProfile config) {
        ArrayList<Map<String, String>> list = new ArrayList<>(0);
        try (Connection connection = ConnectionHandler.getConnection(config)) {
            ResultSet rs = connection.createStatement().executeQuery("SHOW DATABASES ");
            while (rs.next()) {
                String db = rs.getString(1);
                if (!Constant.SYSTEM_SCHEMA.contains(db)) {
                    HashMap<String, String> schema = new HashMap<>(0);
                    schema.put("label", db);
                    schema.put("value", db);
                    list.add(schema);
                }
            }
        } catch (SQLException e) {
            throw new BusinessException("尝试连接数据库失败：" + e.getMessage());
        }
        return list;
    }

    @Override
    public List<TargetSourceProfile> getTargetProfiles() {
        return this.targetSourceProfileMapper.selectList(Wrappers.emptyWrapper());
    }

    @Override
    public void insertTargetProfile(TargetSourceProfile targetProfile) {
        targetProfile.setPassword(EncryptUtil.encrypt(targetProfile.getPassword()));
        this.targetSourceProfileMapper.insert(targetProfile);
    }

    @Override
    public void updateTargetProfile(TargetSourceProfile targetProfile) {
        TargetSourceProfile db = this.targetSourceProfileMapper.selectById(targetProfile.getId());
        String password = targetProfile.getPassword();
        if (StrUtil.isNotBlank(password)) {
            targetProfile.setPassword(EncryptUtil.encrypt(password));
        }
        // if any of the profile's host,port,username,password has been changed, then need redo connection valid
        touchProfileAvailable(db, targetProfile);
        this.targetSourceProfileMapper.updateById(targetProfile);
    }

    private void touchProfileAvailable(TargetSourceProfile dbOne, TargetSourceProfile newOne) {
        if (!dbOne.getAvailable()) {
            return;
        }
        if (!dbOne.getHost().equals(newOne.getHost())
                || !dbOne.getPort().equals(newOne.getPort())
                || !dbOne.getUsername().equals(newOne.getUsername())) {
            newOne.setAvailable(Boolean.FALSE);
        }
        if (StrUtil.isNotBlank(newOne.getPassword()) && !dbOne.getPassword().equals(newOne.getPassword())) {
            newOne.setAvailable(Boolean.FALSE);
        }
    }

    @Override
    public void deleteTargetProfile(String profileId) {
        this.targetSourceProfileMapper.deleteById(profileId);
    }

    @Override
    public boolean validateConnection(TargetSourceProfile profile) {
        if (StrUtil.isNotBlank(profile.getId())) {
            profile = this.targetSourceProfileMapper.selectById(profile.getId());
        } else {
            profile.setPassword(EncryptUtil.encrypt(profile.getPassword()));
        }
        boolean connected;
        try (Connection ignored = ConnectionHandler.getTargetConnection(profile)) {
            connected = true;
        } catch (SQLException e) {
            connected = false;
        }
        return connected;
    }

    @Override
    public TargetSourceProfile getTargetProfileViaId(String targetSource) {
        return this.targetSourceProfileMapper.selectById(targetSource);
    }

    @Override
    public Connection getTargetSourceConnection(String targetProfileId) throws SQLException {
        TargetSourceProfile profile = getTargetProfileViaId(targetProfileId);
        return ConnectionHandler.getTargetConnection(profile);
    }

    @Override
    public List<Schema> getMainSourceSchemas(String mainProfileId) {
        MainSourceProfile mainProfile = getById(mainProfileId);
        try (Connection connection = ConnectionHandler.getConnection(mainProfile)) {
            return getSchemaFromDatabase(connection);
        } catch (SQLException e) {
            return Collections.emptyList();
        }
    }

    @Override
    public List<Schema> getTargetSourceSchemas(String targetProfileId) {
        try (Connection connection = this.getTargetSourceConnection(targetProfileId)) {
            return getSchemaFromDatabase(connection);
        } catch (SQLException e) {
            return Collections.emptyList();
        }
    }

    private List<Schema> getSchemaFromDatabase(Connection connection) throws SQLException {
        ResultSet rs = executeQuery(connection, "SHOW DATABASES ");
        ArrayList<Schema> schemas = new ArrayList<>();
        while (rs.next()) {
            String s = rs.getString(1);
            Schema schema = new Schema(s, s, Constant.SYSTEM_SCHEMA.contains(s));
            schemas.add(schema);
        }
        return schemas;
    }
}
