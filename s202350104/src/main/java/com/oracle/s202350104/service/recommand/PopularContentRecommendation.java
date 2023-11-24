package com.oracle.s202350104.service.recommand;

import java.util.List;

import com.oracle.s202350104.model.Users;

public class PopularContentRecommendation implements RecommendationStrategy {

	/**
	 * @brief 인기컨텐츠 리스트 받아오기
	 * 1. 조회수 높은 것.
	 * 2. 리뷰 많은 것.
	 * 3. 리뷰 평점 좋은 것.
	 */
	@Override
	public List<ScoredContent> recommend(Users user) {
		
		/**
			SELECT c.id, c.readcount, COUNT(b.content_id) AS review_count, 
			AVG(b.score) AS avg_score
			FROM contents c
			LEFT JOIN board b ON c.id = b.content_id AND b.big_code = 2 AND b.small_code = 6
			WHERE c.big_code = 11
			GROUP BY c.id, c.big_code, c.readcount
			ORDER BY c.readcount DESC, review_count DESC, avg_score DESC;		
	 	*/
		return null;
	}

}
