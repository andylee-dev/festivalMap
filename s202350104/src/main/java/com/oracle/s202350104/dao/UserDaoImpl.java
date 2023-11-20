package com.oracle.s202350104.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.configuration.Role;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class UserDaoImpl implements UserDao {

	private final SqlSession session;
	
	@Override
	public int totalUsers(Users user) {
		int totalCount = session.selectOne("totalUsers", user);
		return totalCount;
	}
	
	@Override
	public List<Users> getUserList(int small_code ) {
		List<Users> listUsers = session.selectList("userSearchList", small_code);
		return listUsers;
	}
	
	@Override
	public List<Users> getSearchUserList(Users user) {
		List<Users> listUsers = session.selectList("getSearchUserList", user);
		return listUsers;
	}	

	@Override
	public int insertUser(Users user) {
		return session.insert("insertUser",user);
	}

	@Override
	public Users getUserByEmail(String email) {
		Users user = null;
		user = session.selectOne("getUserByEmail",email);
		return user;
	}

	@Override
	public Users getUserById(int id) {
		return session.selectOne("getUserById", id);
	}

	@Override
	public int updateUser(Users user) {
		return session.update("updateUser",user);
	}

	@Override
	public int deleteUser(int id) {
		return session.update("deleteUser", id);
	}

	@Override
	public int updateUserPoint(Users user) {
		return session.update("updateUserPoint",user);
	}




}
