package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.PointDao;
import com.oracle.s202350104.model.Point;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class PointServiceImpl implements PointService {
	
	private final PointDao pd;

	@Override
	public List<Point> listPoint() {
		
		List<Point> listPoint = pd.listPoint();
		
		if(listPoint==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "포인트 리스트가 존재하지 않습니다");
		}
		
		return listPoint;
		

	}

}
