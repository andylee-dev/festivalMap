package com.oracle.s202350104.service.user;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.configuration.AppConfig;
import com.oracle.s202350104.configuration.Role;
import com.oracle.s202350104.dao.UserDao;
import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
	private final UserDao ud;
	private final AppConfig appConfig;

	@Override
	public int totalUsers(Users user) {
		log.info(user.getSearchType());
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
	public Users getUserByEmail(String email) {
		Users user = null;
		user = ud.getUserByEmail(email);
		return user;
	}

	@Override
	public Users getUserById(int id) {
		Users user = null;
		user = ud.getUserById(id);
		return user;
	}


	@Override
	public int updateUser(Users user) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deletUser(int id) {
		// TODO Auto-generated method stub
		return 0;
	}





}
