package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Accomodation;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AccomodationDaoImpl implements AccomodationDao {

	private final SqlSession session;

	@Override
	public List<Accomodation> listAccomodation() {
		List<Accomodation> listAccomodation = null;
		try {
			listAccomodation = session.selectList("accomodationAll");
			
		} catch(Exception e) {
			System.out.println("AccomodationDaoImpl listAccomodation()"+ e.getMessage());
		}
		
		return listAccomodation;
	}
}
