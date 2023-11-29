package com.oracle.s202350104.service.recommand;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.ContentsDao;
import com.oracle.s202350104.dao.TagsDao;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
/* (nh)TODO: ㅇㅇ.. */

@Slf4j
@RequiredArgsConstructor
@Service
public class SimilarContentRecommendation implements RecommendationStrategy {

	private final ContentsDao contentsDao;
	private final TagsDao tagsDao;
	/**
	 * @brief 유사한 인기컨텐츠 리스트 받아오기
	 * 1. small_code가 같은 것, '음식' 이라면 한식,중식,양식 등등.
	 * 2. keyword가 같은 것.
	 */ 
	@Override
	public List<ScoredContent> recommend(Users user, Contents content) {
		/**
		 * 컨텐츠간의 유사도를 측정해서 추천 
		 */  
		
		// 임의로 지정
		content.setSmall_code(15);
		content.setId(2403896);
		
		List<Contents> contentList = contentsDao.getSearchContentsList(content);
		List<ScoredContent> recommendContentList = new ArrayList<>();
		List<Tags> target_tags = tagsDao.searchContentTags(content.getId());
		
		for(Contents c : contentList) {
			log.info("c=>"+c.getTitle());
			
			// 지역 유사도 점수 계산
			double areaSimilarity = 0.0;
			
			if(c.getArea() == content.getArea() && c.getSigungu() == content.getSigungu()) {
				areaSimilarity = 10.0; // 시도와 시군구 모두 같은 경우 최고점수 10점
			} else if(c.getArea() == content.getArea() && c.getSigungu() != content.getSigungu()) {
				areaSimilarity = 7.0; // 시도만 같은 경우 7점
			} else {
				areaSimilarity = 5.0; // 그외 경우 1점
			}
			
			log.info("areaSimilarity=>"+areaSimilarity);
			
			
			// 태그 유사도 점수 계산
			List<Tags> tags = tagsDao.searchContentTags(c.getId());
			
			double similarTagsCnt = 0.0; // 일치하는 태그 개수
			double target_TagsCnt = (double)target_tags.size(); // 추천 대상 컨텐츠의 태그 개수
			double c_TagsCnt = (double)tags.size();      // 추천 후보 컨텐츠의 태그 개수 
			
			for(int i=0; i<target_tags.size(); i++) {
				for(int j=0; j<tags.size(); j++) {
					if(target_tags.get(i).getId() == tags.get(j).getId()) {
						similarTagsCnt = similarTagsCnt++;
					}
				}	
			}
			
			double denominator = Math.sqrt(target_TagsCnt) * Math.sqrt(c_TagsCnt);
			
			double tagSimilarity = 0.0;
			if (denominator != 0) {
				tagSimilarity = similarTagsCnt / denominator * 10.0;
			} else {
				tagSimilarity = 0.0;
			}
					
			log.info("tagSimilarity=>"+tagSimilarity);
			
			
			double finalScore = areaSimilarity + tagSimilarity;
			
			// 최종 점수가 10.0 이상인 것만 추천 컨텐츠 리스트에 추가
			if(finalScore > 10.0) { 
				recommendContentList.add(new ScoredContent(c, finalScore));
			}
		}
		
		// 비교를 하기 위해 꺼내는 컨텐츠. 1부터 인덱스 시작
		for(int i=1; i<recommendContentList.size(); i++) {
			// 꺼낸 컨텐츠보다 작은 인덱스들과 비교(i-1)
			for(int j=i-1; j>-1; j--) {
				if(recommendContentList.get(i).getScore() < recommendContentList.get(j).getScore()) {
					Collections.swap(recommendContentList, i, j);
					i = j; // swap으로 인덱스 바뀜
				}
			}
		}
		
		return recommendContentList;
	}

}
