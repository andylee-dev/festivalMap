package com.oracle.s202350104.service.recommand;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;

import lombok.Data;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequiredArgsConstructor
@Service
public class PopularContentRecommendation implements RecommendationStrategy {

	private final RecommendationDao recommendationDao;

	/**
	 * @brief 인기컨텐츠 리스트 받아오기
	 * 1. 조회수 높은 것.
	 * 2. 리뷰 많은 것.
	 * 3. 리뷰 평점 좋은 것.
	 */
	@Override
	public List<ScoredContent> recommend(Users user, Contents content) {
		UUID transactionId = UUID.randomUUID();
    	log.info("[{}]{}:{}", transactionId, "PopularContentRecommendation()", "start");
    	List<Contents> contentList = recommendationDao.getSearchContentsList(content);
    	List<ScoredContent> scoredContentList = new ArrayList<>();
        for (Contents c : contentList) {
            scoredContentList.add(new ScoredContent(c, 1.0));
        }
    	log.info("[{}]{}:{}", transactionId, "PopularContentRecommendation()", "end");

		return scoredContentList;
	}

}
