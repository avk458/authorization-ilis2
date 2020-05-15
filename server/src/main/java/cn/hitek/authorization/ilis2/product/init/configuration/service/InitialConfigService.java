package cn.hitek.authorization.ilis2.product.init.configuration.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.vo.Folder;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
public interface InitialConfigService extends BaseService<InitialConfig> {

    /**
     * 获取启用的数据库初始化配置信息
     * @return config
     */
    InitialConfig getActiveConfig();

    /**
     * 获取系统文件夹路径
     * @param path 异步加载的parent path
     * @return file paths
     */
    List<Folder> getSystemFilePath(String path);

    /**
     * 通过配置信息获取数据库中的表
     * @param config 配置信息
     * @return 表list
     * @throws SQLException exception
     */
    List<Map<String, String>> getTableList(InitialConfig config) throws SQLException;

    /**
     * 更新所选配置文件为启用状态，并将其它启用状态的配置置为不启用
     * @param configId 配置id
     */
    void activeConfig(String configId);

    /**
     * 保存主数据源配置文件
     * @param config 配置实体
     */
    void saveInitialConfig(InitialConfig config);
}
