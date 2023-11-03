package com.oracle.s202350104.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

/**
 * @biref UserService와 AuthProvider 양쪽에서 사용해야하기 때문에 순환참조로 인한 분리.
 */
@Configuration
public class AppConfig {
	@Bean
	public BCryptPasswordEncoder  encodePwd() {
		return new BCryptPasswordEncoder();
	}	
	
}
