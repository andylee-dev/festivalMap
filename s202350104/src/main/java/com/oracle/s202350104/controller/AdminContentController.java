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
	
	import com.oracle.s202350104.model.Accomodation;
	import com.oracle.s202350104.model.AccomodationContent;
	import com.oracle.s202350104.model.Areas;
	import com.oracle.s202350104.model.CommonCodes;
	import com.oracle.s202350104.model.ExperienceContent;
	import com.oracle.s202350104.service.AccomodationService;
	import com.oracle.s202350104.service.AreaService;
	import com.oracle.s202350104.service.CommonCodeService;
	import com.oracle.s202350104.service.ExperienceService;
	import com.oracle.s202350104.model.FestivalsContent;
	import com.oracle.s202350104.model.Point;
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
				int totalFestivals = fs.totalFestivalsAdmin();
				
				PagingList page = new PagingList(totalFestivals, currentPage);
				festival.setStart(page.getStart());
				festival.setEnd(page.getEnd());
				
				List<FestivalsContent> listFestivals = fs.listFestivalsAdmin(festival);
				
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
		public String festivalDetail(String contentIdStr, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			int contentId = 0;
			if(contentIdStr == null) {
				contentId = 0;
			} else {
				contentId = Integer.parseInt(contentIdStr);
			}
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
				List<Areas> listAreas = ars.listAreas();
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
				int result = fs.insertFestival(festival);
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
				log.info("[{}]{}:{}",transactionId, "admin festivalUpdateForm", "start");
				FestivalsContent festival = fs.detailFestivals(contentId);
				List<CommonCodes> listCodes = cs.listCommonCode();
				List<Areas> listAreas = ars.listAreas();
				List<Areas> listSigungu = ars.listSigungu(festival.getArea());
				
				/*
				 * String startdate = festival.getStart_date();
				 * festival.setStart_date(startdate.substring(0,1)+"-"+startdate.substring(2,3)+
				 * "-"+startdate.substring(4,5)); String enddate = festival.getEnd_date();
				 * festival.setEnd_date(enddate.substring(0,1)+"-"+enddate.substring(2,3)+"-"+
				 * enddate.substring(4,5));
				 */
				
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("listAreas", listAreas);
				model.addAttribute("listSigungu", listSigungu);
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("festival", festival);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin festivalUpdateForm", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin festivalUpdateForm", "end");
			}		
			return "admin/content/festivalUpdateForm";
		}
		
		@RequestMapping(value = "festivalUpdate")
		public String festivalUpdate(FestivalsContent festival, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			int id = 0;
			try {
				log.info("[{}]{}:{}",transactionId, "admin festivalUpdate", "start");
				int result = fs.updateFestival(festival);
				id = festival.getContent_id();
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin festivalUpdate", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin festivalUpdate", "end");
			}		
			return "forward:/admin/content/festivalDetail?contentIdStr="+id;
			// model은 view로 데이터를 가져가는 것이기 때문에 forward로 넘길 때는 return url에 파라미터를 붙여서 넘겨줘야 한다
		}
		
		@RequestMapping(value = "festivalDelete")
		public String festivalDelete(int contentId, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin festivalDelete", "start");
				fs.deleteFestivals(contentId);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin festivalDelete", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin festivalDelete", "end");
			}		
			return "forward:festival";
		}
		
		@ResponseBody
		@RequestMapping(value = "festivalDeleteAjax")
		public String festivalDeleteAjax(int contentId, Model model) {
			UUID transactionId = UUID.randomUUID();
			String resultStr = null;
			try {
				log.info("[{}]{}:{}",transactionId, "admin festivalDeleteAjax", "start");
				int result = fs.deleteFestivals(contentId);
				resultStr = Integer.toString(result);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin festivalDeleteAjax", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin festivalDeleteAjax", "end");
			}		
			return resultStr;
		}
		
		@RequestMapping(value = "festivalApprove")
		public String festivalApprove(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin festivalApprove", "start");
				int result = fs.approveFestival(contentId);
				if(result > 0) {
					model.addAttribute("msg", "성공적으로 승인 처리되었습니다.");
				} else {
					model.addAttribute("msg", "오류가 발생하여 승인에 실패하였습니다.");
				}
				model.addAttribute("contentId", contentId);
				model.addAttribute("currentPage", currentPage);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin festivalApprove", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin festivalApprove", "end");
			}		
			return "forward:festivalDetail?contentIdStr="+contentId;
		}
	
		@RequestMapping(value = "experience")
		public String experience(ExperienceContent experience,String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "experience", "start");
				int totalExperience = es.totalSearchExperience(experience);
				
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
				int path = 0;
				
				Paging page = new Paging(totalRestaurant, currentPage);
				restaurant.setStart(page.getStart());
				restaurant.setEnd(page.getEnd());
				
				List<RestaurantsContent> listRestaurant = rs.listRestaurant(restaurant);
				List<Areas> listAreas = ars.listAreas();
				
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
	
		
		@RequestMapping(value = "adminRestaurantSearch")
		public String adminRestaurantSearch(RestaurantsContent restaurant, String currentPage, Model model, HttpServletRequest request) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", "Start");
				int totalRestaurant = rs.adminConTotalRestaurant(restaurant);
				int path 			= 2;
				String status 		= request.getParameter("status");
				String theme 		= request.getParameter("theme");
				
				Paging page = new Paging(totalRestaurant, currentPage);
				restaurant.setStart(page.getStart());
				restaurant.setEnd(page.getEnd());
				
				List<RestaurantsContent> listSearchRestaurant = rs.adminListSearchRestaurant(restaurant);
				// List<RestaurantsContent> listRestaurant 	  = rs.listRestaurant();
				
				model.addAttribute("totalRestaurant", totalRestaurant);
				model.addAttribute("path", path);
				model.addAttribute("status", status);
				model.addAttribute("theme", theme);
				model.addAttribute("page", page);
				model.addAttribute("listRestaurant", listSearchRestaurant);
				// model.addAttribute("listRestaurant", listRestaurant);
				
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", e.getMessage());
			} finally {
				log.error("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", "end");
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
		
		@RequestMapping(value = "spotDetail")
		public String spotDetail(String contentIdStr, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			int contentId = 0;
			if(contentIdStr == null) contentId = 0;
			else {
				contentId = Integer.parseInt(contentIdStr);
			}
			try {
				log.info("[{}]{}:{}",transactionId, "admin spotDetail", "start");
				SpotContent spot = ss.detailSpot(contentId);
				
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("contentId", contentId);
				model.addAttribute("spot", spot);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin spotDetail", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin spotDetail", "end");
			}		
			return "admin/content/spotDetail";
		}
		
		@RequestMapping(value = "spotUpdate")
		public String spotUpdate(SpotContent spot,String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "spotUpdate", "start");
				int result = ss.updateSpot(spot);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "spotUpdate", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "spotUpdate", "end");
			}
				return "forward:spotDetail?contentIdStr="+spot.getContent_id();
		}
		
		@RequestMapping(value = "spotUpdateForm")
		public String spotUpdateForm(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "spotUpdateForm", "start");
				SpotContent spot = ss.detailSpot(contentId);
				List<CommonCodes> listCodes = cs.listCommonCode();
				List<Areas> listAreas = ars.listAreas();
				List<Areas> listSigungu = ars.listSigungu(spot.getArea());
				
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("listAreas", listAreas);
				model.addAttribute("listSigungu",listSigungu);
				model.addAttribute("currentPage",currentPage);
				model.addAttribute("spot",spot);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "spotUpdateForm", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "spotUpdateForm", "end");	
			}
			return"admin/content/spotUpdateForm";
			}
		
		@RequestMapping(value = "spotInsertForm")
		public String spotInsertForm(Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "spotInsert", "start");
				
				List<CommonCodes> listCodes = cs.listCommonCode();
				List<Areas> listAreas = ars.listAreas();
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("listAreas", listAreas);
				
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId,  "spotInsert", e.getMessage());
			}finally {
				log.info("[{}]{}:{}",transactionId, "spotInsert", "end");
			}
			return "admin/content/spotInsertForm";
		}
		
		@RequestMapping(value = "spotInsertResult")
		public String spotInsertResult(SpotContent spotContent, Model model) {
			UUID transactionId = UUID.randomUUID();
			int result = 0;
			try {
				log.info("[{}]{}:{}",transactionId, "spotInsert", "start");
				result = ss.insertSpot(spotContent);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId,  "spotInsert", e.getMessage());
			}finally {
				log.info("[{}]{}:{}",transactionId, "spotInsert", "end");
			}
			if(result > 0) {
				return "redirect:spot";
			}else {
				model.addAttribute("msg","등록에 실패하였습니다.");
			}
			return "forward:spotInsertForm";
		}
		
		@RequestMapping(value = "spotDelete")
		public String spotDelete(int contentId, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin spotDelete", "start");
				fs.deleteFestivals(contentId);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin spotDelete", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin spotDelete", "end");
			}		
			return "forward:spot";
		}
		
		@ResponseBody
		@RequestMapping(value = "spotDeleteAjax")
		public String spotDeleteAjax(int contentId, Model model) {
			int result = ss.deletespot(contentId);
			String resultStr = Integer.toString(result);
			return resultStr;
		}
		
		@RequestMapping(value = "spotApprove")
		public String spotApprove(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin spotApprove", "start");
				int result = ss.approveSpot(contentId);
				if(result > 0) {
					model.addAttribute("msg", "성공적으로 승인 처리되었습니다.");
				} else {
					model.addAttribute("msg", "오류가 발생하여 승인에 실패하였습니다.");
				}
				model.addAttribute("contentId", contentId);
				model.addAttribute("currentPage", currentPage);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin spotApprove", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin spotApprove", "end");
			}		
			return "forward:spotDetail";
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
		@RequestMapping(value = "accomodationInsertForm")
		public String accomodationInsertForm(Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin accomodationInsertForm", "start");
				List<CommonCodes> listCodes = cs.listCommonCode();
				List<Areas> listAreas = ars.listAreas();
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("listAreas", listAreas);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin accomodationInsertForm", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin accomodationInsertForm", "end");
			}		
			return "admin/content/accomodationInsertForm";
		}
		
		@RequestMapping(value = "accomodation/insert")
		public String accomodationInsert(AccomodationContent accomodation, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin festivalInsert", "start");
				as.insertAccomodation(accomodation);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin accomodationInsert", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin accomodationInsert", "end");
			}		
			return "redirect:../accomodation";
		}
		
		@GetMapping(value="accomodationUpdateForm")
		public String accomodationUpdateForm(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin accomodationUpdateForm", "start");
				
				AccomodationContent accomodation = as.detailAccomodation(contentId);
				
				List<CommonCodes> listCodes = cs.listCommonCode();
				List<Areas> listAreas = ars.listAreas();
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("listAreas", listAreas);
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("contentId", contentId);
				model.addAttribute("accomodation", accomodation);
				
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin accomodationUpdateForm", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin accomodationUpdateForm", "end");
			}		
			return "admin/content/accomodationUpdateForm";
		}
		
		@RequestMapping(value = "accomodation/update")
		public String accomodationUpdate(AccomodationContent accomodation, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
				int result = as.updateAccomodation(accomodation);
				
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("contentId", accomodation.getContent_id());
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin accomodationDetail", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin accomodationDetail", "end");
			}		
			return "forward:../accomodationDetail";
		}
		
		
		
		@RequestMapping(value = "accomodationDelete")
		public String accomodationDelete(int contentId, Model model) {
			int accomodationDelete = as.accomodationDelete(contentId);
			
			return "redirect:accomodation";
			
		}
		
		@RequestMapping(value = "experienceUpdateForm")
		public String experienceUpdateForm(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
				ExperienceContent experience = es.detailExperience(contentId);
				List<Areas> listAreas = ars.listAreas();
				List<Areas> listSigungu = ars.listSigungu(experience.getArea());
				List<ExperienceContent> listSmallCode  = es.listSmallCode(experience);
				
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("contentId", contentId);
				model.addAttribute("experience", experience);
				model.addAttribute("listAreas", listAreas);
				model.addAttribute("listSigungu", listSigungu);
				model.addAttribute("listSmallCode", listSmallCode);
				
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin detailExperience", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin detailExperience", "end");
			}		
			return "admin/content/experienceUpdateForm";
		}
		
		@RequestMapping(value = "experienceUpdate")
		public String experienceUpdate(ExperienceContent experienceContent, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			int contentId = experienceContent.getId();
			log.info("contentId->"+contentId);
			try {
				log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
				int result = es.experienceUpdate(experienceContent);
				model.addAttribute("contentId", experienceContent.getContent_id());
				model.addAttribute("currentPage" , currentPage);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin detailExperience", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin detailExperience", "end");
			}		
			return "forward:/admin/content/experienceDetail?contentId="+contentId;
		}
		
		@ResponseBody
		@RequestMapping(value = "experienceDeleteAjax")
		public String experienceDeleteAjax(int contentId, Model model) {
			UUID transactionId = UUID.randomUUID();
			String resultStr = null;
			try {
				log.info("[{}]{}:{}",transactionId, "admin experienceDeleteAjax", "start");
				int result = es.experienceDelete(contentId);
				resultStr = Integer.toString(result);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin experienceDeleteAjax", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin experienceDeleteAjax", "end");
			}		
			return resultStr;
			
		}
		
		@ResponseBody
		@RequestMapping(value = "experienceRestoreAjax")
		public String experienceRestoreAjax(int contentId, Model model) {
			int result = es.experienceRestore(contentId);
			String resultStr = Integer.toString(result);
			return resultStr;	
		}
		
		@RequestMapping(value = "experienceDelete")
		public String experienceDelete(int contentId, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin experienceDelete", "start");
				es.experienceDelete(contentId);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin experienceDelete", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin experienceDelete", "end");
			}		
			return "redirect:experience";
		}
		
		@RequestMapping(value = "experienceDetail")
		public String experienceDetail(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin experienceDetail", "start");
				ExperienceContent detailExperience = es.detailExperience(contentId);
				
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("experience", detailExperience);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin experienceDetail", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin experienceDetail", "end");
			}		
			return "admin/content/experienceDetail";
		}
		
		@RequestMapping(value = "experienceApprove")
		public String experienceApprove(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin experienceApprove", "start");
				int result = es.experienceApprove(contentId);
				if(result > 0) {
					model.addAttribute("msg", "성공적으로 승인 처리되었습니다.");
				} else {
					model.addAttribute("msg", "오류가 발생하여 승인에 실패하였습니다.");
				}
				model.addAttribute("contentId", contentId);
				model.addAttribute("currentPage", currentPage);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin experienceApprove", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin experienceApprove", "end");
			}		
			return "forward:experienceDetail";
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
