package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Paging;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/notice")
public class AdminNoticeController {
	
	private final BoardService boardService;
	private final BannerService bannerService;
	
	// 공지사항 List Logic
	@RequestMapping(value = "/notice")
	public String noticBoardList(Board board, String currentPage, Model model) {
		log.info("AdminNoticeController noticBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 1;
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("AdminNoticeController noticBoardList before board.getStart : {} ", board.getStart());
		log.info("AdminNoticeController noticBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> noticAllList = boardService.getNoticAllList(board);
		log.info("AdminNoticeController noticAllList size : {}", noticAllList.size());

		log.info("AdminNoticeController noticBoardList after board.getStart : {} ", board.getStart());
		log.info("AdminNoticeController noticBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = noticAllList.get(0).getBig_code();

		log.info("AdminNoticeController noticBoardList totalBoard : {} ", countBoard);
		log.info("AdminNoticeController noticBoardList smallCode : {} ", smallCode);
		log.info("AdminNoticeController noticBoardList page : {} ", page);
		log.info("AdminNoticeController noticBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", noticAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("AdminNoticeController noticBoardList End..");

		return "admin/notification/notice";
	}
	
	// 이벤트 List Logic
	@RequestMapping(value = "/event")
	public String eventBoardList(Board board, String currentPage, Model model) {
		log.info("AdminNoticeController eventBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 5;
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("AdminNoticeController eventBoardList before board.getStart : {} ", board.getStart());
		log.info("AdminNoticeController eventBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> eventAllList = boardService.getEventAllList(board);
		log.info("AdminNoticeController eventAllList size : {}", eventAllList.size());

		log.info("AdminNoticeController eventBoardList after board.getStart : {} ", board.getStart());
		log.info("AdminNoticeController eventBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = eventAllList.get(0).getBig_code();

		log.info("AdminNoticeController eventBoardList totalBoard : {} ", countBoard);
		log.info("AdminNoticeController eventBoardList smallCode : {} ", smallCode);
		log.info("AdminNoticeController eventBoardList page : {} ", page);
		log.info("AdminNoticeController eventBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", eventAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("AdminNoticeController eventBoardList End..");

		return "admin/notification/notice";
	}
	
	// Banner List Logic
	@RequestMapping(value = "/banner")
	public String bannerBoardList(Board board, String currentPage, Model model) {
		log.info("AdminNoticeController bannerBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 0;
		
		// smallCode를 이용해 countBoard를 설정
		int countBanner = bannerService.bannerCount();
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBanner);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("AdminNoticeController bannerBoardList before board.getStart : {} ", board.getStart());
		log.info("AdminNoticeController bannerBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Banner> bannerAllList = bannerService.getBannerAllList(board);
		log.info("AdminNoticeController bannerAllList size : {}", bannerAllList.size());

		log.info("AdminNoticeController bannerBoardList after board.getStart : {} ", board.getStart());
		log.info("AdminNoticeController bannerBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = bannerAllList.get(0).getBig_code();
		smallCode = bannerAllList.get(0).getSmall_code();

		log.info("AdminNoticeController bannerBoardList totalBoard : {} ", countBanner);
		//log.info("AdminNoticeController bannerBoardList smallCode : {} ", smallCode);
		log.info("AdminNoticeController bannerBoardList page : {} ", page);
		log.info("AdminNoticeController bannerBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", bannerAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		
		log.info("AdminNoticeController bannerBoardList End..");

		return "admin/notification/notice";
	}
	
	// Banner Insert Form Logic
}
