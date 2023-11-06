package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Areas;

public interface AreasDao {
	List<Areas> listAreas();
	List<Areas> listSigungu(int area);
//	List<Areas> listAreas(Areas area);
	int         totalAreaCode();
	int         conTotalAreaCode(Areas area);
	List<Areas> listSearchAreaCode(Areas area);
}
