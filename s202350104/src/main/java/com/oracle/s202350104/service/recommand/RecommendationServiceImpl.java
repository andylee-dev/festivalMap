package com.oracle.s202350104.service.recommand;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class RecommendationServiceImpl implements RecommendationService {
	private List<RecommendationStrategy> strategies; // 주입받는 다양한 추천 전략들
	
    @Autowired
    public RecommendationServiceImpl(List<RecommendationStrategy> strategies) {
        this.strategies = strategies;
    }

	@Override
	public List<Contents> recommend(Users user) {
		// 각 컨텐츠의 ID를 키로, 점수가 매겨진 컨텐츠를 값으로 하는 맵
		Map<Integer, ScoredContent> scoredContentMap = new HashMap<>();

		// 모든 추천 전략에 대해
		for (RecommendationStrategy strategy : strategies) {
			// 사용자가 null이고 전략이 사용자 기반 추천 전략이라면 건너뛰기
			if (user == null && strategy instanceof UserBasedRecommendationStrategy) {
				continue;
			}
			// 해당 전략을 사용하여 추천 받기
			List<ScoredContent> recommendations = strategy.recommend(user);
			// 모든 추천 결과에 대해
			for (ScoredContent recommendation : recommendations) {
				int contentId = recommendation.getContent().getId();
				// 이미 맵에 같은 ID의 컨텐츠가 있다면 점수를 더하고
				if (scoredContentMap.containsKey(contentId)) {
					ScoredContent existingRecommendation = scoredContentMap.get(contentId);
					double newScore = existingRecommendation.getScore() + recommendation.getScore();
					existingRecommendation.setScore(newScore);
				} else {
					// 없다면 새로 추가
					scoredContentMap.put(contentId, recommendation);
				}
			}
		}

		// 맵의 값들을 리스트로 변환
		List<ScoredContent> scoredRecommendations = new ArrayList<>(scoredContentMap.values());
		// 점수를 기준으로 내림차순 정렬
		scoredRecommendations.sort((sc1, sc2) -> Double.compare(sc2.getScore(), sc1.getScore()));

		// 정렬된 점수가 매겨진 컨텐츠 리스트를 컨텐츠 리스트로 변환하여 반환
		return scoredRecommendations.stream().map(ScoredContent::getContent).collect(Collectors.toList());
	}

    @Override
    public void setStrategies(List<RecommendationStrategy> strategies) {
        this.strategies = strategies;
    }
}
