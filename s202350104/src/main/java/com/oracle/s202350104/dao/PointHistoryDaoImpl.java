package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.PointHistory;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Repository
@RequiredArgsConstructor
@Slf4j
public class PointHistoryDaoImpl implements PointHistoryDao {
	
	private final SqlSession session;

	@Override
	public List<PointHistory> listPointHistory() {
		List<PointHistory> listPointHistory = null;
		try {
			listPointHistory = session.selectList("pointhistoryAll");
			
		} catch(Exception e) {
			
		}
		
		return listPointHistory;
	}

	@Override
	public int deletePointHistory(int point_id) {
		int result = 0;
		try {
			result = session.delete("deletePointHistory",point_id);
		} catch (Exception e) {
			 log.error("Error deleting point history: {}", e.getMessage());
        }
		
		return result;
	}

	@Override
	public void writePointHistory(PointHistory pointhistory) {
		session.insert("writePointHistory", pointhistory);
		
	}

	@Override
	public int getPointHistoryByUserId(int point_id) {
		// TODO Auto-generated method stub
		return 0;
	}

}
