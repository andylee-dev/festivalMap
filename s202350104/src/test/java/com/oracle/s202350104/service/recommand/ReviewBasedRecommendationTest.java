package com.oracle.s202350104.service.recommand;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.mockito.junit.jupiter.MockitoExtension;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.mockito.Mockito.*;


@ExtendWith(MockitoExtension.class)
class ReviewBasedRecommendationTest {

    @Mock
    RecommendationDao recommendationDao;

    @InjectMocks
    ReviewBasedRecommendation reviewBasedRecommendation;

    @Test
    void recommend() {
        // 대량의 테스트 데이터 생성
        Users user = new Users();
        Contents content = new Contents();

        List<Board> userReviews = new ArrayList<>();
        for (int i = 0; i < 10000; i++) {
            Board board = new Board();
            board.setContent_id(i); // 고유한 content_id 설정
            // board의 다른 필드 설정
            userReviews.add(board);
        }

        List<Board> allReviews = new ArrayList<>();
        for (int i = 0; i < 100000; i++) {
            Board board = new Board();
            board.setContent_id(i); // 고유한 content_id 설정
            // board의 다른 필드 설정
            allReviews.add(board);
        }

        List<Contents> contentList = new ArrayList<>();
        for (int i = 0; i < 10000; i++) {
            Contents contents = new Contents();
            contents.setId(i); // 고유한 id 설정
            // contents의 다른 필드 설정
            contentList.add(contents);
        }

        when(recommendationDao.getUserReviews(anyInt())).thenReturn(userReviews);
        when(recommendationDao.getAllReviews(any())).thenReturn(allReviews);
        when(recommendationDao.getSearchContentsList(any())).thenReturn(contentList);
        when(recommendationDao.getUserReviewForContent(anyInt(), anyInt())).thenReturn(new Board());

        long startTime = System.currentTimeMillis();

        // 테스트 대상 메소드 실행
        List<ScoredContent> result = reviewBasedRecommendation.recommend(user, content);

        long endTime = System.currentTimeMillis();

        // 실행 시간 출력
        long executionTime = endTime - startTime;
        System.out.println("Execution time: " + executionTime + "ms");

        // 기타 필요한 검증 수행
        // ...
    }
    
    @Test
    void recommend2() {
        // 대량의 테스트 데이터 생성
        Users user = new Users();
        Contents content = new Contents();

        List<Board> userReviews = new ArrayList<>();
        for (int i = 0; i < 10000; i++) {
            Board board = new Board();
            board.setContent_id(i); // 고유한 content_id 설정
            // board의 다른 필드 설정
            userReviews.add(board);
        }

        List<Board> allReviews = new ArrayList<>();
        for (int i = 0; i < 100000; i++) {
            Board board = new Board();
            board.setContent_id(i); // 고유한 content_id 설정
            // board의 다른 필드 설정
            allReviews.add(board);
        }

        List<Contents> contentList = new ArrayList<>();
        for (int i = 0; i < 10000; i++) {
            Contents contents = new Contents();
            contents.setId(i); // 고유한 id 설정
            // contents의 다른 필드 설정
            contentList.add(contents);
        }

        when(recommendationDao.getUserReviews(anyInt())).thenReturn(userReviews);
        when(recommendationDao.getAllReviews(any())).thenReturn(allReviews);
        when(recommendationDao.getSearchContentsList(any())).thenReturn(contentList);
        when(recommendationDao.getUserReviewForContent(anyInt(), anyInt())).thenReturn(new Board());

        long startTime = System.currentTimeMillis();

        // 테스트 대상 메소드 실행
        List<ScoredContent> result = reviewBasedRecommendation.recommend(user, content);

        long endTime = System.currentTimeMillis();

        // 실행 시간 출력
        long executionTime = endTime - startTime;
        System.out.println("Execution time: " + executionTime + "ms");

        // 기타 필요한 검증 수행
        // ...
    }
}