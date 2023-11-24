package com.oracle.s202350104.service.recommand;

import java.util.ArrayList;
import java.util.Collections;
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
	/* (nh)TODO: ㅇㅇ.. */
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
    	List<Contents> contentList = recommendationDao.getPopularContentsList(content);
    	List<ScoredContent> scoredContentList = new ArrayList<>();
    	
    	// 점수 가중치
        for(Contents c : contentList) {
        	double scoreReadcount = c.getReadcount() * 0.5; 		// 조회수
        	double scoreAvg_score = c.getAvg_score() * 0.3;			// 리뷰평점평균
        	double scoreReview_count = c.getReview_count() * 0.2;	// 리뷰수
        	double score = scoreReadcount + scoreAvg_score + scoreReview_count;
            scoredContentList.add(new ScoredContent(c, score));
        }
        
        // 버블 정렬로 점수 높은 순으로 정렬
        for(int i=0; i<contentList.size(); i++) {
        	for(int j=0; j<contentList.size()-(i+1); j++) {
        		if(scoredContentList.get(j).getScore() < scoredContentList.get(j+1).getScore()) {
        			ScoredContent lower_sc = null;
        			ScoredContent higer_sc = null;
        			lower_sc = scoredContentList.get(j);
        			higer_sc = scoredContentList.get(j+1);
        			scoredContentList.set(j, lower_sc);
        			scoredContentList.set(j+1, higer_sc);
        		}
        	}
        }
        
    	log.info("[{}]{}:{}", transactionId, "PopularContentRecommendation()", "end");

		return scoredContentList;
	}

}
