package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.CommonCodes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Repository
@RequiredArgsConstructor
@Slf4j
public class CommonCodesDaoImpl implements CommonCodesDao {
	private final SqlSession session;

	@Override
	public List<CommonCodes> listCommonCodes() {
		List<CommonCodes> listCommonCodes = null;
		try {
			listCommonCodes = session.selectList("CommonCodesListAll");
		} catch(Exception e) {
			log.info("{}",e.getMessage());
		}
		return listCommonCodes;
	}

}
