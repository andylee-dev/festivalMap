package com.oracle.s202350104.dao;

import java.util.List;
import java.util.Map;

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
	public int totalTags(Tags tags) {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhTagsTotal", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl totalTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}
	
	@Override
	public List<Tags> listTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhTagsListAll", tags);
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

	@Override
	public int insertTags(Tags tags) {
		int result = 0;
		try {
			result = session.insert("nhTagsInsert", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl insertTags() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public Tags selectTags(int id) {
		Tags tags = null;
		try {
			tags = session.selectOne("nhTagsSelect", id);
			log.info("TagsDaoImpl selectTags() => " + tags.getName());
		} catch(Exception e) {
			log.info("TagsDaoImpl selectTags() => " + e.getMessage());
		}
		return tags;
	}

	@Override
	public int updateTags(Tags tags) {
		int result = 0;
		try {
			result = session.update("nhTagsUpdate", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl insertTags() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteTags(int id) {
		int result = 0;
		try {
			session.delete("nhUserTagsDelete", id);
			session.delete("nhContentTagsDelete", id);
			session.delete("nhBoardTagsDelete", id);
			result = session.delete("nhTagsDelete", id);
		} catch(Exception e) {
			log.info("TagsDaoImpl deleteTags() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public List<Tags> listBoardTags(int smallCode) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhBoardTagsAll", smallCode);
			log.info("TagsDaoImpl listBoardTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listBoardTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> searchContentTags(int contentId) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhContentTagOne", contentId);
			log.info("TagsDaoImpl searchContentTags() => " + listTags.size());
		} catch (Exception e) {
			log.info("TagsDaoImpl searchContentTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> listUserTags() {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhUserTagsAll");
			log.info("TagsDaoImpl listUserTags() => " + listTags.size());
		} catch (Exception e) {
			log.info("TagsDaoImpl listUserTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> listContentTags(int bigCode) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhContentTagsAll", bigCode);
			log.info("TagsDaoImpl listContentTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listContentTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> searchBoardTagsOne(int boardId) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhBoardTagOne", boardId);
			log.info("TagsDaoImpl listContentTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listContentTags() => " + e.getMessage());
		}
		return listTags;
	}
	
	/*
	 * 통합게시물 생성 Logic 
	 * by. 엄민용
	 * >> boardTagsInsert, boardTagDetail, boardTagDelete
	 * */	
	@Override
	public void boardTagsInsert(Tags tags) {
		log.info("service getTag_id : {}", tags.getTag_id());
		log.info("service getBoard_id : {}", tags.getBoard_id());
		
		session.insert("myinsertBoardTags", tags);
	}
	
	@Override
	public List<Tags> boardTagDetail(int id) {
		List<Tags> hashTags = session.selectList("myBoardTag", id);
		return hashTags;
	}
	
	@Override
	public int boardTagDelete(int id) {
		int deleteResult = session.delete("mydeleteBoardTags", id);
		
		return deleteResult;
	}

}
