package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Users;

public interface UserDao {
	List<Users> listSearchUsers(int small_code);
	int insertUser(Users user);
	Users getUserByEmail(String email);
	Users getUserById(int id);
	int updateUser(Users user);
	int deleteUser(int id);
}
