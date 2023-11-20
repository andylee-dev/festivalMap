package com.oracle.s202350104.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;

import com.oracle.s202350104.model.History;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class HistoryDaoImpl implements HistoryDao {
	
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;
	
	// 반려 사유 정보를 history 테이블에 insert
	@Override
	public int insertHistory(History history) {
		int result = 0;
		
		try {
			
			result = session.insert("nhInsertHistory", history);
			
		} catch(Exception e) {
			log.info("HistoryDaoImpl insertHistory() => " + e.getMessage());
		}
		
		return result;
	}

}
