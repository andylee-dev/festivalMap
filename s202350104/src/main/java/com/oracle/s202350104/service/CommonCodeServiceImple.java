package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

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
	public List<CommonCodes> listCommonCode() {
		List<CommonCodes> listCommonCodes = cd.listCommonCodes();
		return listCommonCodes;
	}

	
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


	@Override
	public int conTotalCommonCode(CommonCodes commonCode) {
		int conTotalCommonCode = cd.conTotalCommonCode(commonCode);
		return conTotalCommonCode;
	}


	@Override
	public List<CommonCodes> listSearchCommonCode(CommonCodes commonCode) {
		List<CommonCodes> listSearchCommonCode = cd.listSearchCommonCode(commonCode);
		return listSearchCommonCode;
	}


	@Override
	public int insertCommonCode(CommonCodes commonCode) {
		int result = 0;
		result = cd.insertCommonCode(commonCode);
		
		if(result >= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND);
		}
		return result;
	}


	@Override
	public int deleteCommonCode(CommonCodes commonCode) {
		int result = 0;
		result = cd.deleteCommonCode(commonCode);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND);
		}
		return result;
	}


	@Override
	public CommonCodes detailCommonCode(CommonCodes commonCode) {
		CommonCodes detailCommonCode = cd.detailCommonCode(commonCode);
		
		if(detailCommonCode == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "공통코드 정보가 없습니다");
		}
		
		return detailCommonCode;
	}


	
}
