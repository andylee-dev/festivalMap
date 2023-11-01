package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Accomodations;
import com.oracle.s202350104.model.AccomodationsContent;


import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class AccomodationsDaoImpl implements AccomodationsDao {

	private final SqlSession session;

	@Override
	public List<AccomodationsContent> listAccomodations(AccomodationsContent accomodations) {
		
		List<AccomodationsContent> listAccomodations = null;
		log.info("AccomodationsImpl listAccomodations Start...");
		
		try {
			listAccomodations = session.selectList("accomodationAll", accomodations);
			log.info("AccomodationsDaoImpl listRestaurant AccomodationsList.size()->" + listAccomodations.size());
		} catch (Exception e) {
			log.info("AccomodationsDaoImpl listAccomodations e.getMessage()->" + e.getMessage());
		}
		
		return listAccomodations;
	}

	@Override
	public AccomodationsContent detailAccomodations(int content_id) {
	AccomodationsContent accomodations = new AccomodationsContent();
		
		try {
			accomodations = session.selectOne("AccomodationsDetail", content_id);
			log.info("accomodationsContent detailaccomodations() accomodations.getTitle ->" + accomodations.getTitle());
					
		} catch (Exception e) {
			log.info("accomodationsContent detailaccomodations() ->" + e.getMessage());
		}
		return accomodations;
	}

	@Override
	public int totalAccomodations() {
		int totAccomodationsCount = 0;
		
		try {
			totAccomodationsCount = session.selectOne("AccomodationsTotal");
		} catch (Exception e) {
			log.info("AccomodationsDaoImpl totalAccomodations Exception => " + e.getMessage());
		}
		return totAccomodationsCount;
	}
}
