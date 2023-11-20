package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.CommonCodes;

public interface CommonCodesDao {
	List<CommonCodes> listCommonCodes();
	List<CommonCodes> listCommonCodes(CommonCodes commonCode);
	int 			  totalCommonCode();
	int               conTotalCommonCode(CommonCodes commonCode);
	List<CommonCodes> listSearchCommonCode(CommonCodes commonCode);
	int               insertCommonCode(CommonCodes commonCode);
	int               deleteCommonCode(CommonCodes commonCode);
	CommonCodes       detailCommonCode(CommonCodes commonCode);
}
