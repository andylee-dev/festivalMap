package com.oracle.s202350104.service.user;

import java.util.List;

import com.oracle.s202350104.model.Users;

public interface UserService {
	int getLoggedInId();
	int totalUsers(Users user);
	List<Users> getUserList(int small_code);
	List<Users> getSearchUserList(Users user);
	int insertUser(Users user);
	Users getUserByEmail(String email);
	Users getUserById(int id);
	int updateUser(Users user);
	int deletUser(int id);
	int updateUserPoint(int user_id, int point_id);
}
	