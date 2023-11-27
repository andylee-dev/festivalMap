package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.AccomodationDao;
import com.oracle.s202350104.model.AccomodationContent;
import com.oracle.s202350104.model.RestaurantsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AccomodationServiceImpl implements AccomodationService {
	
	private final AccomodationDao ad;

	@Override
	public List<AccomodationContent> listAccomodation(AccomodationContent accomodation) {
		
		List<AccomodationContent> listAccomodation = ad.listAccomodation(accomodation);
		
		if(listAccomodation==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙소 리스트가 존재하지 않습니다");
		}
		
		return listAccomodation;
	}

	@Override
	public AccomodationContent detailAccomodation(int contentId) {
		AccomodationContent accomodation = ad.detailAccomodation(contentId);
		log.info("AccomodationsImpl detailAccomodation Strart...");
		if(accomodation==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙소 정보가 존재하지 않습니다");
		}
		
		return accomodation;
	}

	@Override
	public int totalAccomodation() {
		int	totalAccomodation = ad.totalAccomodation();
		return totalAccomodation;
	}

	@Override
	public int accomodationDelete(int contentId) {
		int accomodationDelete = 0;
		
		accomodationDelete = ad.accomodationDelete(contentId);
		
		return accomodationDelete;
	}

	@Override
	public void insertAccomodation(AccomodationContent accomodation) {
		int contentResult = 0;
		contentResult = ad.insertContent(accomodation);
		int accomodationResult = 0;
		accomodationResult = ad.insertAccomodation(accomodation);
		
		if(contentResult <= 0 || accomodationResult <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙박 정보 등록에 실패하였습니다.");
		}
	}

	@Override
	public int updateAccomodation(AccomodationContent accomodation) {
		
		int result = ad.updateAccomodation(accomodation);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙박 정보 수정에 실패하였습니다.");
		}
		
		return result;
	}

	@Override
	public int approveAccomodation(int contentId) {
		int result = ad.approveAccomodation(contentId);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙박 정보 승인에 실패하였습니다.");
		}
		
		return result;
	}

	@Override
	public List<AccomodationContent> listSmallCode(AccomodationContent accomodationContent) {
		
		List<AccomodationContent> listSmallCode = ad.listSmallCode(accomodationContent);		
		
		return listSmallCode;
	}

	@Override
	public List<AccomodationContent> listSearchAccomodation(AccomodationContent accomodationContent) {
		
		List<AccomodationContent> listSearchAccomodation = ad.listSearchAccomodation(accomodationContent);
				
		return listSearchAccomodation;
	}

	@Override
	public int totalSearchAccomodation(AccomodationContent accomodationContent) {
		int totalSearchAccomodation = ad.totalSearchAccomodation(accomodationContent);
		return totalSearchAccomodation;
	}

	@Override
	public int conTotalAccomodation(AccomodationContent accomodation) {
		int conTotalAccomodaiton = ad.conTotalAccomdation(accomodation);
		return conTotalAccomodaiton;
	}

	@Override
	public List<AccomodationContent> indexlistSearchAccomodation(AccomodationContent accomodation) {
		List<AccomodationContent> indexlistSearchAccomodation = ad.indexlistSearchAccomodation(accomodation);
		return indexlistSearchAccomodation;
	}

	@Override
	public int admintotalAccomodation() {
		int	totalAccomodation = ad.admintotalAccomodation();
		return totalAccomodation;
	}
		

}
