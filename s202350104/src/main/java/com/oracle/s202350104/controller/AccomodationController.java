package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.oracle.s202350104.model.Accomodations;
import com.oracle.s202350104.model.AccomodationsContent;
import com.oracle.s202350104.service.AccomodationsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AccomodationController {
	
	private final AccomodationsService as;
	
	@GetMapping(value = "accomodations")
	public String accomodations(Accomodations accomodations, Model model) {
		
		List<Accomodations> listAccomodations = as.listAccomodations();
		
		model.addAttribute("listAccomodations", listAccomodations);
		
		return "accomodations/accomodationsIndex";

	}
	
	@GetMapping(value = "accomodations/detail")
	public String accomodationsDetail(int content_id, Model model) {
		log.info("AccomodationController detailAccomodations Start...");
		
		AccomodationsContent accomodations = as.detailAccomodations(content_id);
		
		model.addAttribute("content_id", content_id);
		model.addAttribute("accomodations", accomodations);
		
		return "accomodations/accomodationsDetail";
			
		
	}
	
	
}
