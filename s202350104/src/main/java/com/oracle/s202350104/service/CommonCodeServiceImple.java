package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.CommonCodesDao;
import com.oracle.s202350104.model.CommonCodes;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CommonCodeServiceImple implements CommonCodeService {
	private final CommonCodesDao cd;

	@Override
	public List<CommonCodes> listCommonCode(CommonCodes commonCode) {
		List<CommonCodes> listCommonCodes = cd.listCommonCodes(commonCode);
		return listCommonCodes;
	}

	@Override
	public int totalCommonCode() {
		int totalCommonCode = cd.totalCommonCode();
		return totalCommonCode;
	}

}
