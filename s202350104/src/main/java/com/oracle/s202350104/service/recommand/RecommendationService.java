package com.oracle.s202350104.service.recommand;

import java.util.List;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Users;

public interface RecommendationService {
	 List<Contents> recommend(Users user, Contents content);

	void setStrategies(List<RecommendationStrategy> asList);
}
