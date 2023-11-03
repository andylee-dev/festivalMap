package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.CommonCodes;

public interface CommonCodeService {
	List<CommonCodes> listCommonCode();
	List<CommonCodes> listCommonCode(CommonCodes commonCode);
	int 			  totalCommonCode();
	int 			  conTotalCommonCode(CommonCodes commonCode);
	List<CommonCodes> listSearchCommonCode(CommonCodes commonCode);
}
