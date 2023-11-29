package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.AccomodationContent;
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
	public int deletePointHistory(Integer id) {
		int result = 0;
		try {
			result = session.delete("deletePointHistory",id);
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
	public List<PointHistory> getPointHistoryByUserId(int user_id) {
		
		List<PointHistory> listPointHistory = null;
		try {
			listPointHistory = session.selectList("getPointHistoryByUserId",user_id);
			
		} catch(Exception e) {
			
		}
		
		return listPointHistory;
	}

	@Override
	public int totalpointHistory() {
		int totPointHistoryCount = 0;
		try {
			totPointHistoryCount = session.selectOne("PointHistoryTotal");
		} catch (Exception e) {
			log.info("PointHistoryDaoImpl PointHistoryTotal Exception => " + e.getMessage());
		}
		return totPointHistoryCount;
	}

	@Override
	public int conTotalPointHistory(PointHistory pointhistory) {
		int conTotalPointHistory = 0;
		try {
			conTotalPointHistory = session.selectOne("conTotalPointHistory", pointhistory);
		} catch (Exception e) {
			log.info("AccomodationDaoImpl ConTotalAccomodation() Exception ->" + e.getMessage());
		}
				
		return conTotalPointHistory;
		}

	@Override
	public List<PointHistory> indexlistSearchPointHistory(PointHistory pointhistory) {
		List<PointHistory> indexlistSearchPointHistory = null;
		try {
			indexlistSearchPointHistory = session.selectList("indexlistSearchPointHistory", pointhistory);
		} catch (Exception e) {
			 log.info("PointHistoryDaoImpl indexlistSearchPointHistory() Exception ->" + e.getMessage());
		}
		return indexlistSearchPointHistory;
	}

	@Override
	public List<PointHistory> listPointHistory1(PointHistory pointhistory) {
		List<PointHistory> listPointHistory = null;
		try {
			listPointHistory = session.selectList("pointhistoryAll1", pointhistory);
			
		} catch(Exception e) {
			
		}
		
		return listPointHistory;
	}
	}


	


