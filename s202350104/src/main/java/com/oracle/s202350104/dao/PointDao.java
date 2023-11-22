package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Point;

public interface PointDao {
	
	List<Point>			listPoint();

	void                updatePoint(Point point);

	void                writePoint(Point point);

	int 				getPointScoreById(int id);
					
	Point				getPointById(int id);
}
