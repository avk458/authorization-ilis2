package cn.hitek.authorization.ilis2.autoconfigration;

import cn.hitek.authorization.ilis2.common.mybatisplus.CommonMetaDataHandler;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

/**
 * @author chenlm
 */
@Configuration
public class MybatisPlusAutoConfiguration {

    @Bean
    public CommonMetaDataHandler commonMetaDataHandler() {
        return new CommonMetaDataHandler();
    }
}
