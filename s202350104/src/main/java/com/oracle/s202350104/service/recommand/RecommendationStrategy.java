package com.oracle.s202350104.service.recommand;

import java.util.List;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;

public interface RecommendationStrategy {
    List<ScoredContent> recommend(Users user, Contents content);
}
