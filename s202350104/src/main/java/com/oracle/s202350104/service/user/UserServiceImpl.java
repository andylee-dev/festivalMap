package com.oracle.s202350104.service.user;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.s202350104.configuration.AppConfig;
import com.oracle.s202350104.configuration.Role;
import com.oracle.s202350104.dao.UserDao;
import com.oracle.s202350104.exception.UserNotFoundException;
import com.oracle.s202350104.model.PointHistory;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.PointHistoryService;
import com.oracle.s202350104.service.point.PointService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
	private final UserDao ud;
	private final AppConfig appConfig;

	@Override
	public int getLoggedInId() {
		Users user =new Users();
		user.setId(0);
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && !authentication.getName().equals("anonymousUser") ){
			user = ud.getUserByEmail(authentication.getName());
			
			
			log.info("로그인아이디:{}",user.getId());
			return user.getId();
		}
		return user.getId();
	}
	
	/**
	 * @return ADMIN:1 / USER:2 / BIZ:3 / etc:0
	 */
	@Override
	public int getLoggedInUserRole() {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		int role = authentication.getAuthorities().stream()
	        .map(GrantedAuthority::getAuthority)
	        .filter(authority -> authority.contains("ADMIN") || authority.contains("BIZ") || authority.contains("USER"))
	        .findFirst()
	        .map(authority -> {
	            if (authority.contains("ADMIN")) {
	                return Role.ADMIN.getKey();
	            } else if (authority.contains("BIZ")) {
	                return Role.BIZ.getKey();
	            } else {
	                return Role.USER.getKey();
	            }
	        })
	        .orElse(0);
		return role;
	}
	
	@Override
	public int totalUsers(Users user) {
		int totalCount = ud.totalUsers(user);
		return totalCount;
	}
	@Override
	public List<Users> getUserList(int small_code) {
		List<Users> usersList = ud.getUserList(small_code);
		return usersList;
	}
	
	@Override
	public List<Users> getSearchUserList(Users user) {
		List<Users> usersList = ud.getSearchUserList(user);
		return usersList;
	}

	@Override
	public int insertUser(Users user)  {
		int result = 0;
			/* 비밀번호 암호화*/
// 				user.setPassword(appConfig.encodePwd().encode(user.getPassword()));
		user.setBirthday(user.getBirthday().replace("-", ""));
		result = ud.insertUser(user);
		return result;
	}

	@Override
	public Optional<Users> getUserByEmail(String email) {
	    Users user = ud.getUserByEmail(email);
	    return Optional.ofNullable(user);
	}

	@Override
	public Optional<Users> getUserById(int id) {
		Users user = null;
		user = ud.getUserById(id);
		return Optional.of(user);
	}


	@Override
	public int  updateUser(Users user) {
		int result = ud.updateUser(user);
	    if (result == 0) {	
	        throw new UserNotFoundException("해당하는 사용자가 데이터베이스에 존재하지 않습니다.");
	    }
	    return result;
	}

	@Override
	public int deletUser(int id) {
		return ud.deleteUser(id);
	}


}
