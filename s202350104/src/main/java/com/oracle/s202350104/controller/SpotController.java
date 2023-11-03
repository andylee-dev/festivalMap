package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.BoardService;
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
	private final BoardService boardService;

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
	public String spotDetail(int contentId, String currentPage, Board board, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "spot/detail", "start");
			SpotContent spot = ss.detailSpot(contentId);
			
			model.addAttribute("contentId",contentId);
			model.addAttribute("spot",spot);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "spot/detail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "spot/detail", "end");
		}
		
		/*
		 * review Logic 구간 
		 * by 엄민용
		 * */
		log.info("controller reviewBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 6;
		
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
		
		log.info("controller reviewBoardList End..");	
		
		return "spot/spotDetail";
	}
}
