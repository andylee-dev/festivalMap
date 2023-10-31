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
	public List<Accomodations> listAccomodations() {
		
		List<Accomodations> listAccomodations = ad.listAccomodations();
		
		if(listAccomodations==null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "숙소 리스트가 존재하지 않습니다");
		}
		
		return listAccomodations;
	}

	@Override
	public AccomodationsContent detailAccomodations(int content_id) {
		AccomodationsContent accomodations = null;
		log.info("AccomodationsImpl detailAccomodation Strart...");
		accomodations = ad.detailAccomodations(content_id);
		
		return accomodations;
	}

}
