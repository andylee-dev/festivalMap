package com.oracle.s202350104.service.recommand;

import java.util.List;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;
/* (nh)TODO: ㅇㅇ.. */
public class SimilarContentRecommendation implements RecommendationStrategy {

	/**
	 * @brief 유사한 인기컨텐츠 리스트 받아오기
	 * 1. small_code가 같은 것, '음식' 이라면 한식,중식,양식 등등.
	 * 2. keyword가 같은 것.
	 */ 
	@Override
	public List<ScoredContent> recommend(Users user,Contents content) {
		/**
		 * 컨텐츠간의 유사도를 측정해서 추천 
		 */
		return null;
	}

}
