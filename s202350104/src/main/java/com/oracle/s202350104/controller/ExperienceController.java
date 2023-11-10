package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.ExperienceContent;
import com.oracle.s202350104.model.Report;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.BannerService;
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
	private final AreaService as;
	private final BoardService boardService;
	private final BannerService bannerService;
	
	@RequestMapping(value = "experience")
	public String experience(ExperienceContent experience,String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "experience", "start");
			
			int path = 0;
			
			int totalExperience = es.mainTotalExperience();
			
			Paging page = new Paging(totalExperience, currentPage);
			experience.setStart(page.getStart());
			experience.setEnd(page.getEnd());
			
			List<ExperienceContent> listExperience = es.listExperience(experience);
			List<ExperienceContent> listSmallCode  = es.listSmallCode(experience);
			List<Areas> listAreas = as.listAreas();
			
			
			model.addAttribute("totalExperience", totalExperience);
			model.addAttribute("listExperience", listExperience);
			model.addAttribute("listSmallCode" , listSmallCode);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);
			model.addAttribute("path", path);
			
			/*
			 * Banner Logic 구간 
			 * by 엄민용
			 * */
			List<Banner> bannerHeader = bannerService.getHeaderBanner();
			List<Banner> bannerFooter = bannerService.getFooterBanner();			

			model.addAttribute("bannerHeader", bannerHeader);			
			model.addAttribute("bannerFooter", bannerFooter);			

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
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("contentId", contentId);
		model.addAttribute("experience", experience);
		
		/*
		 * review Logic 구간 
		 * by 엄민용
		 * */
		log.info("ExperienceController review Start!!");
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
			log.info("ExperienceController reviewBoardList before board.getStart : {} ", board.getStart());
			log.info("ExperienceController reviewBoardList before board.getEnd : {} ", board.getEnd());
			log.info("ExperienceController reviewBoardList before board.getEnd : {} ", board.getContent_id());
			
			List<Board> revicewAllList = boardService.getReviewAllList(board); 
			log.info("ExperienceController revicewAllList size : {}", revicewAllList.size());

			log.info("ExperienceController reviewBoardList after board.getStart : {} ", board.getStart());
			log.info("ExperienceController reviewBoardList after board.getEnd : {} ", board.getEnd());

			bigCode = revicewAllList.get(0).getBig_code();

			log.info("ExperienceController reviewBoardList totalBoard : {} ", countBoard);
			log.info("ExperienceController reviewBoardList smallCode : {} ", smallCode);
			log.info("ExperienceController reviewBoardList page : {} ", page);

			model.addAttribute("reviewBoard", revicewAllList);
			model.addAttribute("page", page);
			model.addAttribute("bigCode", bigCode);
			model.addAttribute("smallCode", smallCode);
			model.addAttribute("userId", userId);
		} catch (Exception e) {
			log.error("ExperienceController review error : {}", e.getMessage());
		} finally {
			log.info("ExperienceController review end..");
		}
		
		return "experience/experienceDetail";
	}
	
	@RequestMapping(value = "experience/writeForm")
	public String writeFormExperience(Model model) {
		
		return "experience/writeFormExperience";
	}
	
	@GetMapping(value = "experience1")
	public String listSearch(ExperienceContent experience,String currentPage, Model model, HttpServletRequest request) {
//	public String listSearch(String big_code,String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "experience", "start");
			int totalSearchExperience = es.totalMainSearchExperience(experience);
			
			int path = 1;
			String small_code = request.getParameter("small_code");
			String big_code = request.getParameter("big_code");
			String keyword = request.getParameter("keyword");
			String area = request.getParameter("area");			
			
			Paging page = new Paging(totalSearchExperience, currentPage);
			experience.setStart(page.getStart());
			experience.setEnd(page.getEnd());
			List<Areas> listAreas = as.listAreas();
			List<ExperienceContent> listSmallCode  = es.listSmallCode(experience);
			List<ExperienceContent> listSearchExperience = es.listMainSearchExperience(experience);
			
			model.addAttribute("totalExperience", totalSearchExperience);
			model.addAttribute("listExperience", listSearchExperience);
			model.addAttribute("listSmallCode", listSmallCode);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);
			model.addAttribute("path", path);
			model.addAttribute("small_code", small_code);
			model.addAttribute("big_code", big_code);
			model.addAttribute("keyword", keyword);
			model.addAttribute("area", area);

	
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "experience", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "experience", "end");
		}
		return "experience/experienceList";
	}
}
