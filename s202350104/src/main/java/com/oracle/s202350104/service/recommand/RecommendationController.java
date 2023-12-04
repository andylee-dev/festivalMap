package com.oracle.s202350104.service.recommand;

import java.util.Optional;
import java.util.UUID;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.ContentSerivce;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequestMapping("/recommendations")
@RequiredArgsConstructor
@Slf4j
public class RecommendationController {
    private final RecommendationService recService;
    private final ContentSerivce contentService;
    private final UserService userService;
    @Resource
    private Map<String, RecommendationStrategy> strategies;

    @ResponseBody
    @RequestMapping(value = "getRecommendations", method = RequestMethod.POST)
    public ResponseEntity<List<Contents>> getRecommendations(@RequestBody Contents content) {
    	UUID transactionId = UUID.randomUUID();
    	Optional<Users> user = null;
        List<Contents> recommendations = null;

        try {
        	log.info("[{}]{}:{}", transactionId, "getRecommendations()", "start");
            int userId = userService.getLoggedInId();
            if (userId == 0) {
            	log.info("비회원 로직");
                // 비회원일 경우의 추천 로직
                recService.setStrategies(Arrays.asList(
                		strategies.get("popularContentRecommendation"),
                		strategies.get("SimilarContentRecommendation")
                ));
            } else {
                user = userService.getUserById(userId);
                if (!user.isPresent()) {
                    return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
                }
            	log.info("회원 로직");
                recService.setStrategies(Arrays.asList(
//                    new SimilarContentRecommendation(),
//                    new FavoriteBasedRecommendation(),
//                    new ReviewBasedRecommendation(),
//                    new SimilarUserRecommendation(),
                		strategies.get("ReviewBasedRecommendation")
//                		strategies.get("popularContentRecommendation")
                ));
            }
            if(userId != 0) {
            	recommendations = recService.recommend(user.get(), content);            	
            } else {
            	recommendations = recService.recommend(null, content);            	            	
            }
            
//          Top 10 추천
            List<Contents> subList = new ArrayList<>(recommendations.subList(0,10));
            log.info("recommendations:{}",subList);
            return ResponseEntity.ok(subList);
        } catch (Exception e) {
        	log.error("[{}]{}:{}", transactionId, "getRecommendations()", e.getMessage());
            // 적절한 예외 처리
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } finally {
        	log.info("[{}]{}:{}", transactionId, "getRecommendations()", "end");
        }
    }
}