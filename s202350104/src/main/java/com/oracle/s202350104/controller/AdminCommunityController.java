package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Paging;
import com.oracle.s202350104.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/community")
public class AdminCommunityController {
	
	private final BoardService boardService;
	
	// 이달의 소식 List Logic
	@RequestMapping(value = "/magazin")
	public String magazinBoardList(Board board, String currentPage, Model model) {
		log.info("AdminCommunityController magazinBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 2;
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("AdminCommunityController magazinBoardList before board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController magazinBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> magazinAllList = boardService.getMagazinAllList(board);
		log.info("AdminCommunityController magazinAllList size : {}", magazinAllList.size());

		log.info("AdminCommunityController magazinBoardList after board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController magazinBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = magazinAllList.get(0).getBig_code();

		log.info("AdminCommunityController magazinBoardList totalBoard : {} ", countBoard);
		log.info("AdminCommunityController magazinBoardList smallCode : {} ", smallCode);
		log.info("AdminCommunityController magazinBoardList page : {} ", page);
		log.info("AdminCommunityController magazinBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", magazinAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("AdminCommunityController magazinBoardList End..");

		return "admin/community/freeBoard";
	}
	
	// 자유게시판 List Logic
	@RequestMapping(value = "/board")
	public String freddBoardList(Board board, String currentPage, Model model) {
		log.info("AdminCommunityController freddBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 3;
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("AdminCommunityController freddBoardList before board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController freddBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> freeAllList = boardService.getFreeAllList(board);
		log.info("AdminCommunityController freeAllList size : {}", freeAllList.size());

		log.info("AdminCommunityController freddBoardList after board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController freddBoardList after board.getEnd : {} ", board.getEnd());
		log.info("AdminCommunityController freddBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = freeAllList.get(0).getBig_code();

		log.info("AdminCommunityController freddBoardList totalBoard : {} ", countBoard);
		log.info("AdminCommunityController freddBoardList smallCode : {} ", smallCode);
		log.info("AdminCommunityController freddBoardList page : {} ", page);
		log.info("AdminCommunityController freddBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", freeAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("AdminCommunityController freddBoardList End..");

		return "admin/community/freeBoard";
	}
	
	// 리뷰 List Logic
	@RequestMapping(value = "/review")
	public String reviewBoardList(Board board, String currentPage, Model model) {
		log.info("AdminCommunityController reviewBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 6;
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("AdminCommunityController reviewBoardList before board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController reviewBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> reviewAllList = boardService.getReviewAllList(board);
		log.info("AdminCommunityController eventAllList size : {}", reviewAllList.size());

		log.info("AdminCommunityController reviewBoardList after board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController reviewBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = reviewAllList.get(0).getBig_code();

		log.info("AdminCommunityController reviewBoardList totalBoard : {} ", countBoard);
		log.info("AdminCommunityController reviewBoardList smallCode : {} ", smallCode);
		log.info("AdminCommunityController reviewBoardList page : {} ", page);
		log.info("AdminCommunityController reviewBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", reviewAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("AdminCommunityController reviewBoardList End..");

		return "admin/community/freeBoard";
	}
}
