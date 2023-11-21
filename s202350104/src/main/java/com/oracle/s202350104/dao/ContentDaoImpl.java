package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Contents;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ContentDaoImpl implements ContentsDao {
	
	private final SqlSession session;
	
	@Override
	public int contentCount() {
		int contentCount = session.selectOne("contentCount");
		
		return contentCount;
	}

	@Override
	public List<Contents> listContent() {
		List<Contents> listContent = session.selectList("listContent");
		log.info("ContentDaoImpl listContent listContent.size() ->" + listContent.size());
		
		return listContent;
	}

	@Override
	public List<Contents> getSearchContentsList(Contents contents) {
		List<Contents> listContent = session.selectList("getSearchContentsList", contents);
		return listContent;
	}

	@Override
	public int getTotalSearchCount(Contents contents) {
		int totalCount = session.selectOne("getTotalSearchCount", contents);
		return totalCount;
	}

}
