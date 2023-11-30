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
	public Point getPointById(int id) {
		Point point = pd.getPointById(id);
	    if (point == null) {
	        throw new RuntimeException("Point not found");
	    }
	    return point;
	}
	
	@Override
    @Transactional
    public void addPointAndHistory(int userId, int pointId) {
    	log.info("addPointAndHistory");
    
        // 사용자 정보를 가져오고
        Users user = ud.getUserById(userId);
        if (user == null) {
            log.info("User not found with ID: {}", userId);
            throw new RuntimeException("User not found");
        }
        // 포인트 정보를 가져옵니다.
        Point point = pd.getPointById(pointId);
        
        if (point == null) {
        log.info("Point not found with ID: {}", pointId);
        throw new RuntimeException("Point not found");
    	}
        // 사용자의 포인트를 증가시키고
        user.setPoint(user.getPoint() + point.getPoint());
        ud.updateUser(user);

        // 포인트 히스토리를 남깁니다.
        PointHistory pointHistory = new PointHistory();
        pointHistory.setUser_id(userId);
        pointHistory.setPoint_id(pointId);
        phd.writePointHistory(pointHistory);
      
    }

	@Override
	public int totalpoint() {
		int totalpoint = pd.totalpoint();
		return totalpoint;
	}

	@Override
	public Point listpoint1(int id) {
		Point point = pd.listpoint1(id);
		log.info("PointImpl listpoint1 Strart...");
		if(point==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "포인트id 정보가 존재하지 않습니다");
		}
		return point;
	}

	@Override
	public int deletePoint(Integer id) {
		int result = pd.deletePoint(id);
        if(result == 0) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "삭제할 포인트 내역이 없습니다");
        }
		return result;
	}

	
}
