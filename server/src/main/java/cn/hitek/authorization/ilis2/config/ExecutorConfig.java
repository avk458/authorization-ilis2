package cn.hitek.authorization.ilis2.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.security.concurrent.DelegatingSecurityContextRunnable;

import java.util.concurrent.Executor;

/**
 * @author chenlm
 */
@Configuration
@EnableAsync
public class ExecutorConfig implements AsyncConfigurer {


    @Bean(name = "asyncExecutor")
    @Override
    public Executor getAsyncExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(9);
        executor.setMaxPoolSize(18);
        executor.setQueueCapacity(18);
        executor.setThreadNamePrefix("asyncExecutor-");
        executor.setTaskDecorator(DelegatingSecurityContextRunnable::new);
        executor.initialize();
        return executor;
    }
}
