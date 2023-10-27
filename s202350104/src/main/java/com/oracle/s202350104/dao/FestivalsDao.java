package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Festivals;

public interface FestivalsDao {

	List<Festivals> listFestivals();

	Festivals detailFestivals(int contentId);

}
