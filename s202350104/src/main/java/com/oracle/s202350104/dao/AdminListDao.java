package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Users;

public interface AdminListDao {

	int 		totalAdminList();
	List<Users> listUser(Users user);

} 
