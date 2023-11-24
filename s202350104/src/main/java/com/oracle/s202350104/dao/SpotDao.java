package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

public interface SpotDao {

	List<SpotContent> listSpot(SpotContent spotContent);
	SpotContent       detailSpot(int contentId);
	int               insertSpot(SpotContent spotContent);
	int               updateSpot(SpotContent spot);
	int               deleteSpot(SpotContent spot);
	int               approveSpot(SpotContent spot);
	List<SpotContent> listSpot3(SpotContent spotContent);
	int               totalSearchSpot(SpotContent spotContent); //테마별조회

}
