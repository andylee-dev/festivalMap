package com.oracle.s202350104.service.user;

import java.util.List;
import java.util.Optional;

import com.oracle.s202350104.model.Users;

public interface UserService {
	int getLoggedInId();
	int getLoggedInUserRole();
	int totalUsers(Users user);
	List<Users> getUserList(int small_code);
	List<Users> getSearchUserList(Users user);
	int insertUser(Users user);
	Optional<Users> getUserByEmail(String email);
	Optional<Users> getUserById(int id);
	void  updateUser(Users user);
	int deletUser(int id);
}
	