package com.oracle.s202350104.service;

import java.util.List;
import java.util.Map;

import com.oracle.s202350104.model.Areas;

public interface AreaService {
	List<Areas> listAreas();
	List<Areas> listSigungu(int areaCode);
	List<Areas> listAreas(Areas area);
	int 		totalAreaCode();
	int         conTotalAreaCode(Areas area);
	List<Areas> listSearchAreaCode(Areas area);
	Map<String, String> getAreaNamesByCode(int areaCode, int sigunguCode);
	int         insertArea(Areas area);
	int         deleteAreaCode(int area);
}
	