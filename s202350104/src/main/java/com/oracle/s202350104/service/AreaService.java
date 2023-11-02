package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Areas;

public interface AreaService {
	List<Areas> listPoint();
	List<Areas> listPoint(Areas area);
	int 		totalAreaCode();
}
	