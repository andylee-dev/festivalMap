package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.oracle.s202350104.model.AccomodationContent;
import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.service.AccomodationService;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AccomodationController {
	
	private final AccomodationService as;
	private final AreaService ars;
	
	@GetMapping(value = "/accomodation")
	public String accomodation(AccomodationContent accomodation, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "accomodation", "start");
			int totalAccomodation = as.totalAccomodation();
			
			Paging page = new Paging(totalAccomodation, currentPage);
			accomodation.setStart(page.getStart());
			accomodation.setEnd(page.getEnd());
			
			List<AccomodationContent> listAccomodation = as.listAccomodation(accomodation);
			List<Areas> listAreas = ars.listPoint();
			
			model.addAttribute("totalAccomodation", totalAccomodation);
			model.addAttribute("listAccomodation", listAccomodation);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "accomodation", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "accomodation", "end");
		}
					
		return "accomodation/accomodationIndex";
	}
	
	@GetMapping(value = "/accomodation/detail")
	public String accomodationDetail(int contentId, Model model) {
		log.info("AccomodationController detailAccomodation Start...");
		
		AccomodationContent accomodation = as.detailAccomodation(contentId);
		
		model.addAttribute("contentId", contentId);
		model.addAttribute("accomodation", accomodation);
		
		return "accomodation/accomodationDetail";
			
		
	}
	
	
}
