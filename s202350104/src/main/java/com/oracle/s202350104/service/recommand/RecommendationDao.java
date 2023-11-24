package com.oracle.s202350104.service.recommand;

import java.util.List;

import com.oracle.s202350104.model.Contents;

public interface RecommendationDao {
	public List<Contents> getSearchContentsList(Contents contents);
	public List<Contents> getPopularContentsList(Contents content);
}
