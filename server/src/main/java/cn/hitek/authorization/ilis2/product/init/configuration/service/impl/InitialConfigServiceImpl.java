package cn.hitek.authorization.ilis2.product.init.configuration.service.impl;

import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.database.helper.ConnectionHandler;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.vo.Folder;
import cn.hitek.authorization.ilis2.product.init.configuration.mapper.InitialConfigMapper;
import cn.hitek.authorization.ilis2.product.init.configuration.service.InitialConfigService;
import org.apache.commons.lang3.StringUtils;
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
    public InitialConfig getActiveConfig() {
        return query().eq(InitialConfig::getActive, InitialConfig.ACTIVE).getOne();
    }

    @Override
    public List<Folder> getSystemFilePath(String path) {
        ArrayList<Folder> folders = new ArrayList<>(0);
        File[] files;
        Folder folder;
        if (StringUtils.isBlank(path)) {
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
        Connection connection = ConnectionHandler.getConnection(config);
        if (null != connection) {
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
        return super.updateById(entity);
    }
}