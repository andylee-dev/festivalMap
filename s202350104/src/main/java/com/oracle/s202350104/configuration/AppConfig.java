package com.oracle.s202350104.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.client.RestTemplate;

@Configuration
public class AppConfig {
	//@biref UserService와 AuthProvider 양쪽에서 사용해야하기 때문에 순환참조로 인한 분리.
	@Bean
	public BCryptPasswordEncoder  encodePwd() {
		return new BCryptPasswordEncoder();
	}	

	@Bean
    public RestTemplate restTemplate() {
        return new RestTemplate();
    }
	
}
