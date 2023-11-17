package com.oracle.s202350104.service.point;

import org.springframework.context.ApplicationEvent;

public class PointEvent extends ApplicationEvent {
    private int userId;
    private int pointId;

    public PointEvent(int userId, int pointId) {
        super(userId);
        this.userId = userId;
        this.pointId = pointId;
    }

    public int getUserId() {
        return userId;
    }

    public int getPointId() {
        return pointId;
    }
}
