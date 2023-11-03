package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Users;

public interface AdminListService {

	int 		totalAdminList();
	List<Users> listUser(Users user);

		

}
