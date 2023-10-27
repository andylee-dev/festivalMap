package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Accomodations;
import com.oracle.s202350104.service.AccomodationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AccomodationController {
	
	private final AccomodationService as;
	
	@RequestMapping(value = "/accomodations")
	public String accomodations() {
		return "accomodations/accomodationsIndex";

	}
	
	@RequestMapping(value = "/accomodations/detail")
	public String festivalDetail() {
		
		List<Accomodations> listAccomodations = as.listAccomodations();
		
		return "accomodations/accomodationsDetail";
	}
	
	
}
