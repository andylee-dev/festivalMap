package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.oracle.s202350104.model.AccomodationsContent;
import com.oracle.s202350104.service.AccomodationsService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AccomodationController {
	
	private final AccomodationsService as;
	
	@GetMapping(value = "/accomodations")
	public String accomodations(AccomodationsContent accomodations, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "accomodations", "start");
			int totalAccomodations = as.totalAccomodations();
			
			Paging page = new Paging(totalAccomodations, currentPage);
			accomodations.setStart(page.getStart());
			accomodations.setEnd(page.getEnd());
			
			List<AccomodationsContent> listAccomodations = as.listAccomodations(accomodations);
			
			model.addAttribute("totalAccomodations", totalAccomodations);
			model.addAttribute("listAccomodations", listAccomodations);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "accomodations", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "accomodations", "end");
		}
					
		return "accomodations/accomodationsIndex";
	}
	
	@GetMapping(value = "/accomodations/detail")
	public String accomodationsDetail(int content_id, Model model) {
		log.info("AccomodationController detailAccomodations Start...");
		
		AccomodationsContent accomodations = as.detailAccomodations(content_id);
		
		model.addAttribute("content_id", content_id);
		model.addAttribute("accomodations", accomodations);
		
		return "accomodations/accomodationsDetail";
			
		
	}
	
	
}
