package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Accomodations;
import com.oracle.s202350104.service.AccomodationsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AccomodationController {
	
	private final AccomodationsService as;
	
	@RequestMapping(value = "/accomodations")
	public String accomodations(Accomodations accomodations, Model model) {
		
		List<Accomodations> listAccomodations = as.listAccomodations(accomodations);
		
		model.addAttribute("listAccomodations", listAccomodations);
		
		return "accomodations/accomodationsIndex";

	}
	
	@RequestMapping(value = "/accomodations/detail")
	public String accomodationsDetail() {
		
		
		
		return "accomodations/accomodationsDetail";
	}
	
	
}
