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
	
	/*
	 *  smallCode 초기값 강제 고정, 향후 리팩토링 예정
	 * 
	 * */
	
	// 공지사항 List Logic
	@RequestMapping(value = "/noticBoardList")
	public String noticBoardList(Board board, String currentPage, Model model) {
		log.info("controller noticBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("controller noticBoardList before board.getStart : {} ", board.getStart());
		log.info("controller noticBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> noticAllList = boardService.getNoticAllList(board);
		log.info("controller noticAllList size : {}", noticAllList.size());

		log.info("controller noticBoardList after board.getStart : {} ", board.getStart());
		log.info("controller noticBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = noticAllList.get(0).getBig_code();

		log.info("controller noticBoardList totalBoard : {} ", countBoard);
		log.info("controller noticBoardList smallCode : {} ", smallCode);
		log.info("controller noticBoardList page : {} ", page);

		model.addAttribute("board", noticAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		log.info("controller noticBoardList End..");

		return "board/integratedBoardList";
	}

	// 이달의 소식 List Logic
	@RequestMapping(value = "/magazinBoardList")
	public String magazinBoardList(Board board, String currentPage, Model model) {
		log.info("controller magazinBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 2;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("controller magazinBoardList before board.getStart : {} ", board.getStart());
		log.info("controller magazinBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> magazinAllList = boardService.getMagazinAllList(board);
		log.info("controller magazinAllList size : {}", magazinAllList.size());

		log.info("controller magazinBoardList after board.getStart : {} ", board.getStart());
		log.info("controller magazinBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = magazinAllList.get(0).getBig_code();

		log.info("controller magazinBoardList totalBoard : {} ", countBoard);
		log.info("controller magazinBoardList smallCode : {} ", smallCode);
		log.info("controller magazinBoardList page : {} ", page);

		model.addAttribute("board", magazinAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		
		log.info("controller magazinBoardList End..");

		return "board/integratedBoardList";
	}

	// 자유게시판 List Logic
	@RequestMapping(value = "/freeBoardList")
	public String freeBoardList(Board board, String currentPage, Model model) {
		log.info("controller freeBoardList Start!!");
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
		log.info("controller freeBoardList before board.getStart : {} ", board.getStart());
		log.info("controller freeBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> freeAllList = boardService.getFreeAllList(board);
		log.info("controller freeAllList size : {}", freeAllList.size());

		log.info("controller freeBoardList after board.getStart : {} ", board.getStart());
		log.info("controller freeBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = freeAllList.get(0).getBig_code();

		log.info("controller freeBoardList totalBoard : {} ", countBoard);
		log.info("controller freeBoardList smallCode : {} ", smallCode);
		log.info("controller freeBoardList bigCode : {} ", bigCode);
		log.info("controller freeBoardList page : {} ", page);

		model.addAttribute("board", freeAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("controller freeBoardList End..");

		return "board/integratedBoardList";
	}

	// 포토게시판 Logic
	@RequestMapping(value = "/photoBoardList")
	public String photoBoardList(Board board, String currentPage, Model model) {
		log.info("controller photoBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 4;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("controller photoBoardList before board.getStart : {} ", board.getStart());
		log.info("controller photoBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> photoAllList = boardService.getPhotoAllList(board);
		log.info("controller photoAllList size : {}", photoAllList.size());

		log.info("controller photoBoardList after board.getStart : {} ", board.getStart());
		log.info("controller photoBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = photoAllList.get(0).getBig_code();

		log.info("controller photoBoardList totalBoard : {} ", countBoard);
		log.info("controller photoBoardList smallCode : {} ", smallCode);
		log.info("controller photoBoardList page : {} ", page);

		model.addAttribute("board", photoAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		
		log.info("controller photoBoardList End..");

		return "board/photoEventBoardList";
	}

	// 이벤트게시판 Logic
	@RequestMapping(value = "/eventBoardList")
	public String eventBoardList(Board board, String currentPage, Model model) {
		log.info("controller eventBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 5;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("controller eventBoardList before board.getStart : {} ", board.getStart());
		log.info("controller eventBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> eventAllList = boardService.getEventAllList(board);
		log.info("controller eventAllList size : {}", eventAllList.size());

		log.info("controller eventBoardList after board.getStart : {} ", board.getStart());
		log.info("controller eventBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = eventAllList.get(0).getBig_code();

		log.info("controller eventBoardList totalBoard : {} ", countBoard);
		log.info("controller eventBoardList smallCode : {} ", smallCode);
		log.info("controller eventBoardList page : {} ", page);

		model.addAttribute("board", eventAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		
		log.info("controller eventBoardList End..");

		return "board/photoEventBoardList";
	}
	
	/*
	 * review 통합 테스트용	
	 * */	
	// review List Logic
	@RequestMapping(value = "/reviewBoardList")
	public String reviewBoardList(Board board, String currentPage, Model model) {
		log.info("controller reviewBoardList Start!!");
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
		log.info("controller reviewBoardList before board.getStart : {} ", board.getStart());
		log.info("controller reviewBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> revicewAllList = boardService.getReviewAllList(board);
		log.info("controller revicewAllList size : {}", revicewAllList.size());

		log.info("controller reviewBoardList after board.getStart : {} ", board.getStart());
		log.info("controller reviewBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = revicewAllList.get(0).getBig_code();

		log.info("controller reviewBoardList totalBoard : {} ", countBoard);
		log.info("controller reviewBoardList smallCode : {} ", smallCode);
		log.info("controller reviewBoardList smallCode : {} ", bigCode);
		log.info("controller reviewBoardList page : {} ", page);

		model.addAttribute("board", revicewAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("controller reviewBoardList End..");

		return "board/integratedBoardList";
	}

	// 통합게시판 상세정보 Logic
	@RequestMapping(value = "/boardDetail")
	public String boardContent(int id, Model model) {

		log.info("controller boardContent boardId : {} ", id);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);

		return "board/boardDetail";

	}

	// 이벤트,포토게시판 상세정보 Logic
	@RequestMapping(value = "/photoEventBoardDetail")
	public String photoBoardDetail(int id, Model model) {

		log.info("controller boardContent boardId : {} ", id);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);

		return "board/photoEventBoardDetail"; 

	}

	// 통합게시판 수정 form Logic
	@RequestMapping(value = "/boardUpdateForm")
	public String boardUpdateForm(int id, Model model) {

		log.info("controller boardUpdateForm boardId : {} ", id);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);

		return "board/boardUpdateForm";
	}

	// 통합게시판 수정 Logic
	@PostMapping(value = "/boardUpdate")
	public String boardUpdate(Board board, Model model) {

		int updateBoard = boardService.boardUpdate(board);

		model.addAttribute("board", updateBoard);

		return "forward:boardDetail";
	}

	// 통합게시판 삭제 Logic
	@RequestMapping(value = "/boardDelete")
	public String boardDelete(int id, int smallCode) {

		log.info("controller boardDelete small_code : {}", smallCode);
		log.info("controller boardDelete id : {}", id);

		boardService.boardDelete(id);

		String redirectURL = "";

		switch (smallCode) {
		case 1:
			// 삭제 후, 공지사항 redirect
			redirectURL = "redirect:/noticBoardList";
			break;
		case 2:
			// 삭제 후, 이달의 소식 redirect
			redirectURL = "redirect:/magazinBoardList";
			break;
		case 3:
			// 삭제 후, 자유게시판 redirect
			redirectURL = "redirect:/freeBoardList";
			break;
		case 4:
			// 삭제 후, 포토게시판 redirect
			redirectURL = "redirect:/photoBoardList";
			break;
		case 5:
			// 삭제 후, 이벤트게시판 redirect
			redirectURL = "redirect:/eventBoardList";
			break;
		case 6:
			// 삭제 후, 공지사항 redirect
			redirectURL = "redirect:/reviewBoardList";
			break;
		default:
			// 기본 처리, 오류 처리용
			redirectURL = "redirect:/";
			break;
		}

		return redirectURL;
	}

	// 통합게시판 생성 form Logic
	@RequestMapping(value = "/boardInsertForm")
	public String boardInsertForm(String userId, String bigCode, String smallCode, String contentId, Model model) {

		log.info("controller boardInsertForm start!");
		log.info("controller boardInsertForm userId : {}", userId);
		log.info("controller boardInsertForm bigCode : {}", bigCode);
		log.info("controller boardInsertForm smallCode : {}", smallCode);
		log.info("controller boardInsertForm contentId : {}", contentId);

		model.addAttribute("userId", userId);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("contentId", contentId);
		log.info("controller boardInsertForm end!");

		return "board/boardInsertForm";
	}

	// 통합게시판 생성 Logic
	@RequestMapping(value = "/boardInsert")
	public String boardInsert(Board board, Model model) {

		log.info("controller boardInsert userId : {}", board.getUser_id());
		log.info("controller boardInsert bigCode : {}", board.getBig_code());
		log.info("controller boardInsert smallCode : {}", board.getSmall_code());
		log.info("controller boardInsert contentId : {}", board.getContent_id());

		int insertBoard = boardService.boardInsert(board);

		if (insertBoard > 0 && board.getSmall_code() == 1) {
			return "forward:/noticBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 2) {
			return "forward:/magazinBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 3) {
			return "forward:/freeBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 4) {
			return "forward:/photoBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 5) {
			return "forward:/eventBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 6) {
			return "redirect:/";
		} else {
			model.addAttribute("msg", "글쓰기 실패!, 다시 입력해주세요.");
			return "forward:/boardInsertForm";
		}
	}
} 
