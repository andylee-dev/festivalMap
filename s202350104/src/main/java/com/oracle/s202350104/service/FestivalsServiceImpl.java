package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.FestivalsDao;
import com.oracle.s202350104.model.Festivals;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FestivalsServiceImpl implements FestivalsService {
	
	private final FestivalsDao fd;
	
	@Override
	public List<Festivals> listFestivals() {
		List<Festivals> listFestivals = fd.listFestivals();
	
		return listFestivals;
	}

	@Override
	public Festivals detailFestivals(int contentId) {
		Festivals festival = fd.detailFestivals(contentId);
		
		return festival;
	}

}
