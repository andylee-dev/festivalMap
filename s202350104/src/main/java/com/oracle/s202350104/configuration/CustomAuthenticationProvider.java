package com.oracle.s202350104.configuration;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Component
@Slf4j
public class CustomAuthenticationProvider implements AuthenticationProvider {

	private final UserService userService;
	
	@Override
    public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		UUID transactionId = UUID.randomUUID();
		String username = "";
		String password = "";
		List<GrantedAuthority> authorities = new ArrayList<>();
		try {
			log.info("[{}]{}:{}",transactionId, "AuthenticationProvider", "start");
	        username = authentication.getName();
	        password = authentication.getCredentials().toString();
	
	        Optional<Users> user = userService.getUserById(Integer.parseInt(username));
	        if (user == null) {
	            throw new BadCredentialsException("username is not found. username=" + username);
	        }
	        if (!password.equals(user.get().getPassword())) {
	        	throw new BadCredentialsException("password is not matched");        	
	        }
	        /* 개발 단계에서는 패스워드 인코딩 생략.
			if (!this.passwordEncoder.matches(password, user.getPassword())) {
				throw new BadCredentialsException("password is not matched");
			}
			*/
//	        userService.updateUserPoint(user.getId(), 9);
	        authorities.add(new SimpleGrantedAuthority("ROLE_"+Role.getValueByKey(user.get().getSmall_code())));	
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "AuthenticationProvider", e.getMessage());
			 throw e;  // 추가된 부분
		} finally {
			log.info("[{}]{}:{}",transactionId, "AuthenticationProvider", "end");
		}	        
    	return new UsernamePasswordAuthenticationToken(username, password, authorities);
    }

	@Override
	public boolean supports(Class<?> authentication) {
		 return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
	}
	

}
