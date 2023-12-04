package com.oracle.s202350104.service;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.HistoryDao;
import com.oracle.s202350104.model.History;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class HistoryServiceImpl implements HistoryService {
	
	private final HistoryDao hd;
	
	@Override
	public int insertHistory(History history) {
		int result = hd.insertHistory(history);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "반려 사유 등록에 실패하였습니다.");
		}
		
		return result;
	}

	@Override
	public History getLatestHistory(History history) {
		return hd.getLatestHistory(history);
	}

}
