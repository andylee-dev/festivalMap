package com.oracle.s202350104.configuration;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import lombok.extern.slf4j.Slf4j;

/**
 * @see Auth가 완료되었을 때 처리하게 되는 핸들러.
 */
@Component
@Slf4j
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.info("CustomAuthenticationSuccessHandler", authentication.getAuthorities());
		if (authentication.getAuthorities().stream().anyMatch(auth -> ( auth.getAuthority()).equals("ROLE_"+Role.ADMIN))) {
            response.sendRedirect("/admin"); // Admin의 경우 리다이렉트할 URL
        } else {
            response.sendRedirect("/"); // 그 외의 경우 리다이렉트할 URL
        }
		
	}

}
