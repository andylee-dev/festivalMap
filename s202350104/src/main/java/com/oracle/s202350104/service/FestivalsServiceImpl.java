package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.FestivalsDao;
import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FestivalsServiceImpl implements FestivalsService {
	
	private final FestivalsDao fd;
	
	@Override
	public List<FestivalsContent> listFestivals() {
		List<FestivalsContent> listFestivals = fd.listFestivals();
	
		return listFestivals;
	}

	@Override
	public FestivalsContent detailFestivals(int contentId) {
		FestivalsContent festival = fd.detailFestivals(contentId);
		
		return festival;
	}

}
