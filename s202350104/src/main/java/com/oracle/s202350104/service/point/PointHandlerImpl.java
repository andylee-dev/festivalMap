package com.oracle.s202350104.service.point;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;
import java.util.function.BiConsumer;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.stereotype.Service;

import com.oracle.s202350104.model.Contents;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


/*eventPublisher.publishEvent(new PointEvent(userid, 2));
private final ApplicationEventPublisher eventPublisher;
*/

@Slf4j
@Service
@RequiredArgsConstructor
public class PointHandlerImpl implements PointHandler {
    private final PointService pointService;
    private Map<Integer, BiConsumer<Integer, Integer>> handlerMap;
    private LocalDateTime lastLoginTime; // 마지막 로그인 시간 추적

    @PostConstruct
    public void init() {
        handlerMap = new HashMap<>();
        handlerMap.put(9, this::handleLogin);
        handlerMap.put(1, this::handleJoin);
        handlerMap.put(2, this::handleInsertBoard);
        handlerMap.put(3, this::handleInsertComment);
        handlerMap.put(5, this::handleEventPoint);
        lastLoginTime = LocalDateTime.now().minusDays(1); // 초기값으로 어제 시간 설정
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

    private void handleJoin(int userId, int pointId) {
    	 try {
    	        log.info("사용자 ID {}가 가입을 하여 포인트 ID {}에 대한 포인트를 추가했습니다.", userId, pointId);

    	        // 포인트 추가 및 이력 기록
    	        pointService.addPointAndHistory(userId, pointId);
    	    } catch (Exception e) {
    	        log.error("리뷰 작성 처리 중 오류 발생: {}", e.getMessage());
    	    }
    	}
    private void handleInsertBoard(int userId, int pointId) {
   	 try {
   	        log.info("사용자 ID {}가 게시물를 작성하여 포인트 ID {}에 대한 포인트를 추가했습니다.", userId, pointId);

   	        // 포인트 추가 및 이력 기록
   	        pointService.addPointAndHistory(userId, pointId);
   	    } catch (Exception e) {
   	        log.error("게시물 작성 처리 중 오류 발생: {}", e.getMessage());
   	    }
   	}
    
    private void handleInsertComment(int userId, int pointId) {
      	 try {
      	        log.info("사용자 ID {}가 댓글을 작성하여 포인트 ID {}에 대한 포인트를 추가했습니다.", userId, pointId);

      	        // 포인트 추가 및 이력 기록
      	        pointService.addPointAndHistory(userId, pointId);
      	    } catch (Exception e) {
      	        log.error("게시물 작성 처리 중 오류 발생: {}", e.getMessage());
      	    }
      	}
    private void handleEventPoint(int userId, int pointId) {
     	 try {
     	        log.info("사용자 ID {}가 이벤트를 참여하여 포인트 ID {}에 대한 포인트를 추가했습니다.", userId, pointId);

     	        // 포인트 추가 및 이력 기록
     	        pointService.addPointAndHistory(userId, pointId);
     	    } catch (Exception e) {
     	        log.error("게시물 작성 처리 중 오류 발생: {}", e.getMessage());
     	    }
     	}
    @Override
    public void handle(int userId, int pointId) {
        UUID transactionId = UUID.randomUUID();
        try {
            log.info("[{}]{}:{}", transactionId, "PointHandlerImpl", "start");
            
//            LocalDateTime currentDateTime = LocalDateTime.now();
//            LocalDate currentDate = currentDateTime.toLocalDate();
//            LocalTime currentTime = currentDateTime.toLocalTime();
//            
            // 오늘 첫 로그인 시간인 경우에만 handleLogin 호출
//            if (currentDate.isAfter(lastLoginTime.toLocalDate()) || currentTime.isBefore(LocalTime.NOON)) {
                if (handlerMap.containsKey(pointId)) {
                    handlerMap.get(pointId).accept(userId, pointId);
                    
                    // 마지막 로그인 시간 갱신
//                    lastLoginTime = currentDateTime;
                } else {
                    throw new IllegalArgumentException("Invalid pointId: " + pointId);
                }
//            }
        } catch (Exception e) {
            log.error("[{}]{}:{}", transactionId, "PointHandlerImpl", e.getMessage());
        } finally {
            log.info("[{}]{}:{}", transactionId, "PointHandlerImpl", "end");
        }
    }
}