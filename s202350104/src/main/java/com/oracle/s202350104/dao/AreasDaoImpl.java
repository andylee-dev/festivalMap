package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Areas;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class AreasDaoImpl implements AreasDao {

	private final SqlSession session;

	@Override
	public List<Areas> listAreas() {
		List<Areas> listAreas = null;
		try {
			listAreas = session.selectList("AreasListAll");
		} catch(Exception e) {
			log.info("{}",e.getMessage());
		}
		return listAreas;
	}

}
