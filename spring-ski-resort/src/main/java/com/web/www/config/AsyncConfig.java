package com.web.www.config;

import java.util.concurrent.Executor;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;


@Configuration
@EnableAsync
public class AsyncConfig {
	
    @Bean(name = "weatherInit")
    public Executor weatherThreadPoolExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(5);	//스레드풀 사이즈
        executor.setMaxPoolSize(5);	//스레드 풀 최대 개수
        executor.setQueueCapacity(100);	//스레드 풀 작업 대기열 크기
        executor.setThreadNamePrefix("Weather-");	//스레드 이름 접두사 설정
        executor.setAwaitTerminationSeconds(60);	//작업 완료후 스레드풀 생존 시간
        executor.initialize();
        return executor;
    }
    
    
    @Bean(name = "productRenewalInit")
    public Executor productThreadPoolExecutor() {
        ThreadPoolTaskExecutor executor = new ThreadPoolTaskExecutor();
        executor.setCorePoolSize(5);	//스레드풀 사이즈
        executor.setMaxPoolSize(5);	//스레드 풀 최대 개수
        executor.setQueueCapacity(100);	//스레드 풀 작업 대기열 크기
        executor.setThreadNamePrefix("ProductRenewal-");	//스레드 이름 접두사 설정
        executor.setAwaitTerminationSeconds(60);	//작업 완료후 스레드풀 생존 시간
        executor.initialize();
        return executor;
    }
    
}
