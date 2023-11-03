package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Point;

public interface PointDao {
	
	List<Point>			listPoint();

	Point 				getPointById(int id);

	void                updatePoint(Point point);


	

}
