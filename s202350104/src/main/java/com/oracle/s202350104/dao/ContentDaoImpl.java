package com.oracle.s202350104.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ContentDaoImpl implements ContentDao {
	
	private final SqlSession session;
	
}
