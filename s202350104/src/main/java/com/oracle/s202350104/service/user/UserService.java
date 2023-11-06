package com.oracle.s202350104.service.user;

import java.util.List;

import com.oracle.s202350104.configuration.Role;
import com.oracle.s202350104.model.Users;

public interface UserService {

	List<Users> getUserList(int small_code);
	int insertUser(Users user);
	Users getUserByEmail(String email);
	Users getUserById(int id);
	int updateUser(Users user);
	int deletUser(int id);
}
	