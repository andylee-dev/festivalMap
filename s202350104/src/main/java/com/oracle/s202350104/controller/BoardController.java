package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Paging;
import com.oracle.s202350104.service.BoardService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	private final BoardService boardService;

	// 공지사항 List Logic
	@RequestMapping(value = "/noticBoardList")
	public String noticBoardList(Board board, String currentPage, Model model) {

		int countBoard = boardService.boardCount();
		log.info("controller noticBoardList totalBoard : {} ", countBoard);

		// Paging 작업
		Paging page = new Paging(currentPage, countBoard);

		// Parameter board page 추가
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		List<Board> noticAllList = boardService.getNoticAllList(board);
		log.info("controller noticAllList size : {}", noticAllList.size());

		model.addAttribute("board", noticAllList);
		model.addAttribute("page", page);

		return "board/integratedBoard";
	}

	// 이달의 소식 List Logic
	@RequestMapping(value = "/magazinBoardList")
	public String magazinBoardList(Board board, String currentPage, Model model) {

		int countBoard = boardService.boardCount();
		log.info("controller magazinBoardList totalBoard : {} ", countBoard);

		// Paging 작업
		Paging page = new Paging(currentPage, countBoard);

		// Parameter board page 추가
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		List<Board> magazinAllList = boardService.getMagazinAllList(board);
		log.info("controller magazinAllList size : {}", magazinAllList.size());

		model.addAttribute("board", magazinAllList);
		model.addAttribute("page", page);

		return "board/integratedBoard";
	}

	// 자유게시판 List Logic
	@RequestMapping(value = "/freeBoardList")
	public String freeBoardList(Board board, String currentPage, Model model) {

		int countBoard = boardService.boardCount();
		log.info("controller freeAllList totalBoard : {} ", countBoard);

		// Paging 작업
		Paging page = new Paging(currentPage, countBoard);

		// Parameter board page 추가
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		List<Board> freeAllList = boardService.getFreeAllList(board);
		log.info("controller freeAllList size : {}", freeAllList.size());

		model.addAttribute("board", freeAllList);
		model.addAttribute("page", page);

		return "board/integratedBoard";
	}
	
	// 포토게시판 Logic
	@RequestMapping(value = "/photoBoardList")
	public String photoBoardList(Board board, String currentPage, Model model) {
		
		int countBoard = boardService.boardCount();
		log.info("controller photoAllList totalBoard : {} ", countBoard);

		// Paging 작업
		Paging page = new Paging(currentPage, countBoard);

		// Parameter board page 추가
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		List<Board> photoAllList = boardService.getPhotoAllList(board);
		log.info("controller photoAllList size : {}", photoAllList.size());

		model.addAttribute("board", photoAllList);
		model.addAttribute("page", page);
		
		return "board/photoBoardList";
	}
	
	// 이벤트 Logic
	@RequestMapping(value = "/eventBoardList")
	public String eventBoardList(Board board, String currentPage, Model model) {
		
		
		return "board/eventBoardList";
	}	

	// 게시판 상세정보 Logic
	@RequestMapping(value = "/boardDetail")
	public String boardContent(int id, Model model) {

		log.info("controller boardContent boardId : {} ", id);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);

		return "board/boardDetail";

	}
	
	// 포토게시판 상세정보 Logic
	@RequestMapping(value = "/photoBoardDetail")
	public String photoBoardDetail(int id, Model model) {
		
		log.info("controller boardContent boardId : {} ", id);
		
		Board boards = boardService.boardDetail(id);
		
		model.addAttribute("board", boards);
		
		return "board/photoBoardDetail";
		
	}

	// 게시판 수정 form Logic
	@RequestMapping(value = "/boardUpdateForm")
	public String boardUpdateForm(int id, Model model) {

		log.info("controller boardUpdateForm boardId : {} ", id);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);

		return "board/boardUpdateForm";
	}
	
	// 게시판 수정 Logic
	@PostMapping(value = "/boardUpdate")
	public String boardUpdate(Board board, Model model) {

		int updateBoard = boardService.boardUpdate(board);

		model.addAttribute("board", updateBoard);

		return "forward:boardDetail";
	}

}
