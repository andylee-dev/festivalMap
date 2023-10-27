package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Accomodations;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AccomodationsDaoImpl implements AccomodationsDao {

	private final SqlSession session;

	@Override
	public List<Accomodations> listAccomodations(Accomodations accomodations) {
		
		List<Accomodations> listAccomodations = null;
		try {
			listAccomodations = session.selectList("accomodationAll",accomodations);
			
		} catch(Exception e) {
			
			System.out.println("AccomodationsDaoImpl listAccomodations()"+ e.getMessage());
		}
		
		return listAccomodations;
	}
}
