package com.oracle.s202350104.dao;

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
	public List<Users> listSearchUsers(int small_code ) {
		List<Users> listUsers = session.selectList("userSearchList",small_code);
		return listUsers;
	}

	@Override
	public int insertUser(Users user) {
		int result = session.insert("insertUser",user);
		return result;
	}

	@Override
	public Users getUserByEmail(String email) {
		Users user = null;
		user = session.selectOne("getUserByEmail",email);
		return user;
	}

	@Override
	public Users getUserById(int id) {
		Users user = null;
		user = session.selectOne("getUserById", id);
		return user;
	}

	@Override
	public int updateUser(Users user) {
		int result = 0;
		return result;
	}

	@Override
	public int deleteUser(int id) {
		int result = 0;
		return result;
	}	
}
