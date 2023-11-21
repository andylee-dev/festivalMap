package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.model.Restaurants;
import com.oracle.s202350104.model.RestaurantsContent;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.RestaurantService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
public class RestaurantController {
	
	private final RestaurantService rs;
	private final AreaService as;
	private final BoardService boardService;
	private final BannerService bannerService;
	
	/* 전체적으로 각 Method들이 무슨 기능을 하고 있는지 간략하게 주석을 남겨주시면 다른 분들도 이해하기 좋을 것  같아요.
	 * by.엄민용
	 */ 
	
	@GetMapping(value = "/restaurant")
	public String restaurant(RestaurantsContent restaurant, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "restaurant", "start");
			int totalRestaurant = rs.totalRestaurant();
			int path = 0;
			int big_code = 12;
			
			Paging page = new Paging(totalRestaurant, currentPage);
			restaurant.setStart(page.getStart());
			restaurant.setEnd(page.getEnd());
			
			List<RestaurantsContent> listRestaurant = rs.listRestaurant(restaurant);
			List<RestaurantsContent> listSmallCode = rs.listSmallCode(big_code);
			List<Areas> listAreas = as.listAreas();
			
			
			model.addAttribute("totalRestaurant", totalRestaurant);
			model.addAttribute("path", path);
			model.addAttribute("listRestaurant", listRestaurant);
			model.addAttribute("listSmallCode", listSmallCode);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);
			model.addAttribute("currentPage", currentPage);
			
			/*
			 * Banner Logic 구간 
			 * by 엄민용
			 * */
			List<Banner> bannerHeader = bannerService.getHeaderBanner();
			List<Banner> bannerFooter = bannerService.getFooterBanner();
			
			model.addAttribute("bannerHeader", bannerHeader);
			model.addAttribute("bannerFooter", bannerFooter);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "restaurant", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "restaurant", "end");
		}
					
		return "restaurant/restaurantList";
	}
	
	@ResponseBody
	@RequestMapping(value = "restaurant/getSigungu")
	public List<Areas> getSigungu() {
		UUID transactionId = UUID.randomUUID();
		
		List<Areas> listAreas = null;
		try {
			log.info("[{}]{}:{}", transactionId, "RestaurantController listAreas", "Start");
			listAreas = as.listAreas();
					
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "RestaurantController listAreas Exception", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "RestaurantController listAreas", "End");
		}
		
		return listAreas;
	}	
	
	
	@GetMapping(value= "/restaurant/detail")
	public String restuarntDetail(int contentId, String currentPage, Board board, Model model) {
		
		UUID transactionId = UUID.randomUUID();
		 
		RestaurantsContent restaurant = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantDetail", "Start");
			
			// 상세정보 Logic 구간
			restaurant = rs.detailRestaurant(contentId);
			
			model.addAttribute("restaurant", restaurant);
			
			/*
			 * review page handling용
			 * by 엄민용 
			 * */
			log.info("restuarntDetail contentId : {} ", contentId);
			log.info("restuarntDetail currentPage : {} ", currentPage);
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("contentId", contentId);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "RestaurantController restaurantDetail Exception", e.getMessage());
		}finally {
			log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantDetail", "End");
		}
		
		/*
		 * review Logic 구간 
		 * by 엄민용
		 * */
		log.info("RestaurantController reviewBoardList Start!!");
		
		int bigCode = 2;
		// 분류 code 강제 지정
		int smallCode = 6;
		int userId = 1;
		int countBoard = 0;
		
		// review별 count용
		board.setCommBigCode(restaurant.getBig_code());
		board.setCommSmallCode(restaurant.getSmall_code());		
		
		
		try {
			// smallCode를 이용해 countBoard를 설정
			countBoard = boardService.boardCount2(board);
			
			// Paging 작업
			// Parameter board page 추가
			Paging page = new Paging(countBoard, currentPage);
			
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());
			board.setContent_id(contentId);
			
			List<Board> reviewAllList = boardService.getReviewAllList(board); 
			
			log.info("RestaurantController reviewBoardList before board.getStart : {} ", board.getStart());
			log.info("RestaurantController reviewBoardList before board.getEnd : {} ", board.getEnd());
			log.info("RestaurantController reviewBoardList before board.getEnd : {} ", board.getContent_id());
			log.info("RestaurantController revicewAllList size : {}", reviewAllList.size());
			log.info("RestaurantController reviewBoardList after board.getStart : {} ", board.getStart());
			log.info("RestaurantController reviewBoardList after board.getEnd : {} ", board.getEnd());
			
			if(reviewAllList.size() != 0) {
				bigCode = reviewAllList.get(0).getBig_code();
			} else {
				log.error("RestaurantController review 값이 없습니다.");
			}
			
			log.info("RestaurantController reviewBoardList totalBoard : {} ", countBoard);
			log.info("RestaurantController reviewBoardList smallCode : {} ", smallCode);
			log.info("RestaurantController reviewBoardList page : {} ", page);

			model.addAttribute("reviewBoard", reviewAllList);
			model.addAttribute("page", page);
			model.addAttribute("bigCode", bigCode);
			model.addAttribute("smallCode", smallCode);
			model.addAttribute("userId", userId);
			
		} catch (Exception e) {
			log.error("RestaurantController reviewBoard error : {}", e.getMessage());
		} finally {
			log.info("RestaurantController reviewBoard end..");
		}
		
		return "restaurant/restaurantDetail";
	}
	
	
	@RequestMapping(value = "restaurantSearch")
	public String restaurantSearch(RestaurantsContent restaurant, String currentPage, Model model, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", "Start");
			int totalRestaurant = rs.conTotalRestaurant(restaurant);
			int path 			= 1;
			String area 		= request.getParameter("area");
			String sigungu 		= request.getParameter("sigungu");
			String small_code   = request.getParameter("small_code");
			
			Paging page = new Paging(totalRestaurant, currentPage);
			restaurant.setStart(page.getStart());
			restaurant.setEnd(page.getEnd());
			
			List<RestaurantsContent> listSearchRestaurant = rs.listSearchRestaurant(restaurant);
			// List<RestaurantsContent> listRestaurant 	  = rs.listRestaurant();
			
			model.addAttribute("totalRestaurant", totalRestaurant);
			model.addAttribute("path", path);
			model.addAttribute("area", area);
			model.addAttribute("sigungu", path);
			model.addAttribute("small_code", small_code);
			model.addAttribute("page", page);
			model.addAttribute("listRestaurant", listSearchRestaurant);
			// model.addAttribute("listRestaurant", listRestaurant);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantSearch", "end");
		}	
				
		return "restaurant/restaurantList";
	
	}	
	
	
}	
	
