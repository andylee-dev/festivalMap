package com.oracle.s202350104.service.recommand;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Contents;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class RecommendationDaoImpl implements RecommendationDao {
	private final SqlSession session;
	
	@Override
	public List<Contents> getSearchContentsList(Contents contents) {
		log.info("getSearchContentsList s/{}",contents);
		List<Contents> listContent = session.selectList("getSearchContentsList", contents);
		log.info("getSearchContentsList f/{}",listContent);
		return listContent;
	}

	@Override
	public List<Contents> getPopularContentsList(Contents content) {
		log.info("getSearchContentsList s/{}",content);
		List<Contents> listContent = session.selectList("getPopularContentsList", content);
		log.info("getSearchContentsList f/{}",listContent);
		return listContent;
	}

	@Override
	public List<Board> getUserReviews(int user_id) {
		log.info("getUserReviews s/{}",user_id);
		List<Board> userReviews = session.selectList("getUserReviews", user_id);
		log.info("getUserReviews f/{}",userReviews);
		return userReviews;
	}

	@Override
	public List<Board> getAllReviews(Contents content) {
		log.info("getAllReviews s/{}",content);
		List<Board> listReviews = session.selectList("getAllReviews",content);
		log.info("getAllReviews f/{}",listReviews);
		return listReviews;
	}

	@Override
	public Board getUserReviewForContent(Integer userId, int contentId) {
		Contents content =new Contents();
		content.setUser_id(userId.toString());
		content.setId(contentId);
		log.info("getUserReviewForContent s/ userId:{},contentId:{}",userId, contentId);
		Board review = session.selectOne("getUserReviewForContent", content);
		log.info("getUserReviewForContent f/{}",review);
		return review;
	}
}
