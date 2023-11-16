package com.oracle.s202350104.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.server.ResponseStatusException;

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
	
	@Override
	public List<Areas> listAreas(Areas area) {
		List<Areas> listAreas = ad.listAreas(area);
		return listAreas;
	}

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

//	@Override
//	public String getAreaNameByCode(int areaCode) {
//		return ad.getAreaNameByCode(areaCode);
//	}
//
//	@Override
//	public String getSigunguNameByCode(int area, int sigungu) {
//		return ad.getSigunguNameByCode(area,sigungu);
//	}

	@Override
    public Map<String, String> getAreaNamesByCode(int areaCode, int sigunguCode) {
        Map<String, String> areaNames = new HashMap<>();
        
        String area = ad.getAreaNameByCode(areaCode);
        if (area != null) {
            areaNames.put("area", area);
        }
        
        String sigungu = ad.getSigunguNameByCode(areaCode,sigunguCode);
        if (sigungu != null) {
            areaNames.put("sigungu",sigungu);
        }
        
        return areaNames;
    }

	@Override
	public int insertArea(Areas area) {
		int result = 0;
		result = ad.insertArea(area);
		
		if(result >= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND);
		}
		return result;
	}

}
