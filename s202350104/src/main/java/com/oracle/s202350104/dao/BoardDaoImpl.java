package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class BoardDaoImpl implements BoardDao {
	
	private final SqlSession session;
	
	@Override
	public List<Board> getFreeAllList() {

		List<Board> freeAllList = session.selectList("freeAllList");
		
		log.info("dao freeAllList size --> " + freeAllList.size());
		
		return freeAllList;
	}
	
}
