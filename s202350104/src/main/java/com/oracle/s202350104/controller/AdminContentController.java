package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Experience;
import com.oracle.s202350104.service.ExperienceService;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.service.FestivalsService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.RestaurantService;
import com.oracle.s202350104.service.SpotService;
import com.oracle.s202350104.service.user.UserService;
import com.oracle.s202350104.model.RestaurantsContent;
import com.oracle.s202350104.model.SpotContent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/content")
public class AdminContentController {
	
	private final ExperienceService es;
	private final FestivalsService fs;
	private final SpotService ss;
	private final RestaurantService rs;
	
	@RequestMapping(value = "festival")
	public String festival(FestivalsContent festival, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festival", "start");
			int totalFestivals = fs.totalFestivals();
			
			Paging page = new Paging(totalFestivals, currentPage);
			festival.setStart(page.getStart());
			festival.setEnd(page.getEnd());
			
			List<FestivalsContent> listFestivals = fs.listFestivals(festival);
			
			model.addAttribute("totalFestivals", totalFestivals);
			model.addAttribute("listFestivals", listFestivals);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin festival", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin festival", "end");
		}		
		return "admin/content/festival";
	}

	@RequestMapping(value = "experience")
	public String experience(Model model) {
		List<Experience> listExperience = es.listExperience();
		model.addAttribute("listExperience", listExperience);
		return "admin/content/experience";
	}
	
	@RequestMapping(value = "restaurant")
	public String restaurant(RestaurantsContent restaurant, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "admin restaurant", "start");
			int totalRestaurant = rs.totalRestaurant();
			
			Paging page = new Paging(totalRestaurant, currentPage);
			restaurant.setStart(page.getStart());
			restaurant.setEnd(page.getEnd());
			
			List<RestaurantsContent> listRestaurant = rs.listRestaurant(restaurant);
			
			model.addAttribute("totalRestaurant", totalRestaurant);
			model.addAttribute("listRestaurant", listRestaurant);
			model.addAttribute("page",page);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin restaurant", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "admin restaurant", "end");
		}
				
		return "admin/content/restaurant";
	}

	@RequestMapping(value = "spot")
	public String spot(SpotContent spotContent, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin spot", "start");
			int totalSpot = ss.totalSpot();
		
			Paging page = new Paging(totalSpot, currentPage);
			spotContent.setStart(page.getStart());
			spotContent.setEnd(page.getEnd());
		
			List<SpotContent> listSpot = ss.listSpot(spotContent);
		
			model.addAttribute("totalSpot",totalSpot);
			model.addAttribute("listSpot", listSpot);
			model.addAttribute("page",page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "admin spot", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "admin spot", "end");
		}
		return "admin/content/spot";
	}

	@RequestMapping(value = "accomodation")
	public String accomodation() {
		return "admin/content/accomodation";
	}

}
