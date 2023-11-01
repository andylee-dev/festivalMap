package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.controller.SpotController;
import com.oracle.s202350104.dao.AreasDao;
import com.oracle.s202350104.dao.SpotDao;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SpotServiceImpl implements SpotService {
	
	private final SpotDao sd;

	@Override
	public int totalSpot() {
		int totSpotCnt = sd.totalSpot();
		
		return totSpotCnt;
	}
	
	@Override
	public List<SpotContent> listSpot(SpotContent spotContent) {
		List<SpotContent> spotList = sd.listSpot(spotContent);
		log.info("SpotServiceImpl listSpot spotList.size()->"+spotList.size());
		return spotList;
	}



}
