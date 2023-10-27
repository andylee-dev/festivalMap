package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.AccomodationDao;
import com.oracle.s202350104.model.Accomodation;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccomodationServiceImpl implements AccomodationService {
	
	private final AccomodationDao ad;

	@Override
	public List<Accomodation> listAccomodation() {
		
		List<Accomodation> listAccomodation = ad.listAccomodation();
		
		return listAccomodation;
	}

}
