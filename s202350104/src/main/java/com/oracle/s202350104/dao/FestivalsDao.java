package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;

public interface FestivalsDao {
	List<FestivalsContent> listFestivals(FestivalsContent festival);
	FestivalsContent detailFestivals(int contentId);
	int              totalFestivals(FestivalsContent festival);
	int              insertFestival(FestivalsContent festival);
	int              deleteFestivals(int contentId);
	int              approveFestival(int contentId);
	int              updateFestival(FestivalsContent festival);
	int              readcountUp(int contentId);
	Contents         detailContents(int contentId);
}
