package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class AdminListDaoImpl implements AdminListDao {
	private final SqlSession session;
	
	@Override
	public int totalAdminList() {
		int totalAdminList = 0;
		try {
			totalAdminList = session.selectOne("joAdminListTotal");
			log.info("AdminListDaoImpl totalAdminList ->" + totalAdminList);
		} catch (Exception e) {
			log.info("AdminListDaoImpl totalAdminList exception ->" + e.getMessage());
		}		
				
		return totalAdminList;
	}

	
	@Override
	public List<Users> listUser(Users user) {
		List<Users> listUser = null;
		try {
			listUser = session.selectList("joAdminListList", user);
			log.info("AdminListDaoImpl listUser -> " + listUser.size());
		} catch (Exception e) {
			log.info("AdminListDaoImpl listUser exception ->" + e.getMessage());
		}
				
		return listUser;
	}

	
}
