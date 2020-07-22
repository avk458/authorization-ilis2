package cn.hitek.authorization.ilis2.product.configuration.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.configuration.domain.MainSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.domain.TargetSourceProfile;
import cn.hitek.authorization.ilis2.product.configuration.domain.vo.Folder;
import cn.hitek.authorization.ilis2.product.data.management.domain.Schema;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;
import java.util.Map;

/**
 * @author chenlm
 */
public interface ConfigService extends BaseService<MainSourceProfile> {

    /**
     * 获取启用的数据库初始化配置信息
     * @return config
     */
    MainSourceProfile getActiveConfig();

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
    List<Map<String, String>> getTableList(MainSourceProfile config) throws SQLException;

    /**
     * 更新所选配置文件为启用状态，并将其它启用状态的配置置为不启用
     * @param configId 配置id
     */
    void activeProfile(String configId);

    /**
     * 保存主数据源配置文件
     * @param config 配置实体
     */
    void saveMainProfile(MainSourceProfile config);

    /**
     * 根据用户输入的信息获取数据库schemas
     * @param config 用于接收参数的对象
     * @return schemas
     */
    List<Map<String, String>> getDatabases(MainSourceProfile config);

    /**
     * 获取目标数据源配置信息
     * @return target source profiles
     */
    List<TargetSourceProfile> getTargetProfiles();

    /**
     * 新增目标数据源
     * @param targetProfile 目标数据源对象
     */
    void insertTargetProfile(TargetSourceProfile targetProfile);

    /**
     * 更新目标数据源
     * @param targetProfile 目标数据源
     */
    void updateTargetProfile(TargetSourceProfile targetProfile);

    /**
     * 删除目标数据源
     * @param profileId 目标数据源id
     */
    void deleteTargetProfile(String profileId);

    /**
     * 验证目标数据源连接是否可用
     * @param profile 目标数据源
     * @return 验证结果
     */
    boolean validateConnection(TargetSourceProfile profile);

    /**
     * 根据目标数据源id获取实体
     * @param targetSource 目标数据源配置id
     * @return target profile
     */
    TargetSourceProfile getTargetProfileViaId(String targetSource);

    /**
     * 根据目标数据源获取连接
     * @param targetProfileId 目标数据源id
     * @return Connection
     * @throws SQLException sql exc
     */
    Connection getTargetSourceConnection(String targetProfileId) throws SQLException;

    /**
     * 根据主数据源id获取数据源下schema
     * @param mainProfileId 主数据源id
     * @return source schemas
     */
    List<Schema> getMainSourceSchemas(String mainProfileId);

    /**
     * 根据目标数据源获取数据源schema
     * @param targetProfileId 目标数据源id
     * @return target schemas
     */
    List<Schema> getTargetSourceSchemas(String targetProfileId);

    /**
     * 获取唯一的，系统初始时由开发人员制作的ilis空库
     * @return 空库主数据源
     */
    MainSourceProfile getStandardProfile();
}
