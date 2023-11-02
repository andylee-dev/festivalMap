package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.AreasDao;
import com.oracle.s202350104.model.Areas;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AreaServiceImpl implements AreaService {
	private final AreasDao ad;

	@Override
	public List<Areas> listPoint() {
		List<Areas> listAreas = ad.listAreas();
		return listAreas;
	}

	@Override
	public List<Areas> listPoint(Areas area) {
		List<Areas> listAreas = ad.listAreas(area);
		return listAreas;
	}

	@Override
	public int totalAreaCode() {
		int totalAreaCode = ad.totalAreaCode();
		return totalAreaCode;
	}
	
	
	
}
