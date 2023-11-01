package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.SpotService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class SpotController {
	private final SpotService ss;
	private final AreaService as;

	@RequestMapping(value = "spot")
	public String spot(SpotContent spotContent,String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "spot", "start");
			int totalSpot = ss.totalSpot();
		
			Paging page = new Paging(totalSpot, currentPage);
			spotContent.setStart(page.getStart());
			spotContent.setEnd(page.getEnd());
		
			List<SpotContent> listSpot = ss.listSpot(spotContent);
			List<Areas> listAreas = as.listPoint();
		
			model.addAttribute("totalSpot",totalSpot);
			model.addAttribute("listSpot", listSpot);
			model.addAttribute("listAreas",listAreas);
			model.addAttribute("page",page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "spot", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "spot", "end");
		}
		return "spot/spotList";
	}
	
	@RequestMapping(value = "spot/detail")
	public String spotDetail() {
		return "spot/spotDetail";
	}
}
