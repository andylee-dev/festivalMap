package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.oracle.s202350104.model.AccomodationContent;
import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.service.AccomodationService;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AccomodationController {
	
	private final AccomodationService as;
	private final AreaService ars;
	private final BoardService boardService;
	private final BannerService bannerService;
	
	@GetMapping(value = "/accomodation")
	public String accomodation(AccomodationContent accomodation, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "accomodation", "start");
			int totalAccomodation = as.totalAccomodation();
			
			Paging page = new Paging(totalAccomodation, currentPage);
			accomodation.setStart(page.getStart());
			accomodation.setEnd(page.getEnd());
			
			List<AccomodationContent> listAccomodation = as.listAccomodation(accomodation);
			List<Areas> listAreas = ars.listAreas();
			
			model.addAttribute("totalAccomodation", totalAccomodation);
			model.addAttribute("listAccomodation", listAccomodation);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);
			
			/*
			 * Banner Logic 구간 
			 * by 엄민용
			 * */
			List<Banner> bannerHeader = bannerService.getHeaderBanner();
			List<Banner> bannerFooter = bannerService.getFooterBanner();			

			model.addAttribute("bannerHeader", bannerHeader);
			model.addAttribute("bannerFooter", bannerFooter);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "accomodation", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "accomodation", "end");
		}
					
		return "accomodation/accomodationIndex";
	}
	
	@GetMapping(value = "/accomodation/detail")
	public String accomodationDetail(int contentId,String currentPage, Board board,  Model model) {
		log.info("AccomodationController detailAccomodation Start...");
		
		AccomodationContent accomodation = as.detailAccomodation(contentId);
		
		model.addAttribute("contentId", contentId);
		model.addAttribute("accomodation", accomodation);
		
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
		
		return "accomodation/accomodationDetail";
			
		
	}
	
	
}
