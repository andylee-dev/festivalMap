package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Tags;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class TagsDaoImpl implements TagsDao {
	
	private final SqlSession session;

	@Override
	public int totalTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}
	
	@Override
	public List<Tags> listTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhTagsListPage", tags);
			log.info("TagsDaoImpl listTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public int totalUserTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhUserTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalUserTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listUserTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhUserTagsListPage", tags);
			log.info("TagsDaoImpl listUserTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listUserTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public int totalBoardTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhBoardTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalBoardTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listBoardTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhBoardTagsListPage", tags);
			log.info("TagsDaoImpl listBoardTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listBoardTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public int totalContentTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhContentTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalContentTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listContentTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhContentTagsListPage", tags);
			log.info("TagsDaoImpl listContentTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listContentTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> listTagsAll() {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhTagsListAll");
			log.info("TagsDaoImpl listTagsAll() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listTagsAll() => " + e.getMessage());
		}
		return listTags;
	}

		/*
		 * @Override public int insertUserTags() { // TODO Auto-generated method stub
		 * return 0; }
		 */
		
		
}
