package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.AccomodationContent;
import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.model.ExperienceContent;
import com.oracle.s202350104.service.AccomodationService;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.CommonCodeService;
import com.oracle.s202350104.service.ExperienceService;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.service.FestivalsService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PagingList;
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
	private final AccomodationService as;
	private final AreaService ars;
	private final CommonCodeService cs;
	
	@RequestMapping(value = "festival")
	public String festival(FestivalsContent festival, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festival", "start");
			int totalFestivals = fs.totalFestivals();
			
			PagingList page = new PagingList(totalFestivals, currentPage);
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
	
	@RequestMapping(value = "festivalDetail")
	public String festivalDetail(int contentId, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
			FestivalsContent festival = fs.detailFestivals(contentId);
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("contentId", contentId);
			model.addAttribute("festival", festival);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin festivalDetail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "end");
		}		
		return "admin/content/festivalDetail";
	}
	
	@RequestMapping(value = "festivalInsertForm")
	public String festivalInsertForm(Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festivalInsertForm", "start");
			List<CommonCodes> listCodes = cs.listCommonCode();
			List<Areas> listAreas = ars.listPoint();
			model.addAttribute("listCodes", listCodes);
			model.addAttribute("listAreas", listAreas);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin festivalInsertForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin festivalInsertForm", "end");
		}		
		return "admin/content/festivalInsertForm";
	}
	
	@RequestMapping(value = "festival/insert")
	public String festivalInsert(FestivalsContent festival, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festivalInsert", "start");
			festival.setStart_date(festival.getStart_date().replaceAll("-", ""));
			festival.setEnd_date(festival.getEnd_date().replaceAll("-", ""));
			fs.insertFestival(festival);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin festivalInsert", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin festivalInsert", "end");
		}		
		return "redirect:../festival";
	}
	
	@RequestMapping(value = "festivalUpdateForm")
	public String festivalUpdateForm(int contentId, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
			FestivalsContent festival = fs.detailFestivals(contentId);
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("contentId", contentId);
			model.addAttribute("festival", festival);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin festivalDetail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "end");
		}		
		return "admin/content/festivalUpdateForm";
	}
	
	@RequestMapping(value = "festivalUpdate")
	public String festivalUpdate(FestivalsContent festival, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
			// int result = fs.updateFestival(festival);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin festivalDetail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "end");
		}		
		return "redirect:festivalDetail";
	}
	
	@RequestMapping(value = "festivalDelete")
	public String festivalDelete(int contentId, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
			fs.deleteFestivals(contentId);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin festivalDetail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "end");
		}		
		return "forward:festival";
	}
	
	@ResponseBody
	@RequestMapping(value = "festivalDeleteAjax")
	public String festivalDeleteAjax(int contentId, Model model) {
		int result = fs.deleteFestivals(contentId);
		String resultStr = Integer.toString(result);
		return resultStr;
	}
	
	@RequestMapping(value = "festivalApprove")
	public String festivalApprove(int contentId, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
			int result = fs.approveFestival(contentId);
			model.addAttribute("contentId", contentId);
			model.addAttribute("currentPage", currentPage);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin festivalDetail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "end");
		}		
		return "forward:festivalDetail";
	}

	@RequestMapping(value = "experience")
	public String experience(ExperienceContent experience,String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "experience", "start");
			int totalExperience = es.totalExperience();
			
			int path = 0;
			
			Paging page = new Paging(totalExperience, currentPage);
			experience.setStart(page.getStart());
			experience.setEnd(page.getEnd());
			
			List<ExperienceContent> listExperience = es.listExperience(experience);
			List<ExperienceContent> listSmallCode  = es.listSmallCode(experience);
			model.addAttribute("listSmallCode", listSmallCode);
			model.addAttribute("totalExperience", totalExperience);
			model.addAttribute("listExperience", listExperience);
			model.addAttribute("page", page);
			model.addAttribute("path", path);

		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "experience", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "experience", "end");
		}
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
			List<Areas> listAreas = ars.listPoint();
			
			model.addAttribute("totalRestaurant", totalRestaurant);
			model.addAttribute("listRestaurant", listRestaurant);
			model.addAttribute("listAreas", listAreas);
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
		
			PagingList page = new PagingList(totalSpot, currentPage);
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
		return "admin/content/spotList";
	}

	@RequestMapping(value = "accomodation")
		public String accomodation(AccomodationContent accomodationContent, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin accomodation", "start");
				int totalaccomodation = as.totalAccomodation();
			
				Paging page = new Paging(totalaccomodation, currentPage);
				accomodationContent.setStart(page.getStart());
				accomodationContent.setEnd(page.getEnd());
			
				List<AccomodationContent> listAccomodation = as.listAccomodation(accomodationContent);
			
				model.addAttribute("totalAccomodation",totalaccomodation);
				model.addAttribute("listAccomodation", listAccomodation);
				model.addAttribute("page",page);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId,  "admin accomodation", e.getMessage());
			}finally {
				log.info("[{}]{}:{}",transactionId, "admin accomodation", "end");
			}
			return "admin/content/accomodation";
			
	}
	
	@RequestMapping(value = "accomodationDelete")
	public String accomodationDelete(int contentId, Model model) {
		int accomodationDelete = as.accomodationDelete(contentId);
		
		return "redirect:accomodation";
		
	}
	
	@RequestMapping(value = "experienceDelete")
	public String experienceDelete(int contentId, Model model) {
		int experienceDelete = es.experienceDelete(contentId);
		
		return "redirect:experience";
		
	}
	
	@GetMapping(value = "experience1")
	public String listSearch(ExperienceContent experience,String currentPage, Model model, HttpServletRequest request) {
//	public String listSearch(String big_code,String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "experience", "start");
			int totalSearchExperience = es.totalSearchExperience(experience);
			
			int path = 1;
			String small_code = request.getParameter("small_code");
			String big_code = request.getParameter("big_code");
			String is_deleted = request.getParameter("is_deleted");
			String keyword = request.getParameter("keyword");
			
			Paging page = new Paging(totalSearchExperience, currentPage);
			experience.setStart(page.getStart());
			experience.setEnd(page.getEnd());
			
			List<ExperienceContent> listSmallCode  = es.listSmallCode(experience);
			List<ExperienceContent> listSearchExperience = es.listSearchExperience(experience);
			
			model.addAttribute("totalExperience", totalSearchExperience);
			model.addAttribute("listExperience", listSearchExperience);
			model.addAttribute("listSmallCode", listSmallCode);
			model.addAttribute("page", page);
			model.addAttribute("path", path);
			model.addAttribute("small_code", small_code);
			model.addAttribute("big_code", big_code);
			model.addAttribute("is_deleted" ,is_deleted);
			model.addAttribute("keyword", keyword);
	
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "experience", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "experience", "end");
		}
		return "admin/content/experience";
	}
	
}
