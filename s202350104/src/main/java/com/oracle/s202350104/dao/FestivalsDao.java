package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;

public interface FestivalsDao {
	List<FestivalsContent> listFestivals(FestivalsContent festival);
	FestivalsContent detailFestivals(int contentId);
	int              totalFestivals();
	int              insertFestival(FestivalsContent festival);
	int              deleteFestivals(int contentId);
	int              approveFestival(int contentId);
	int              updateFestival(FestivalsContent festival);
}
