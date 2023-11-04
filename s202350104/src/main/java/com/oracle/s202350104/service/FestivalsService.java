package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;

public interface FestivalsService {
	List<FestivalsContent> listFestivals(FestivalsContent festival);
	FestivalsContent       detailFestivals(int contentId);
	int                    totalFestivals();
	void                   insertFestival(FestivalsContent festival);
}
