package com.oracle.s202350104.service.user;

import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.UserDao;
import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
	private final UserDao ud;
	private final BCryptPasswordEncoder bCryptPasswordEncoder;
	
	@Override
	public List<Users> listUsers() {
		List<Users> listUsers = ud.listUsers();
		
		if(listUsers == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 리스트가 존재하지 않습니다.");
		}
		
		return listUsers;
	}

	@Override
	public Users findUser() {
		return null;
	}

	@Override
	public int signUp(Users user) {
		int result = 0;
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}-{}:{}",transactionId,"UserServiceImpl", "signUp", "start");
			if (!user.getEmail().equals("")) {
				/* 비밀번호 암호화*/
// 				user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
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

}
