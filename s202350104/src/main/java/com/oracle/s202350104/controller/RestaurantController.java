package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Restaurants;
import com.oracle.s202350104.model.RestaurantsContent;
import com.oracle.s202350104.service.AreaService;
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
	
	@GetMapping(value = "/restaurant")
	public String restaurant(RestaurantsContent restaurant, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "restaurant", "start");
			int totalRestaurant = rs.totalRestaurant();
			
			Paging page = new Paging(totalRestaurant, currentPage);
			restaurant.setStart(page.getStart());
			restaurant.setEnd(page.getEnd());
			
			List<RestaurantsContent> listRestaurant = rs.listRestaurant(restaurant);
			List<Areas> listAreas = as.listPoint();
			
			model.addAttribute("totalRestaurant", totalRestaurant);
			model.addAttribute("listRestaurant", listRestaurant);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);
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
			listAreas = as.listPoint();
					
		} catch (Exception e) {
			log.info("[{}]{}:{}", transactionId, "RestaurantController listAreas Exception", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "RestaurantController listAreas", "End");
		}
		
		return listAreas;
	}
	
	
	
	@GetMapping(value= "/restaurant/detail")
	public String restuarntDetail(int contentId, String currentPage, Board board, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantDetail", "Start");
			RestaurantsContent restaurant = rs.detailRestaurant(contentId);
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("contentId", contentId);
			model.addAttribute("restaurant", restaurant);
		} catch (Exception e) {
			log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantDetail Exception", e.getMessage());
		}
		log.info("[{}]{}:{}", transactionId, "RestaurantController restaurantDetail", "End");
				
		
		
		/*
		 * review Logic 구간 
		 * by 엄민용
		 * */
		log.info("controller reviewBoardList Start!!");
		int bigCode = 2;
		// 분류 code 강제 지정
		int smallCode = 6;
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(countBoard, currentPage);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		board.setContent_id(contentId);
		log.info("controller reviewBoardList before board.getStart : {} ", board.getStart());
		log.info("controller reviewBoardList before board.getEnd : {} ", board.getEnd());
		log.info("controller reviewBoardList before board.getEnd : {} ", board.getContent_id());
		
		List<Board> revicewAllList = boardService.getReviewAllList(board); 
		log.info("controller revicewAllList size : {}", revicewAllList.size());

		log.info("controller reviewBoardList after board.getStart : {} ", board.getStart());
		log.info("controller reviewBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = revicewAllList.get(0).getBig_code();

		log.info("controller reviewBoardList totalBoard : {} ", countBoard);
		log.info("controller reviewBoardList smallCode : {} ", smallCode);
		log.info("controller reviewBoardList page : {} ", page);

		model.addAttribute("reviewBoard", revicewAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("controller reviewBoardList End..");
		
		return "restaurant/restaurantDetail";
	}
	
	
}
