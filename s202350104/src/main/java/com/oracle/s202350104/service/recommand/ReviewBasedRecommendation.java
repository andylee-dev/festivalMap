package com.oracle.s202350104.service.recommand;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service("ReviewBasedRecommendation") 
@RequiredArgsConstructor
public class ReviewBasedRecommendation implements UserBasedRecommendationStrategy {
	private final RecommendationDao recommendationDao;

	@Override
	public List<ScoredContent> recommend(Users user, Contents content) {
		UUID transactionId = UUID.randomUUID();
		List<ScoredContent> scoredContentList = new ArrayList<>();
        try {
        	log.info("[{}]{}:{}", transactionId, "ReviewBasedRecommendation", "start");
		
			List<Board> userReviews = recommendationDao.getUserReviews(user.getId());
			List<Board> allReviews = recommendationDao.getAllReviews(content);
			List<Contents> contentList = recommendationDao.getSearchContentsList(content);
			
			Map<Integer, List<Board>> userReviewsMap = allReviews.stream().collect(Collectors.groupingBy(Board::getUser_id));
			Map<Integer, Double> userSimilarities = new HashMap<>();
			
			for (Integer userId : userReviewsMap.keySet()) {
				double similarity = SimilarityUtils.calculateCosineSimilarity(userReviews, userReviewsMap.get(userId));
				userSimilarities.put(userId, similarity);
			}
	
			for (Contents c : contentList) {
				double score = 0.0;
				for (Integer userId : userSimilarities.keySet()) {
	                Board review = recommendationDao.getUserReviewForContent(userId, c.getId());
					if (review != null) {
						score += userSimilarities.get(userId) * review.getScore();
						log.info("1.score = {}",score);
					}
				}
				log.info("2.score = {}",score);
				scoredContentList.add(new ScoredContent(c, score));
			}
		
			Collections.sort(scoredContentList, (sc1, sc2) -> Double.compare(sc2.getScore(), sc1.getScore()));
			for (ScoredContent sc : scoredContentList) {
				log.info("id:{} score:{}",sc.getContent().getId(),sc.getScore());
			}
		
        } catch (Exception e) {
        	log.error("[{}]{}:{}", transactionId, "ReviewBasedRecommendation()", e.getMessage());
        } finally {
        	log.info("[{}]{}:{}", transactionId, "ReviewBasedRecommendation()", "end");
        }
	    return scoredContentList;
	}

}
