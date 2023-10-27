package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.AccomodationsDao;
import com.oracle.s202350104.model.Accomodations;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AccomodationsServiceImpl implements AccomodationsService {
	
	private final AccomodationsDao ad;

	@Override
	public List<Accomodations> listAccomodations() {
		
		List<Accomodations> listAccomodations = ad.listAccomodations();
		
		return listAccomodations;
	}

}
