package com.oracle.s202350104.service.user;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.UserDao;
import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class UserServiceImpl implements UserService {
	private final UserDao ud;
	
	@Override
	public List<Users> listUsers() {
		List<Users> listUsers = ud.listUsers();
		return listUsers;
	}

}
