package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.AdminListDao;
import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AdminListServiceImpl implements AdminListService {
	private final AdminListDao ald;
	
	@Override
	public int totalAdminList() {
		int totalAdminList = ald.totalAdminList(); 
		return totalAdminList;
	}

	
	@Override
	public List<Users> listUser(Users user) {
		List<Users> listUser = ald.listUser(user);
		return listUser;
	}

}
