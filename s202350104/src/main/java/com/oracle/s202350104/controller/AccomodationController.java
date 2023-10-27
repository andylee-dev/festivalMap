package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Accomodation;
import com.oracle.s202350104.service.AccomodationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AccomodationController {
	
	private final AccomodationService as;
	
	@RequestMapping(value = "/accomodation")
	public String accomodation() {
		return "accomodation/accomodation";

	}
	
	@RequestMapping(value = "/accomodation/detail")
	public String festivalDetail() {
		
		List<Accomodation> listAccomodation = as.listAccomodation();
		
		return "accomodation/accomodationDetail";
	}
	
	
}
