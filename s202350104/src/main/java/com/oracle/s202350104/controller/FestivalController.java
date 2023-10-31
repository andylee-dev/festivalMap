package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.service.FestivalsService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FestivalController {
	
	private final FestivalsService fs;
	
	@GetMapping(value = "festival")
	public String festival(FestivalsContent festival, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "festival", "start");
			int totalFestivals = fs.totalFestivals();
			log.info("totalFestivals" + totalFestivals);
			
			Paging page = new Paging(totalFestivals, currentPage);
			festival.setStart(page.getStart());
			festival.setEnd(page.getEnd());
			log.info("StartPage" + page.getStartPage());
			
			List<FestivalsContent> listFestivals = fs.listFestivals(festival);
			log.info("FestivalCotroller listFestivals.size => " + listFestivals.size());
			
			model.addAttribute("totalFestivals", totalFestivals);
			model.addAttribute("listFestivals", listFestivals);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "festival", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "festival", "end");
		}
		
		return "festival/festivalList";
	}
	
	@GetMapping(value = "festival/detail")
	public String festivalDetail(int contentId, Model model) {
		FestivalsContent festival = fs.detailFestivals(contentId);
		
		model.addAttribute("contentId", contentId);
		model.addAttribute("festival", festival);
		
		return "festival/festivalDetail";
	}
	
	@RequestMapping(value = "festival/recommend")
	public String festivalRecommendation() {
		return "festival/festivalRecommend";
	}
	
	@RequestMapping(value = "festival/test")
	public String festivalTest() {
		return "festival/festivalTest";
	}
	
	@RequestMapping(value = "festival/calendar")
	public String festivalCalendar() {
		return "festival/festivalCalendar";
	}
}
