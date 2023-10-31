package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.s202350104.dao.BoardDao;
import com.oracle.s202350104.model.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService{
	
	private final BoardDao boardDao;

	@Override
	public List<Board> getFreeAllList() {

		
		List<Board> freeAllList = boardDao.getFreeAllList();
				
		log.info("service freeAllList size --> " + freeAllList.size());
		
		return freeAllList;
	}
	
}
