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
	public List<Accomodations> listAccomodations() {
		
		List<Accomodations> listAccomodations = null;
		try {
			listAccomodations = session.selectList("accomodationAll");
			
		} catch(Exception e) {
			
			System.out.println("AccomodationsDaoImpl listAccomodations()"+ e.getMessage());
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
}
