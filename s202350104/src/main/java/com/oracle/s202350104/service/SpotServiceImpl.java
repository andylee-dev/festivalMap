package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.SpotDao;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SpotServiceImpl implements SpotService {
	
	private final SpotDao sd;

	@Override
	public List<Spot> listSpot(SpotContent spotContent) {
		List<Spot> spotList = sd.listSpot(spotContent);
		return spotList;
	}

}
