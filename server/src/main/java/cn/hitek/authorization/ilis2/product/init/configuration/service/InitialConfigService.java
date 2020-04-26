package cn.hitek.authorization.ilis2.product.init.configuration.service;

import cn.hitek.authorization.ilis2.framework.web.service.BaseService;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;

/**
 * @author chenlm
 */
public interface InitialConfigService extends BaseService<InitialConfig> {

    /**
     * 获取启用的数据库初始化配置信息
     * @return config
     */
    InitialConfig getActiveConfig();
}
