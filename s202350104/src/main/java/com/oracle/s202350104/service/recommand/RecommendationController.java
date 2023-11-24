package com.oracle.s202350104.service.recommand;

import java.util.Optional;
import java.util.Arrays;
import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/recommendations")
@RequiredArgsConstructor
public class RecommendationController {
    private final RecommendationService recService;
    private final UserService userService;

    @GetMapping
    public ResponseEntity<List<Contents>> getRecommendations() {
        try {
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
            return ResponseEntity.ok(recommendations);
        } catch (Exception e) {
            // 적절한 예외 처리
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).build();
        }
    }
}