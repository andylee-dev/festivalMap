package com.oracle.s202350104.service.recommand;

import java.util.List;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;

public class SimilarContentRecommendation implements RecommendationStrategy {

	@Override
	public List<ScoredContent> recommend(Users user,Contents content) {
		/**
		 * 컨텐츠간의 유사도를 측정해서 추천 
		 */
		return null;
	}

}
