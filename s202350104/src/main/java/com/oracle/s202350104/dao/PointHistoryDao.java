package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.PointHistory;

public interface PointHistoryDao {
	
	List<PointHistory>	listPointHistory();

	int                 deletePointHistory(Integer id);

	void                writePointHistory(PointHistory pointhistory);
	
	List<PointHistory>  getPointHistoryByUserId(int user_id);

	int                 totalpointHistory();

	int                 conTotalPointHistory(PointHistory pointhistory);

	List<PointHistory>  indexlistSearchPointHistory(PointHistory pointhistory);

	List<PointHistory>  listPointHistory1(PointHistory pointhistory);

}
