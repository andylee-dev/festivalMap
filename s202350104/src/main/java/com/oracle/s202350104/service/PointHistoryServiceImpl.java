package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.PointHistoryDao;
import com.oracle.s202350104.model.PointHistory;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PointHistoryServiceImpl implements PointHistoryService {
	
	private final PointHistoryDao phd;

	@Override
	public List<PointHistory> listPointHistory() {

		List<PointHistory> listPointHistory = phd.listPointHistory();
		
		if(listPointHistory==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "포인트 내역 리스트가 존재하지 않습니다");
		}
		
		return listPointHistory;
	}

}
