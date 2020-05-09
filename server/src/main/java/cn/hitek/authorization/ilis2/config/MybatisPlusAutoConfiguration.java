package cn.hitek.authorization.ilis2.config;

import cn.hitek.authorization.ilis2.common.mybatisplus.CommonMetaDataHandler;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.baomidou.mybatisplus.extension.plugins.pagination.optimize.JsqlParserCountOptimize;
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

    @Bean
    public PaginationInterceptor paginationInterceptor() {
        PaginationInterceptor paginationInterceptor = new PaginationInterceptor();
        paginationInterceptor.setOverflow(false);
        paginationInterceptor.setLimit(500);
        paginationInterceptor.setCountSqlParser(new JsqlParserCountOptimize(true));
        return paginationInterceptor;
    }
}
