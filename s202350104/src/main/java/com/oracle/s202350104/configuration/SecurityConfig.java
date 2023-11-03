package com.oracle.s202350104.configuration;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityCustomizer;

import org.springframework.security.web.SecurityFilterChain;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * TODO : 인증 방식 두 개 사용해보기.
 * - 관리자는 Server기반 인증
 * - 일반 유저는 Token기반 인증
 */
@EnableWebSecurity
@Configuration
@Slf4j
public class SecurityConfig {

	@Autowired
	private  CustomAuthenticationProvider authProvider;

	/**
	 * @see 시큐리티 무시할 경로 설정. static, h2데이터 확인하기 위한 h2-console.
	 */
	@Bean
    public WebSecurityCustomizer webSecurityCustomizer() {
        return ((web) -> web.ignoring()
        					.antMatchers("/static/**", "/h2-console/**"));
    }
	
	@Bean
	protected SecurityFilterChain filterChain(HttpSecurity http) throws Exception  {
		// TODO: CSRF Study
		http.csrf().disable();

		// Role에 따른 Request권한 설정.
		http.authorizeHttpRequests((requests) -> requests
				/* 개발단계에서는 역할에 따른 접근제한 해제.
				.antMatchers("/admin/**").hasRole(Role.ADMIN.getValue())
				.antMatchers("/user/myPage/**").hasRole(Role.USER.getValue())
				.antMatchers("/user/bizPage").hasRole(Role.BIZ.getValue())
				*/
				.antMatchers("/**").permitAll()
				.anyRequest().authenticated()
			);
		// Login 설정 
		http.formLogin((form) -> form
				.loginPage("/login")
				.loginProcessingUrl("/auth")
				.usernameParameter("username")	// login에 필요한 id값 설정 (default는 username)
                .passwordParameter("password")	// login에 필요한 password 값  (default password)
				.permitAll()
				.defaultSuccessUrl("/")
				.successHandler(new CustomAuthenticationSuccessHandler())
			);
		// Logout 설정.
		http.logout((logout) -> logout
				.permitAll()
				.logoutSuccessUrl("/")
				.invalidateHttpSession(true) //세션 날리기
			);	
		// Authentication Provider 등록.
		http.authenticationProvider(authProvider);
		return http.build();
	}

	@Bean
	AuthenticationManager authenticationManager(
		AuthenticationConfiguration authenticationConfiguration
	) throws Exception {
		return authenticationConfiguration.getAuthenticationManager();
	}
}
