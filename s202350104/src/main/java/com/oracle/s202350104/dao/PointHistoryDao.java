package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.PointHistory;

public interface PointHistoryDao {
	
	List<PointHistory>	listPointHistory();

	int                 deletePointHistory(int point_id);

	void                writePointHistory(PointHistory pointhistory);
	
	int					getPointHistoryByUserId(int point_id);

}
