	package com.oracle.s202350104.controller;
	
	import java.util.List;
	import java.util.UUID;
	
	import javax.servlet.http.HttpServletRequest;
	
	import org.springframework.stereotype.Controller;
	import org.springframework.ui.Model;
	import org.springframework.web.bind.annotation.GetMapping;
	import org.springframework.web.bind.annotation.PostMapping;
	import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
import com.oracle.s202350104.model.History;
import com.oracle.s202350104.model.Point;
	import com.oracle.s202350104.service.FestivalsService;
import com.oracle.s202350104.service.HistoryService;
import com.oracle.s202350104.service.Paging;
	import com.oracle.s202350104.service.PagingList;
	import com.oracle.s202350104.service.RestaurantService;
	import com.oracle.s202350104.service.SpotService;
import com.oracle.s202350104.service.TagsService;
import com.oracle.s202350104.service.user.UserService;
	import com.oracle.s202350104.model.RestaurantsContent;
	import com.oracle.s202350104.model.SpotContent;
import com.oracle.s202350104.model.Tags;

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
		private final TagsService ts;
		private final UserService us;
		private final HistoryService hs;
		
		// festival <나희>
		// 관리자 지역정보 축제 리스트로 이동
		@RequestMapping(value = "festival")
		public String festival(FestivalsContent festival, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			
			try {	
				log.info("[{}]{}:{}", transactionId, "admin festival", "start");

				// 조건에 맞는 festival의 총 개수를 가져옴
				int totalFestivals = fs.totalFestivals(festival);
				
				// 페이징 처리
				PagingList page = new PagingList(totalFestivals, currentPage);
				festival.setStart(page.getStart());
				festival.setEnd(page.getEnd());
				
				// 조건에 맞는 festival의 list를 가져옴
				List<FestivalsContent> listFestivals = fs.listFestivals(festival);
				
				model.addAttribute("totalFestivals", totalFestivals);
				model.addAttribute("listFestivals", listFestivals);
				model.addAttribute("page", page);
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin festival", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin festival", "end");
			}	
			
			return "admin/content/festival";
		}
		
		// 관리자 축제 상세 페이지로 이동
		@RequestMapping(value = "festivalDetail")
		public String festivalDetail(String contentIdStr, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			
			// String으로 넘어온 컨텐츠 아이디를 int형으로 바꿔줌
			int contentId = 0;
			if(contentIdStr == null) {
				contentId = 0;	// 만약 컨텐츠 아이디가 null일 경우 0으로 처리
			} else {
				contentId = Integer.parseInt(contentIdStr);
			}
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin festivalDetail", "start");
				
				// festival 상세 정보를 담을 인스턴스 생성하여 값을 저장
				FestivalsContent festival = fs.detailFestivals(contentId);
				
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("contentId", contentId);
				model.addAttribute("festival", festival);
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin festivalDetail", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin festivalDetail", "end");
			}	 
			
			return "admin/content/festivalDetail";
		}
		
		// 관리자 축제 정보 입력 폼으로 이동
		@RequestMapping(value = "festivalInsertForm")
		public String festivalInsertForm(Model model) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin festivalInsertForm", "start");
			
				// 축제 중분류를 선택할 수 있도록 common code의 list를 만들어서 저장
				List<CommonCodes> listCodes = cs.listCommonCode();
				
				model.addAttribute("listCodes", listCodes);
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin festivalInsertForm", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin festivalInsertForm", "end");
			}
			
			return "admin/content/festivalInsertForm";
		}
		
		// 축제 정보를 입력한 후 DB(content 및 festivals 테이블)에 insert 처리(AJAX 연결)
		@ResponseBody
		@RequestMapping(value = "festival/insert")
		public String festivalInsert(FestivalsContent festival, Model model) {
			UUID transactionId = UUID.randomUUID();
			String str = "";
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin festivalInsert", "start");
				
				// 폼에 입력된 date 정보를 DB에 저장된 형식으로 변환
				// festival.setStart_date(festival.getStart_date().replaceAll("-", ""));
			    // festival.setEnd_date(festival.getEnd_date().replaceAll("-", ""));
				
				// festival을 insert한 결과를 result에 저장
				int result = fs.insertFestival(festival);
				log.info("Controller festivalInsert result => "+result);
				
				// result에 따라 alert 메세지 반환
				if(result > 0) {
					str = "성공적으로 등록되었습니다."; 
				} else { 
					str = "등록에 실패하였습니다."; 
				}
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin festivalInsert", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin festivalInsert", "end");
			}		
			
			// alert 메세지 반환
			return str;
		}
		
		// 관리자 축제 정보 수정 폼으로 이동
		@RequestMapping(value = "festivalUpdateForm")
		public String festivalUpdateForm(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin festivalUpdateForm", "start");
				// 수정할 festival의 상세 정보를 가져와서 festival 인스턴스에 저장
				FestivalsContent festival = fs.detailFestivals(contentId);
				// 소분류를 수정할 수 있도록 common code의 list를 만들어서 저장
				List<CommonCodes> listCodes = cs.listCommonCode();

//				// 시작일 보여주기 위해 형식 변환
//				String startdate = "";
//				if(festival.getStart_date() != null) {
//					String o_startdate = festival.getStart_date();
//					startdate = o_startdate.substring(0,4)+"-"+o_startdate.substring(4,6)+"-"+o_startdate.substring(6,8);
//					festival.setStart_date(startdate);
//					log.info("startdate=>"+startdate);
//				}
//				
//				// 종료일 보여주기 위해 형식 변환
//				String enddate = "";
//				if(festival.getEnd_date() != null) {
//					String o_enddate = festival.getEnd_date();
//					enddate = o_enddate.substring(0,4)+"-"+o_enddate.substring(4,6)+"-"+o_enddate.substring(6,8);
//					festival.setEnd_date(enddate);
//					log.info("enddate=>"+enddate);
//				}
				
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("festival", festival);
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin festivalUpdateForm", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin festivalUpdateForm", "end");
			}	
			
			return "admin/content/festivalUpdateForm";
		}
		
		// 축제 정보를 수정한 후 DB(content 및 festivals 테이블)에 update(AJAX 연결)
		@ResponseBody
		@RequestMapping(value = "festivalUpdate")
		public String festivalUpdate(FestivalsContent festival, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			String str = "";
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin festivalUpdate", "start");
				// update한 결과를 result에 저장
				int result = fs.updateFestival(festival);

				// result 값에 따라 alert 메세지 반환
				if(result > 0) {
					str = "축제 정보 수정에 성공하였습니다.";
				} else {
					str = "축제 정보 수정에 실패하였습니다.";
				}
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin festivalUpdate", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin festivalUpdate", "end");
			}	
			
			// alert로 메시지 반환
			return str;
		}
		
		// festival을 삭제
		@RequestMapping(value = "festivalDelete")
		public String festivalDelete(int contentId, Model model) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin festivalDelete", "start");
				// festival 삭제
				fs.deleteFestivals(contentId);
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin festivalDelete", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin festivalDelete", "end");
			}	
			
			return "forward:festival";
		}
		
		// festival 등록을 승인
		@RequestMapping(value = "festivalApprove")
		public String festivalApprove(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}", transactionId, "admin festivalApprove", "start");
				// approve한 결과를 result에 저장
				int result = fs.approveFestival(contentId);
				
				// result값에 따라 alert에서 표시될 메세지가 달라짐
				if(result > 0) {
					model.addAttribute("msg", "성공적으로 승인 처리되었습니다.");
				} else {
					model.addAttribute("msg", "오류가 발생하여 승인에 실패하였습니다.");
				}
				
				model.addAttribute("contentId", contentId);
				model.addAttribute("currentPage", currentPage);
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin festivalApprove", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin festivalApprove", "end");
			}	
			
			// model은 view단으로 데이터를 가져가는 것이기 때문에 forward로 넘길 때는 return하는 url에 파라미터를 붙여서 넘겨줘야 한다
			return "forward:festivalDetail?contentIdStr="+contentId;
		}
		
		// 등록 반려사유 입력 팝업창 띄우기
				@RequestMapping(value = "rejectionForm")
				public String rejectionForm(int contentId, int bigCode, Model model) {
					UUID transactionId = UUID.randomUUID();
					try {
						log.info("[{}]{}:{}", transactionId, "admin rejectionForm", "start");
						// bigCode에 맞춰 처리할 로직을 적어주세요~!
						if(bigCode == 11) {        // festival
							FestivalsContent festival = fs.detailFestivals(contentId);
							model.addAttribute("festival", festival);
						} else if(bigCode == 12) { // restaurant
							
						} else if(bigCode == 13) { // accomodation
							
						} else if(bigCode == 14) { // spot
							SpotContent spot = ss.detailSpot(contentId);
							model.addAttribute("spot", spot);
						} else if(bigCode == 15) { // experience
							
						}
					} catch (Exception e) {
						log.error("[{}]{}:{}", transactionId, "admin rejectionForm", e.getMessage());
					} finally {
						log.info("[{}]{}:{}", transactionId, "admin rejectionForm", "end");
					}	
					
					if(bigCode == 11) {        // festival
						return "admin/content/rejectionFormFestival";
					} else if(bigCode == 12) { // restaurant
						return "";
					} else if(bigCode == 13) { // accomodation
						return "";
					} else if(bigCode == 14) { // spot
						return "admin/content/rejectionFormSpot";
					} else if(bigCode == 15) { // experience
						return "";
					} else {
						return "";
					}
					
				}
				
				// 등록 반려 사유 history 테이블에 insert
				@RequestMapping(value = "insertHistory")
				public String insertHistory(History history, int contentId, Model model) {
					UUID transactionId = UUID.randomUUID();
					
					try {
						log.info("[{}]{}:{}", transactionId, "admin insertHistory", "start");
						int result = hs.insertHistory(history);
					} catch (Exception e) {
						log.error("[{}]{}:{}", transactionId, "admin insertHistory", e.getMessage());
					} finally {
						log.info("[{}]{}:{}", transactionId, "admin insertHistory", "end");
					}	
					
					int bigCode = history.getBig_code();
					// bigCode에 맞춰서 이동할 페이지를 적어주세요~!
					if(bigCode == 11) {        // festival
						return "forward:festivalDetail?contentIdStr="+contentId;
					} else if(bigCode == 12) { // restaurant
						return "";
					} else if(bigCode == 13) { // accomodation
						return "";
					} else if(bigCode == 14) { // spot
						return "forward:spotDetail?contentIdStr="+contentId;
					} else if(bigCode == 15) { // experience
						return "";
					} else {
						return "";
					}
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
				int big_code = 12;
				
				Paging page = new Paging(totalRestaurant, currentPage);
				restaurant.setStart(page.getStart());
				restaurant.setEnd(page.getEnd());
				
				List<RestaurantsContent> listRestaurant = rs.listRestaurant(restaurant);
				List<Areas> listAreas = ars.listAreas();
				List<RestaurantsContent> listSmallCode = rs.listSmallCode(big_code);
				
				model.addAttribute("totalRestaurant", totalRestaurant);
				model.addAttribute("listRestaurant", listRestaurant);
				model.addAttribute("listAreas", listAreas);
				model.addAttribute("listSmallCode", listSmallCode);
				model.addAttribute("page",page);
				model.addAttribute("path", path);
				model.addAttribute("currentPage", currentPage);
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin restaurant", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin restaurant", "end");
			}
					
			return "admin/content/restaurant";
		}
	
		
		@RequestMapping(value = "adminRestaurantSearch")
		public String adminRestaurantSearch(RestaurantsContent restaurant, String currentPage, Model model, HttpServletRequest request, Integer contentId) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", "Start");
				int totalRestaurant = rs.adminConTotalRestaurant(restaurant);
				log.info("{}", totalRestaurant);
				int path 			= 2;
				log.info("{}", path);
				int small_code      = restaurant.getSmall_code();
				int big_code        = restaurant.getBig_code();
				contentId       = restaurant.getContent_id();
							
				String status 		= request.getParameter("status");
				String theme 		= request.getParameter("theme");
				
				Paging page = new Paging(totalRestaurant, currentPage);
				restaurant.setStart(page.getStart());
				restaurant.setEnd(page.getEnd());
				
				
				List<RestaurantsContent> listSearchRestaurant = rs.adminListSearchRestaurant(restaurant);
								
				model.addAttribute("totalRestaurant", totalRestaurant);
				model.addAttribute("path", path);
				model.addAttribute("status", status);
				model.addAttribute("theme", theme);
				model.addAttribute("page", page);
				model.addAttribute("listRestaurant", listSearchRestaurant);
				model.addAttribute("small_code", small_code);
				model.addAttribute("big_code", big_code);
				model.addAttribute("currentPage", currentPage);
				
				
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", e.getMessage());
			
			} finally {
				log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", "end");
			}	
					
			return "admin/content/restaurant";
		
		}
		
		
		@RequestMapping(value = "restaurantDetail")
		public String restaurantDetail(Integer contentId, Model model, String currentPage) {
			UUID transaction = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transaction, "admin restaurantDetail", "Start");
				log.info("admin restaurantDetail -> ", contentId);
				RestaurantsContent restaurant = rs.detailRestaurant(contentId);
				int big_code = restaurant.getBig_code();
				List<RestaurantsContent> listSmallCode = rs.listSmallCode(big_code);
				
				model.addAttribute("restaurant", restaurant);
				model.addAttribute("listSmallCode", listSmallCode);
				model.addAttribute("currentPage", currentPage);
				
			} catch (Exception e) {
				log.error("[{}]{}:{}", transaction, "admin restaurantDetail Exception", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transaction, "admin restaurantDetail", "End");
			}
						
			return "admin/content/restaurantDetail";
		}
		

		@RequestMapping(value = "restaurantInsertForm")
		public String restaurantInsertForm(Model model) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin restaurantInsertForm", "start");
				List<CommonCodes> listCodes = cs.listCommonCode();
				List<Areas> listAreas = ars.listAreas();
				
				int big_code     	= 12;				
				List<RestaurantsContent> listSmallCode = rs.listSmallCode(big_code);
				
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("listAreas", listAreas);
				model.addAttribute("listSmallCode", listSmallCode);
								
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin restaurantInsertForm Exception", e.getMessage());
			
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin restaurantInsertForm", "end");
			}
			
			return "admin/content/restaurantInsertForm";		
		}		
		
			
		@RequestMapping(value = "restaurantInsert")
		public String restaurantInsert(Model model, RestaurantsContent restaurant) {
			UUID transactionId = UUID.randomUUID();
				
			log.info("[{}]{}:{}", transactionId, "admin restaurantInsert", "start");
			
			int result = rs.insertRestaurant(restaurant);
			
			if(result > 0) return "redirect:/admin/content/restaurant";
			else {
				model.addAttribute("msg", "입력실패 확인해보세요");
				return "forward:restaurantInsertForm";
			}
		}		
		
				
		@RequestMapping(value = "restaurantUpdateForm")
		public String restaurantUpdateForm(int contentId, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin restaurantUpdateForm", "start" );
				RestaurantsContent restaurant = rs.detailRestaurant(contentId);
				List<CommonCodes> listCodes = cs.listCommonCode();
				List<Areas> listAreas = ars.listAreas();
				List<Areas> listSigungu = ars.listSigungu(restaurant.getArea());
				int big_code = restaurant.getBig_code();			
				List<RestaurantsContent> listSmallCode = rs.listSmallCode(big_code);
				
				model.addAttribute("restaurant", restaurant);
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("listAreas", listAreas);
				model.addAttribute("listSigungu", listSigungu);
				model.addAttribute("listSmallCode", listSmallCode);
				model.addAttribute("currentPage", currentPage);
				
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin restaurantUpdateForm Exception", e.getMessage());
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin restaurantUpdateForm", "end");
			}
			return "admin/content/restaurantUpdateForm";
		}
		
		
		@RequestMapping(value = "restaurantUpdate")
		public String restaurantUpdate(RestaurantsContent restaurant, Model model) {
			UUID transactionId = UUID.randomUUID();
			int id = 0;
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin restaurantUpdate", "start" );
				int result = rs.updateRestaurant(restaurant);
				log.info("admin restaurantUpdate updateCount ->" + result);
				id = restaurant.getContent_id();
				
				int big_code = restaurant.getBig_code();
				List<RestaurantsContent> listSmallCode = rs.listSmallCode(big_code);
				
				model.addAttribute("listSmallCode", listSmallCode);
			
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin restaurantUpdate Exception", e.getMessage() );
			
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin restaurantUpdate", "end" );
			} 
			
			return "forward:restaurantDetail?contentId="+id;
			// return "redirect:restaurant"; /admin/content/
		}
		
		
		@RequestMapping(value = "restaurantDelete")
		public String restaurantDelete(int contentId, Model model) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin restaurantDelete", "start");;
				int result = rs.deleteRestaurant(contentId);
			
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin restaurantDelete Exception", e.getMessage());
			
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin restaurantDelete", "end");
			}
			
			return "redirect:restaurant";	
		} 
		
		
		@RequestMapping(value = "restaurantApprove")
		public String restaurantApprove(Integer contentId, String currentPage) {
			UUID transactionId = UUID.randomUUID();
			
			try {
				log.info("[{}]{}:{}", transactionId, "admin restaurantApprove", "Start");
				int result = rs.approveRestaurant(contentId);
				
			} catch (Exception e) {
				log.error("[{}]{}:{}", transactionId, "admin restaurantApprove Exception", e.getMessage());
			
			} finally {
				log.info("[{}]{}:{}", transactionId, "admin restaurantApprove", "End");
			}
			
			return "forward:restaurant";
		}
		
		
		@RequestMapping(value = "spot")
		public String spot(SpotContent spot, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin spot", "start");
				int totalSearchSpot = ss.totalSearchSpot(spot);
			
				PagingList page = new PagingList(totalSearchSpot, currentPage);
				spot.setStart(page.getStart());
				spot.setEnd(page.getEnd());
			
				List<SpotContent> listSpot = ss.listSpot(spot);
				List<CommonCodes> listCommonCodes = cs.listCommonCode();
				
				model.addAttribute("listCommonCodes",listCommonCodes);
				model.addAttribute("totalSearchSpot",totalSearchSpot);
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
				List<CommonCodes> listCodes = cs.listCommonCode();
				List<Areas> listAreas = ars.listAreas();
				List<Areas> listSigungu = ars.listSigungu(spot.getArea());
				
				model.addAttribute("listSigungu",listSigungu);
				model.addAttribute("listCodes", listCodes);
				model.addAttribute("listAreas", listAreas);
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
		public String spotUpdate(SpotContent spotContent,String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "spotUpdate", "start");
				int result = ss.updateSpot(spotContent);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "spotUpdate", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "spotUpdate", "end");
			}
				return "forward:spotDetail?contentIdStr="+spotContent.getId();
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
		public String spotDelete(int contentId,String is_deleted, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin spotDelete", "start");
				SpotContent spot = new SpotContent();
				spot.setContent_id(contentId);
				
				if(is_deleted.equals("0")) {
					spot.setIs_deleted("1");
				} else if(is_deleted.equals("1")) {
					spot.setIs_deleted("0");
					log.info(spot.getIs_deleted());
				}
				log.info(spot.getIs_deleted());
				ss.deletespot(spot);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin spotDelete", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin spotDelete", "end");
			}		
			return "redirect:spot";
		}
		
		@RequestMapping(value = "spotApprove")
		public String spotApprove(int contentId,String status, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin spotApprove", "start");
				SpotContent spot = new SpotContent();
				spot.setContent_id(contentId);
				
				if(status.equals("0")) {
					spot.setStatus("1");
				} else if(status.equals("1")) {
					spot.setStatus("0");
					log.info(spot.getStatus());
				}
				log.info(spot.getStatus());
					
				int result = ss.approveSpot(spot);
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
			return "forward:spotDetail?contentIdStr="+contentId;
		}
		
		@RequestMapping(value = "accomodation")
		public String accomodation(AccomodationContent accomodationContent, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin accomodation", "start");
				int totalaccomodation = as.admintotalAccomodation();

			
				Paging page = new Paging(totalaccomodation, currentPage);

				accomodationContent.setStart(page.getStart());
				accomodationContent.setEnd(page.getEnd());
			
				List<AccomodationContent> listAccomodation = as.listAccomodation(accomodationContent);
				List<AccomodationContent> listSmallCode  = as.listSmallCode(accomodationContent);
				
		        model.addAttribute("listSmallCode", listSmallCode);
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
	
	@RequestMapping(value = "accomodationSearch")
	public String accomodationSearch(AccomodationContent accomodationContent, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin accomodationSearch", "start");
			int totalSearchaccomodation = as.totalSearchAccomodation(accomodationContent);
			
			System.out.println("totalSearchaccomodation"+totalSearchaccomodation);
						
			int path = 1;
			String small_code = request.getParameter("small_code");
			String big_code = request.getParameter("big_code");
			String is_deleted = request.getParameter("is_deleted");
			String keyword = request.getParameter("keyword");
			String status = request.getParameter("status");
			String area = request.getParameter("area");
			String sigungu = request.getParameter("sigungu");
			
			Paging page = new Paging(totalSearchaccomodation, currentPage);
			
			System.out.println("Paging"+page);
			System.out.println("totalSearchaccomodation"+totalSearchaccomodation);
			
			accomodationContent.setStart(page.getStart());
			accomodationContent.setEnd(page.getEnd());
						
			
			List<AccomodationContent> listSmallCode  = as.listSmallCode(accomodationContent);
			List<AccomodationContent> listSearchAccomodation = as.listSearchAccomodation(accomodationContent);
			
			System.out.println("listSearchAccomodation"+listSearchAccomodation.size());
			
			model.addAttribute("totalAccomodation", totalSearchaccomodation);
			model.addAttribute("listAccomodation", listSearchAccomodation);
			model.addAttribute("listSmallCode", listSmallCode);
			model.addAttribute("page", page);
			model.addAttribute("path", path);
			model.addAttribute("small_code", small_code);
			model.addAttribute("big_code", big_code);
			model.addAttribute("is_deleted" ,is_deleted);
			model.addAttribute("keyword", keyword);
			model.addAttribute("status", status);
			model.addAttribute("area" , area);
			model.addAttribute("sigungu", sigungu);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "admin accomodationSearch", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "admin accomodation", "end");
		}
		return "admin/content/accomodation";
					
}
	
	@RequestMapping(value = "accomodationDetail")
	public String accomodationDetail(int contentId, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin accomodationDetail", "start");
			AccomodationContent accomodation = as.detailAccomodation(contentId);
			List<AccomodationContent> listSmallCode  = as.listSmallCode(accomodation);
			List<Areas> listAreas = ars.listAreas();
			List<Areas> listSigungu = ars.listSigungu(accomodation.getArea());
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("accomodation", accomodation);
			model.addAttribute("listSmallCode", listSmallCode);
			model.addAttribute("listAreas" , listAreas);
			model.addAttribute("listSigungu", listSigungu);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin accomodationDetail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin accomodationDetail", "end");
		}			
		return "admin/content/accomodationDetail";
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
	
	@RequestMapping(value = "accomodationInsert")
	public String accomodationInsert(AccomodationContent accomodation, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin accomodationInsert", "start");
			as.insertAccomodation(accomodation);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin accomodationInsert", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin accomodationInsert", "end");
		}		
		return "redirect:/admin/content/accomodation";
	}	
	
	@GetMapping(value="accomodationUpdateForm")
	public String accomodationUpdateForm(int contentId, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin accomodationUpdateForm", "start");
			
			AccomodationContent accomodation = as.detailAccomodation(contentId);
			
			List<CommonCodes> listCodes = cs.listCommonCode();
			List<Areas> listAreas = ars.listAreas();
			List<Areas> listSigungu = ars.listSigungu(accomodation.getArea());
			
			model.addAttribute("listCodes", listCodes);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("contentId", contentId);
			model.addAttribute("listSigungu", listSigungu);
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
		int contentId = accomodation.getContent_id();
		
		log.info("contentId->"+contentId);
		
		try {
			log.info("[{}]{}:{}",transactionId, "admin accomodationDetail", "start");
			int result = as.updateAccomodation(accomodation);
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("contentId", accomodation.getContent_id());
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin accomodationDetail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin accomodationDetail", "end");
		}		
		return "redirect:/admin/content/accomodationDetail?contentId="+contentId;
	}
	
	
	
	@RequestMapping(value = "accomodationDelete")
	public String accomodationDelete(int contentId, Model model) {
		 UUID transactionId = UUID.randomUUID();
		    try {
		        log.info("[{}]{}:{}", transactionId, "admin accomodationDelete", "start");
		        int result = as.accomodationDelete(contentId);
		        log.info("Delete result: " + result);
		    } catch (Exception e) {
		        log.error("[{}]{}:{}", transactionId, "admin accomodationDelete", e.getMessage());
		    } finally {
		        log.info("[{}]{}:{}", transactionId, "admin accomodationDelete", "end");
		    }
		    return "forward:accomodation";
		}
	
	@ResponseBody
	@RequestMapping(value = "accomodationDeleteAjax")
	public String accomodationDeleteAjax(int contentId, Model model) {
		UUID transactionId = UUID.randomUUID();
		String resultStr = null;
		try {
			log.info("[{}]{}:{}",transactionId, "admin accomodationDeleteAjax", "start");
			int result = as.accomodationDelete(contentId);
			resultStr = Integer.toString(result);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin accomodationDeleteAjax", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin accomodationDeleteAjax", "end");
		}		
		return resultStr;
	}
	
	@RequestMapping(value = "accomodationApprove")
	public String accomodationApprove(int contentId, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin accomodationApprove", "start");
			int result = as.approveAccomodation(contentId);
			if(result > 0) {
				model.addAttribute("msg", "성공적으로 승인 처리되었습니다.");
			} else {
				model.addAttribute("msg", "오류가 발생하여 승인에 실패하였습니다.");
			}
			model.addAttribute("contentId", contentId);
			model.addAttribute("currentPage", currentPage);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin accomodationApprove", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin accomodationApprove", "end");
		}		
		return "forward:accomodationDetail?contentIdStr="+contentId;
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
				ExperienceContent experience = es.detailExperience(contentId);
				List<ExperienceContent> listSmallCode  = es.listSmallCode(experience);
				List<Areas> listAreas = ars.listAreas();
				List<Areas> listSigungu = ars.listSigungu(experience.getArea());
				
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("experience", experience);
				model.addAttribute("listSmallCode", listSmallCode);
				model.addAttribute("listAreas" , listAreas);
				model.addAttribute("listSigungu", listSigungu);
				
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin experienceDetail", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin experienceDetail", "end");
			}		
			return "admin/content/experienceDetail";
		}
		
		@RequestMapping(value = "experienceApprove")
		public String experienceApprove(int contentId, String status, String currentPage, Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin experienceApprove", "start");
				ExperienceContent experience = new ExperienceContent();
				experience.setContent_id(contentId);
				
				if (status.equals("0")) {
					experience.setStatus("1");
				} else if(status.equals("1")) {
					experience.setStatus("0");
				}
				log.info(experience.getStatus());
				int result = es.experienceApprove(experience);
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
		
		@RequestMapping(value = "experienceInsertForm")
		public String experienceInsertForm(Model model) {
			UUID transactionId = UUID.randomUUID();
			try {
				log.info("[{}]{}:{}",transactionId, "admin experienceInsertForm", "start");
				List<CommonCodes> listCodes = cs.listCommonCode();
				
				model.addAttribute("listCodes", listCodes);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin experienceInsertForm", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin experienceInsertForm", "end");
			}		
			return "admin/content/experienceInsertForm";
		}
		
		@RequestMapping(value = "experienceInsert")
		public String experienceInsert(ExperienceContent experience, Model model) {
			UUID transactionId = UUID.randomUUID();
			int role = us.getLoggedInUserRole();
			log.info("role->"+role);
			try {
				log.info("[{}]{}:{}",transactionId, "admin experienceInsert", "start");
				int result = es.insertExperience(experience);
				log.info("result"+result);
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId, "admin experienceInsert", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "admin experienceInsert", "end");
			}		
			if (role == 1) {
				return "redirect:experience";
			}else 
				return "redirect:/user/bizPage";
			
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
				String status = request.getParameter("status");
				String area = request.getParameter("area");
				String sigungu = request.getParameter("sigungu");
				
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
				model.addAttribute("status", status);
				model.addAttribute("area" , area);
				model.addAttribute("sigungu", sigungu);
		
			} catch (Exception e) {
				log.error("[{}]{}:{}",transactionId,  "experience", e.getMessage());
			} finally {
				log.info("[{}]{}:{}",transactionId, "experience", "end");
			}
			return "admin/content/experience";
		}
		
	}
