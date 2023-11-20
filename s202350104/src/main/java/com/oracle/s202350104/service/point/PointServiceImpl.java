package com.oracle.s202350104.service.point;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.PointDao;
import com.oracle.s202350104.dao.PointHistoryDao;
import com.oracle.s202350104.dao.UserDao;
import com.oracle.s202350104.model.Point;
import com.oracle.s202350104.model.PointHistory;
import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PointServiceImpl implements PointService {

	private final PointDao pd;
	private final UserDao ud;
	private final PointHistoryDao phd;

	@Override
	public List<Point> listPoint() {

		List<Point> listPoint = pd.listPoint();

		if (listPoint == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "포인트 리스트가 존재하지 않습니다");
		}

		return listPoint;
	}

	public void updatePoint(Point point) {
		pd.updatePoint(point);
	}

	@Override
	public void writePoint(Point point) {
		pd.writePoint(point);

	}

	@Override
	public int getPointScoreById(int id) {
		int score = pd.getPointScoreById(id);
		return score;
	}
	@Override
    @Transactional
    public void addPointAndHistory(int userId, int pointId) {
    	log.info("addPointAndHistory");
    	/*
        // 사용자 정보를 가져오고
        Users user = ud.getUserById(userId);
        // 포인트 정보를 가져옵니다.
        Point point = pd.getPointById(pointId)
        if(!point)
        	throw new RuntimeException("Point not found");

        // 사용자의 포인트를 증가시키고
        user.setPoint(user.getPoint() + point.getPoint());
        ud.updateUser(user);

        // 포인트 히스토리를 남깁니다.
        PointHistory pointHistory = new PointHistory();
        pointHistory.setUser_id(userId);
        pointHistory.setPoint_id(pointId);
        phd.writePointHistory(pointHistory);
        */
    }	
	
	
}
