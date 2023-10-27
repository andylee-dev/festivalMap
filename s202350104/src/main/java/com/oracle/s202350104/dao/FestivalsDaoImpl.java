package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Festivals;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class FestivalsDaoImpl implements FestivalsDao {

	private final SqlSession session;

	@Override
	public List<Festivals> listFestivals() {
		List<Festivals> listFestivals = null;
		try {
			listFestivals = session.selectList("festivalsListAll");
			System.out.println("listFestivals() => " + listFestivals.size());
		} catch (Exception e) {
			System.out.println("FestivalsDaoImpl listFestivals() => " + e.getMessage());
		}
		return listFestivals;
	}

	@Override
	public Festivals detailFestivals(int contentId) {
		Festivals festival = new Festivals();
		try {
			festival = session.selectOne("festivalsDetail", contentId);
		} catch (Exception e) {
			System.out.println("FestivalsDaoImpl detailFestivals() => " + e.getMessage());
		}
		return festival;
	}
	
}
