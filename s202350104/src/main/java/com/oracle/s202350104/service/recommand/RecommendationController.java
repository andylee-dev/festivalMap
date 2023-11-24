package com.oracle.s202350104.service.recommand;

import java.util.Optional;
import java.util.UUID;
import java.util.Arrays;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
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

    @GetMapping
    public ResponseEntity<List<Contents>> getRecommendations() {
    	UUID transactionId = UUID.randomUUID();
        try {
        	log.info("[{}]{}:{}", transactionId, "getRecommendations()", "start");
            Optional<Users> user = null;
            int userId = userService.getLoggedInId();
            if (userId == 0) {
                // 비회원일 경우의 추천 로직
                recService.setStrategies(Arrays.asList(
                    new SimilarContentRecommendation(),
                    new PopularContentRecommendation()
                ));
            } else {
                user = userService.getUserById(userId);
                if (!user.isPresent()) {
                    return ResponseEntity.status(HttpStatus.NOT_FOUND).build();
                }
                recService.setStrategies(Arrays.asList(
                    new SimilarContentRecommendation(),
                    new FavoriteBasedRecommendation(),
                    new ReviewBasedRecommendation(),
                    new PopularContentRecommendation(),
                    new SimilarUserRecommendation()
                ));
            }
            List<Contents> recommendations = recService.recommend(user.get());
            /* TODO: (nh)컨텐츠의 리스트를 ajax로 호출해서 페이지에 띄우기 */
            Contents contents= new Contents();
            List<Contents> content = contentService.getSearchContentsList(contents);
            return ResponseEntity.ok(content);
        } catch (Exception e) {
        	log.error("[{}]{}:{}", transactionId, "getRecommendations()", e.getMessage());
            // 적절한 예외 처리
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        } finally {
        	log.info("[{}]{}:{}", transactionId, "getRecommendations()", "end");
        }
    }
}