package com.oracle.s202350104.service.recommand;

import com.oracle.s202350104.model.Contents;

import lombok.Data;

@Data
public class ScoredContent {
    private Contents content;
    private double score;

    public ScoredContent(Contents content, double score) {
        this.content = content;
        this.score = score;
    }
}
