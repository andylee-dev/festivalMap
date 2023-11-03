package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.controller.SpotController;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class SpotDaoImpl implements SpotDao {

	private final SqlSession session;

	@Override
	public int totalSpot() {
		int totSpotCount = 0;
		
		try {
			totSpotCount = session.selectOne("spotTotal");
		} catch (Exception e) {
			log.info("SpotDaoImpl totalSpot Exception => " + e.getMessage());
		}
		return totSpotCount;
	}
	
	@Override
	public List<SpotContent> listSpot(SpotContent spotContent) {
		List<SpotContent> spotList = null;
			
			try {
				spotList = session.selectList("dhSpotListAll", spotContent);
				log.info("SpotDaoImpl listSpot spotList.size()->"+spotList.size());
			} catch (Exception e) {
				log.info("SpotDaoImpl listSpot e.getMessage()->"+e.getMessage());
			}
		return spotList;
	}

	@Override
	public SpotContent detailSpot(int contentId) {
		SpotContent spot = new SpotContent();
		try {
			spot = session.selectOne("dhSpotDetail", contentId);
			log.info("SpotDaoImpl detailSpot() spot.getTitle => " + spot.getTitle());
		}catch (Exception e) {
			log.info("SpotDaoImpl detailSpot() => " + e.getMessage());
		}
		
		return spot;
	}
}

