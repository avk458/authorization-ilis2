package cn.hitek.authorization.ilis2.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.concurrent.Executor;

/**
 * @author chenlm
 */
@Configuration
@EnableAsync
public class ExecutorConfig {

    @Bean("asyncExecutor")
    public Executor databaseInfoExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(9);
        executor.setMaxPoolSize(18);
        executor.setQueueCapacity(18);
        executor.setThreadNamePrefix("dataManage");
        executor.initialize();
        return executor;
    }
}
