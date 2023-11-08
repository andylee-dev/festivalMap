package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Point;

public interface PointService {
	
	List<Point>			listPoint();

	void                updatePoint(Point point);

	void                writePoint(Point point);
	
	int 				getPointScoreById(int id);


}
