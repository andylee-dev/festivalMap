package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Users;

public interface UserDao {

	List<Users> listUsers();
	int insertUser(Users user);

}
