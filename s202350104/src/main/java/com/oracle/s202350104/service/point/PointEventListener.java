package com.oracle.s202350104.service.point;

import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class PointEventListener implements ApplicationListener<PointEvent> {
    private final PointHandler pointHandler;

    @Override
    public void onApplicationEvent(PointEvent event) {
    	log.info("onApplicationEvent Start");
        pointHandler.handle(event.getUserId(), event.getPointId());
    	log.info("onApplicationEvent Finish");
    }
}	