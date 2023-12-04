package com.oracle.s202350104.service.recommand;

import java.util.List;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Contents;

public interface RecommendationDao {
	public List<Contents> getSearchContentsList(Contents contents);
	public List<Contents> getPopularContentsList(Contents content);
	public List<Board> getUserReviews(int id);
	public List<Board> getAllReviews(Contents content);
	public Board getUserReviewForContent(Integer userId, int id);
}
