package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class FestivalsDaoImpl implements FestivalsDao {

	private final SqlSession session;

	@Override
	public List<FestivalsContent> listFestivals() {
		List<FestivalsContent> listFestivals = null;
		try {
			listFestivals = session.selectList("festivalsListAll");
			log.info("listFestivals() => " + listFestivals.size());
		} catch (Exception e) {
			log.info("FestivalsDaoImpl listFestivals() => " + e.getMessage());
		}
		return listFestivals;
	}

	@Override
	public FestivalsContent detailFestivals(int contentId) {
		FestivalsContent festival = new FestivalsContent();
		try {
			festival = session.selectOne("festivalsDetail", contentId);
			log.info("FestivalsDaoImpl detailFestivals() festival.getTitle => " + festival.getTitle());
		} catch (Exception e) {
			log.info("FestivalsDaoImpl detailFestivals() => " + e.getMessage());
		}
		return festival;
	}
	
}
