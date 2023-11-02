package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Point;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class PointDaoImpl implements PointDao {
	
	private final SqlSession session;

	@Override
	public List<Point> listPoint() {
		List<Point> listPoint = null;
		try {
			listPoint = session.selectList("pointAll");
			
		} catch(Exception e) {
			
		}
		
		return listPoint;
	}

	@Override
	public int deletePoint(int id) {
		int result = 0;
		try {
			result = session.delete("deletePoint",id);
		} catch (Exception e) {
			 log.error("Error deleting point history: {}", e.getMessage());
        }
		
		return result;
	}
}


