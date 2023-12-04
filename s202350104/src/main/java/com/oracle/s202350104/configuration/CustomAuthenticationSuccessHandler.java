package com.oracle.s202350104.configuration;

import java.io.IOException;
import java.util.NoSuchElementException;
import java.util.Optional;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.catalina.User;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.point.PointEvent;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

/**
 * @see Auth가 완료되었을 때 처리하게 되는 핸들러.
 */
@Component
@Slf4j
@Service
@RequiredArgsConstructor
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	private final ApplicationEventPublisher eventPublisher;
	private final UserService us;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		log.info("CustomAuthenticationSuccessHandler", authentication.getAuthorities());
		if (authentication.getAuthorities().stream().anyMatch(auth -> ( auth.getAuthority()).equals("ROLE_"+Role.ADMIN))) {
            response.sendRedirect("/admin"); // Admin의 경우 리다이렉트할 URL
        } else {
        	Optional<Users> user = us.getUserByEmail("fdsas@dads.com");
        	if (user.isPresent()) {
        	    log.info("loggined Id:{}/{}",user.get().getId());
        	     eventPublisher.publishEvent(new PointEvent(user.get().getId(), 9));
        	} else {
        	    throw new NoSuchElementException("No user found with email: fdsas@dads.com");
        	}
        	response.sendRedirect("/"); // 그 외의 경우 리다이렉트할 URL
        }
		
	}

}
