package com.oracle.s202350104.service.point;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.function.BiConsumer;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.oracle.s202350104.model.Contents;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class PointHandlerImpl implements PointHandler {
	private final PointService pointService;
	private Map<Integer, BiConsumer<Integer, Integer>> handlerMap;

    @PostConstruct
    public void init() {
        handlerMap = new HashMap<>();
        handlerMap.put(9, this::handleLogin);
        handlerMap.put(2, this::handleReview);
    }

    private void handleLogin(int userId, int pointId) {
        try {
            log.info("사용자 ID {}가 로그인하여 포인트 ID {}에 대한 포인트를 추가했습니다.", userId, pointId);

            // 포인트 추가 및 이력 기록
            pointService.addPointAndHistory(userId, pointId);
        } catch (Exception e) {
            log.error("로그인 처리 중 오류 발생: {}", e.getMessage());
        }
    }
    private void handleReview(int userId, int pointId) {
        // 리뷰 이벤트에 대한 로직
        pointService.addPointAndHistory(userId, pointId);
    }
    @Override
    public void handle(int userId, int pointId) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "PointHandlerImpl", "start");        
			if (handlerMap.containsKey(pointId)) {
	            handlerMap.get(pointId).accept(userId, pointId);
	        } else {
	            throw new IllegalArgumentException("Invalid pointId: " + pointId);
	        }
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "PointHandlerImpl", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "PointHandlerImpl", "end");
		}		
    }
}
