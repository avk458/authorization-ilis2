package cn.hitek.authorization.ilis2.product.init.configuration.service.impl;

import cn.hitek.authorization.ilis2.common.utils.EncryptUtils;
import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.database.helper.ConnectionHandler;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.vo.Folder;
import cn.hitek.authorization.ilis2.product.init.configuration.mapper.InitialConfigMapper;
import cn.hitek.authorization.ilis2.product.init.configuration.service.InitialConfigService;
import cn.hutool.core.util.StrUtil;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.File;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
@Service
public class InitialConfigServiceImpl extends BaseServiceImpl<InitialConfigMapper, InitialConfig> implements InitialConfigService {

    @Override
    public void saveInitialConfig(InitialConfig config) {
        config.setPassword(EncryptUtils.encrypt(config.getPassword()));
        config.setTargetDatabaseUsername(EncryptUtils.encrypt(config.getTargetDatabaseUsername()));
        config.setTargetDatabasePwd(EncryptUtils.encrypt(config.getTargetDatabasePwd()));
        if (InitialConfig.ACTIVE == config.getActive()) {
            setOtherConfigInactive();
        }
        save(config);
    }

    @Override
    public InitialConfig getActiveConfig() {
        return query().eq(InitialConfig::getActive, InitialConfig.ACTIVE).getOne();
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
    public List<Map<String, String>> getTableList(InitialConfig config) throws SQLException {
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
    public void activeConfig(String configId) {
        InitialConfig config = getById(configId);
        if (!InitialConfig.ACTIVE == config.getActive()) {
            setOtherConfigInactive();
            config.setActive(InitialConfig.ACTIVE);
        } else {
            config.setActive(!InitialConfig.ACTIVE);
        }
        super.updateById(config);
    }

    private void setOtherConfigInactive() {
        InitialConfig activeConfig = this.getActiveConfig();
        if (null != activeConfig) {
            activeConfig.setActive(!InitialConfig.ACTIVE);
            super.updateById(activeConfig);
        }
    }

    @Override
    public boolean updateById(InitialConfig entity) {
        if (InitialConfig.ACTIVE == entity.getActive()) {
            setOtherConfigInactive();
        }
        String password = entity.getPassword();
        if (StrUtil.isNotBlank(password)) {
            entity.setPassword(EncryptUtils.encrypt(password));
        }
        String targetDatabaseUsername = entity.getTargetDatabaseUsername();
        if (StrUtil.isNotBlank(targetDatabaseUsername)) {
            entity.setTargetDatabaseUsername(EncryptUtils.encrypt(targetDatabaseUsername));
        }
        String targetDatabasePwd = entity.getTargetDatabasePwd();
        if (StrUtil.isNotBlank(targetDatabasePwd)) {
            entity.setTargetDatabasePwd(EncryptUtils.encrypt(targetDatabasePwd));
        }
        return super.updateById(entity);
    }
}
