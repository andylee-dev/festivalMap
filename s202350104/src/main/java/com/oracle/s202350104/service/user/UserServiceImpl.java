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
import com.oracle.s202350104.model.PointHistory;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.PointHistoryService;
import com.oracle.s202350104.service.PointService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
	private final UserDao ud;
	private final AppConfig appConfig;
	private final PointHistoryService phs;
	private final PointService ps;

	@Override
	public int getLoggedInId() {
		int userId = 0;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication != null && !authentication.getName().equals("anonymousUser") ){
			userId = Integer.parseInt(authentication.getName());
			log.info("로그인아이디:{}",userId);
		}
		return userId;
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
	        .orElse(null);
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
	public int insertUser(Users user) {
		int result = 0;
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}-{}:{}",transactionId,"UserServiceImpl", "signUp", "start");
			if (!user.getEmail().equals("")) {
				/* 비밀번호 암호화*/
// 				user.setPassword(appConfig.encodePwd().encode(user.getPassword()));
				user.setBirthday(user.getBirthday().replace("-", ""));
				result = ud.insertUser(user);
			} else {
				log.info("no email");
			}
		} catch (Exception e) {
			log.error("[{}]{}-{}:{}",transactionId,"UserServiceImpl", "userJoinForm", e.getMessage());
		} finally {
			log.info("[{}]{}-{}:{}",transactionId,"UserServiceImpl", "signUp", "end");
		}
		return result;
	}

	@Override
	public Optional<Users> getUserByEmail(String email) {
		Users user = null;
		user = ud.getUserByEmail(email);
		return Optional.of(user);
	}

	@Override
	public Optional<Users> getUserById(int id) {
		Users user = null;
		user = ud.getUserById(id);
		return Optional.of(user);
	}


	@Override
	public int updateUser(Users user) {
		return ud.updateUser(user);
	}

	@Override
	public int deletUser(int id) {
		return ud.deleteUser(id);
	}

	@Override
	@Transactional 
	public int updateUserPoint(int user_id, int point_id) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}-{}:{}",transactionId,"UserServiceImpl", "updatePoint", "start");

			// Update Point
			int score = ps.getPointScoreById(point_id);
	
			Users user = new Users();
			user.setId(user_id);
			user.setPoint(score);
	
			ud.updateUserPoint(user);
	
			log.info("updatePoint user:{} / score:{}",user_id,score);

			// Write Point History
			PointHistory pointHistory = new PointHistory();
			pointHistory.setUser_id(user_id);
			pointHistory.setPoint_id(point_id);
			phs.writePointHistory(pointHistory);
		} catch (Exception e) {
			log.error("[{}]{}-{}:{}",transactionId,"UserServiceImpl", "updatePoint", e.getMessage());
		} finally {
			log.info("[{}]{}-{}:{}",transactionId,"UserServiceImpl", "updatePoint", "end");
		}		
		return 0;
	}
}
