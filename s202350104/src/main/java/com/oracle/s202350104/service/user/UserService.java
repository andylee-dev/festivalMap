package com.oracle.s202350104.service.user;

import java.util.List;

import com.oracle.s202350104.model.Users;

public interface UserService {

	List<Users> listUsers();
	Users findUser();
	int signUp(Users user);
	Users getUserByEmail(String email);
	Users getUserById(int id);
}
	