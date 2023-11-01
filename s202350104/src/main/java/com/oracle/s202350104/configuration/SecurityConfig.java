package com.oracle.s202350104.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import lombok.RequiredArgsConstructor;

/**
 * @brief 인증 방식 두 개 사용해보기.
 * - 관리자는 Server기반 인증
 * - 일반 유저는 Token기반 인증
 */

@Configuration
public class SecurityConfig  {
	
	/**
	 * @see Enum 타입 정의.
	 */
	public enum UserRole {
	    ADMIN(1,"Admin"),
	    BIZ(2,"Biz"),
	    USER(3,"General");

	    private int code;
	    private String label;

	    private UserRole(int code, String label) {
	    	this.code = code;
	        this.label = label;
	    }
	    public String getLabel() {
	        return this.label;
	    }
	    public int getCode() {
	        return this.code;
	    }
	}
	/**
	 * @see 시큐리티 무시할 경로 설정. static, h2데이터 확인하기 위한 h2-console.
	 */
	@Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return ((web) -> web.ignoring()
        					.antMatchers("/static/**", "/h2-console/**"));
    }
	
	@Bean
	public BCryptPasswordEncoder  encodePwd() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception  {
		http.csrf().disable();
		http.authorizeRequests()
			.antMatchers("/**").permitAll()
//			.antMatchers("/admin/**").hasRole(UserRole.ADMIN.getLabel())
//			.antMatchers("/my/**").hasRole(UserRole.ADMIN.getLabel())
			.anyRequest().authenticated();
		
		return http.build();
		
	}
}
