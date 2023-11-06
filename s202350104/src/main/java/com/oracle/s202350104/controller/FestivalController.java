package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.FestivalsService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FestivalController {

	private final FestivalsService fs;
	private final AreaService as;
	private final BoardService boardService;
	private final BannerService bannerService;

	@GetMapping(value = "festival")
	public String festival(FestivalsContent festival, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "festival", "start");
			int totalFestivals = fs.totalFestivals();
			
			Paging page = new Paging(totalFestivals, currentPage);
			festival.setStart(page.getStart());
			festival.setEnd(page.getEnd());
			
			List<FestivalsContent> listFestivals = fs.listFestivals(festival);
			List<Areas> listAreas = as.listPoint();
			List<Banner> bannerMain = bannerService.getFooterBanner();
			
			model.addAttribute("totalFestivals", totalFestivals);
			model.addAttribute("listFestivals", listFestivals);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);
			model.addAttribute("banner", bannerMain);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "festival", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "festival", "end");
		}		
		return "festival/festivalList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getSigungu")
	public List<Areas> getSigungu() {
		UUID transactionId = UUID.randomUUID();
		List<Areas> listAreas = null;
		try {
			log.info("[{}]{}:{}",transactionId, "getSigungu", "start");
			listAreas = as.listPoint();
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "getSigungu", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "getSigungu", "end");
		}
		return listAreas;
	}
	
	@GetMapping(value = "festival/detail")
	public String festivalDetail(int contentId, String currentPage, Board board, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "festival/detail", "start");
			FestivalsContent festival = fs.detailFestivals(contentId);
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("contentId", contentId);
			model.addAttribute("festival", festival);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "festival/detail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "festival/detail", "end");
		}
		
		/*
		 * review Logic 구간 
		 * by 엄민용
		 * */
		log.info("FestivalController review Start!!");
		int bigCode = 2;
		// 분류 code 강제 지정
		int smallCode = 6;
		int userId = 1;
		int countBoard = 0;
		
		try {
			// smallCode를 이용해 countBoard를 설정
			countBoard = boardService.boardCount(smallCode);
			
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
		} catch (Exception e) {
			log.error("FestivalController review error : {}", e.getMessage());
		} finally {
			log.info("FestivalController review end..");
		}
		
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
