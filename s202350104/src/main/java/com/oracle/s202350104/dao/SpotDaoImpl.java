package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SpotDaoImpl implements SpotDao {

	private final SqlSession session;

	@Override
	public List<Spot> listSpot(SpotContent spotContent) {
		List<Spot> spotList = null;
			
			try {
				spotList = session.selectList("dhSpotListAll", spotContent);
			} catch (Exception e) {
			}
		return spotList;
	}
}
