package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Festivals;

public interface FestivalsService {

	List<Festivals> listFestivals();

	Festivals detailFestivals(int contentId);

}
