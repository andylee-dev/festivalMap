package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Repository;
import org.springframework.web.server.ResponseStatusException;

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

		} catch (Exception e) {

		}

		return listPoint;
	}

	@Override
	public void updatePoint(Point point) {
		session.update("updatePoint", point);
	}

	@Override
	public void writePoint(Point point) {
		session.insert("writePoint", point);

	}

	@Override
	public int getPointScoreById(int id) {
		return session.selectOne("getPointScore", id);
	}

	@Override
	public Point getPointById(int id) {
		return session.selectOne("getPoint", id);
	}

	@Override
	public int totalpoint() {
		int totPointCount = 0;
		try {
			totPointCount = session.selectOne("PointTotal");
		} catch (Exception e) {
			log.info("PointDaoImpl PointTotal Exception => " + e.getMessage());
		}
		return totPointCount;
	}

	@Override
	public Point listpoint1(int id) {
		Point point = new Point();
		try {
			point = session.selectOne("listpoint1", id);
			log.info("point point() point.getId ->" + point.getId());
					
		} catch (Exception e) {
			log.info("accomodationsContent detailaccomodation() ->" + e.getMessage());
		}
		return point;
	}

	@Override
	public int deletePoint(Integer id) {
		int result = 0;
		try {
			result = session.delete("deletePoint",id);
		} catch (Exception e) {
			 log.error("Error deleting point: {}", e.getMessage());
        }
		
		return result;
	}

}
