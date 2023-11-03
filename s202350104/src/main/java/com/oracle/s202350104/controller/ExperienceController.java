package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Experience;
import com.oracle.s202350104.model.ExperienceContent;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.Report;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.ExperienceService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ExperienceController {

	private final ExperienceService es;
	private final BoardService boardService;
	
	@RequestMapping(value = "experience")
	public String experience(ExperienceContent experience,String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "experience", "start");
			int totalExperience = es.totalExperience();
			
			Paging page = new Paging(totalExperience, currentPage);
			experience.setStart(page.getStart());
			experience.setEnd(page.getEnd());
			
			List<ExperienceContent> listExperience = es.listExperience(experience);
			
			model.addAttribute("totalExperience", totalExperience);
			model.addAttribute("listExperience", listExperience);
			model.addAttribute("page", page);

		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "experience", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "experience", "end");
		}
		return "experience/experienceList";
	}
	
	@RequestMapping(value = "experience/detail")
	public String experienceDetail(int contentId, String currentPage, Board board, Model model) {
		ExperienceContent experience = es.detailExperience(contentId);
		model.addAttribute("experience", experience);
		
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
		
		return "experience/experienceDetail";
	}
	
	@RequestMapping(value = "experience/writeForm")
	public String writeFormExperience(Model model) {
		
		return "experience/writeFormExperience";
	}
	
}
