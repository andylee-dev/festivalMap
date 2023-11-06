package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.s202350104.dao.AreasDao;
import com.oracle.s202350104.model.Areas;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
@Transactional
public class AreaServiceImpl implements AreaService {
	private final AreasDao ad;

	@Override
	public List<Areas> listAreas() {
		List<Areas> listAreas = ad.listAreas();
		return listAreas;
	}

	@Override
	public List<Areas> listSigungu(int areaCode ) {
		List<Areas> listSigungu = ad.listSigungu(areaCode);
		return listSigungu;
	}
	
//	@Override
//	public List<Areas> listAreas(Areas area) {
////		List<Areas> listAreas = ad.listAreas(area);
//		return listAreas;
//	}

	@Override
	public int totalAreaCode() {
		int totalAreaCode = ad.totalAreaCode();
		return totalAreaCode;
	}

	@Override
	public int conTotalAreaCode(Areas area) {
		int contTotalAreaCode = ad.conTotalAreaCode(area);
		return contTotalAreaCode;
	}

	@Override
	public List<Areas> listSearchAreaCode(Areas area) {
		List<Areas> listSearchAreaCode = ad.listSearchAreaCode(area);
		return listSearchAreaCode;
	}

	
	
	
}
