package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Contents;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
public class ContentDaoImpl implements ContentsDao {
	
	private final SqlSession session;

	@Override
	public List<Contents> listContent() {
		List<Contents> listContent = session.selectList("listContent");
		return listContent;
	}
	
}
