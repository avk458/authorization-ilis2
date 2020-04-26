package cn.hitek.authorization.ilis2.product.init.configuration.service.impl;

import cn.hitek.authorization.ilis2.framework.web.service.impl.BaseServiceImpl;
import cn.hitek.authorization.ilis2.product.init.configuration.domain.InitialConfig;
import cn.hitek.authorization.ilis2.product.init.configuration.mapper.InitialConfigMapper;
import cn.hitek.authorization.ilis2.product.init.configuration.service.InitialConfigService;
import org.springframework.stereotype.Service;
/**
 * @author chenlm
 */
@Service
public class InitialConfigServiceImpl extends BaseServiceImpl<InitialConfigMapper, InitialConfig> implements InitialConfigService {

    @Override
    public InitialConfig getActiveConfig() {
        return query().eq(InitialConfig::getActive, InitialConfig.ACTIVE).getOne();
    }
}
