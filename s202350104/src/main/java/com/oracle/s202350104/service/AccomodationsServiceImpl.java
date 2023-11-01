package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.AccomodationsDao;
import com.oracle.s202350104.model.Accomodations;
import com.oracle.s202350104.model.AccomodationsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class AccomodationsServiceImpl implements AccomodationsService {
	
	private final AccomodationsDao ad;

	@Override
	public List<AccomodationsContent> listAccomodations(AccomodationsContent accomodations) {
		
		List<AccomodationsContent> listAccomodations = ad.listAccomodations(accomodations);
		
		if(listAccomodations==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙소 리스트가 존재하지 않습니다");
		}
		
		return listAccomodations;
	}

	@Override
	public AccomodationsContent detailAccomodations(int content_id) {
		AccomodationsContent accomodations = ad.detailAccomodations(content_id);
		log.info("AccomodationsImpl detailAccomodation Strart...");
		if(accomodations==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙소 정보가 존재하지 않습니다");
		}
		
		return accomodations;
	}

	@Override
	public int totalAccomodations() {
		int totalAccomodations = 0;
		totalAccomodations = ad.totalAccomodations();
		return totalAccomodations;
	}

}
