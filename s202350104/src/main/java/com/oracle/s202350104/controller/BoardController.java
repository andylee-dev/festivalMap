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

	    int bigCode = 0; 
	    int smallCode = 0;

	    // Parameter board page 추가
	    List<Board> noticAllList = boardService.getNoticAllList(board);
	    log.info("controller noticAllList size : {}", noticAllList.size());
	    
	    bigCode = noticAllList.get(0).getBig_code();
	    smallCode = noticAllList.get(0).getSmall_code();

	    // smallCode를 이용해 countBoard를 설정
	    int countBoard = boardService.boardCount(smallCode);
	    log.info("controller noticAllList totalBoard : {} ", countBoard);
	    log.info("controller noticAllList smallCode : {} ", smallCode);

	    // Paging 작업
	    Paging page = new Paging(currentPage, countBoard);
	    board.setStart(page.getStart()); // Paging 객체 초기화 후에 설정
	    board.setEnd(page.getEnd()); // Paging 객체 초기화 후에 설정

	    // 나머지 코드는 그대로 유지	    
	    model.addAttribute("board", noticAllList);
	    model.addAttribute("page", page);
	    model.addAttribute("bigCode", bigCode);
	    model.addAttribute("smallCode", smallCode);

	    return "board/integratedBoardList";
	}

	// 이달의 소식 List Logic
	@RequestMapping(value = "/magazinBoardList")
	public String magazinBoardList(Board board, String currentPage, Model model) {

	    int bigCode = 0; 
	    int smallCode = 0;

	    // Parameter board page 추가
	    List<Board> magazinAllList = boardService.getMagazinAllList(board);
	    log.info("controller magazinAllList size : {}", magazinAllList.size());
	    
	    bigCode = magazinAllList.get(0).getBig_code();
	    smallCode = magazinAllList.get(0).getSmall_code();

	    // smallCode를 이용해 countBoard를 설정
	    int countBoard = boardService.boardCount(smallCode);
	    log.info("controller magazinAllList totalBoard : {} ", countBoard);
	    log.info("controller magazinAllList smallCode : {} ", smallCode);

	    // Paging 작업
	    Paging page = new Paging(currentPage, countBoard);
	    board.setStart(page.getStart()); // Paging 객체 초기화 후에 설정
	    board.setEnd(page.getEnd()); // Paging 객체 초기화 후에 설정

	    // 나머지 코드는 그대로 유지	    
	    model.addAttribute("board", magazinAllList);
	    model.addAttribute("page", page);
	    model.addAttribute("bigCode", bigCode);
	    model.addAttribute("smallCode", smallCode);

	    return "board/integratedBoardList";
	}

	// 자유게시판 List Logic
	@RequestMapping(value = "/freeBoardList")
	public String freeBoardList(Board board, String currentPage, Model model) {
	    
	    int bigCode = 0; 
	    int smallCode = 0;

	    // Parameter board page 추가
	    List<Board> freeAllList = boardService.getFreeAllList(board);
	    log.info("controller freeAllList size : {}", freeAllList.size());
	    
	    bigCode = freeAllList.get(0).getBig_code();
	    smallCode = freeAllList.get(0).getSmall_code();

	    // smallCode를 이용해 countBoard를 설정
	    int countBoard = boardService.boardCount(smallCode);
	    log.info("controller freeAllList totalBoard : {} ", countBoard);
	    log.info("controller freeAllList smallCode : {} ", smallCode);

	    // Paging 작업
	    Paging page = new Paging(currentPage, countBoard);
	    board.setStart(page.getStart()); // Paging 객체 초기화 후에 설정
	    board.setEnd(page.getEnd()); // Paging 객체 초기화 후에 설정

	    // 나머지 코드는 그대로 유지	    
	    model.addAttribute("board", freeAllList);
	    model.addAttribute("page", page);
	    model.addAttribute("bigCode", bigCode);
	    model.addAttribute("smallCode", smallCode);

	    return "board/integratedBoardList";
	}

	// 포토게시판 Logic
	@RequestMapping(value = "/photoBoardList")
	public String photoBoardList(Board board, String currentPage, Model model) {
		int bigCode = 0;
		int smallCode = 0;
		
		int countBoard = boardService.boardCount(smallCode);
		log.info("controller photoAllList totalBoard : {} ", countBoard);

		// Paging 작업
		Paging page = new Paging(currentPage, countBoard);

		// Parameter board page 추가
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		List<Board> photoAllList = boardService.getPhotoAllList(board);
		log.info("controller photoAllList size : {}", photoAllList.size());

		bigCode = photoAllList.get(0).getBig_code();
		smallCode = photoAllList.get(0).getSmall_code();

		model.addAttribute("board", photoAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);

		return "board/photoEventBoardList";
	}

	// 이벤트 Logic
	@RequestMapping(value = "/eventBoardList")
	public String eventBoardList(Board board, String currentPage, Model model) {
		int bigCode = 0;
		int smallCode = 0;
		
		int countBoard = boardService.boardCount(smallCode);
		log.info("controller eventBoardList totalBoard : {} ", countBoard);

		// Paging 작업
		Paging page = new Paging(currentPage, countBoard);

		// Parameter board page 추가
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());

		List<Board> eventAllList = boardService.getEventAllList(board);
		log.info("controller eventBoardList size : {}", eventAllList.size());

		bigCode = eventAllList.get(0).getBig_code();
		smallCode = eventAllList.get(0).getSmall_code();

		model.addAttribute("board", eventAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);

		return "board/photoEventBoardList";
	}

	// 게시판 상세정보 Logic
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
			redirectURL = null;
			break;
		default:
			// 기본 처리, 오류 처리용
			redirectURL = "redirect:/home";
			break;
		}

		return redirectURL;
	}

	// 통합게시판 생성 form Logic
	@RequestMapping(value = "/boardInsertForm")
	public String boardInsertForm(String userId, String bigCode, String smallCode, Model model) {

		log.info("controller boardInsertForm start!");
		log.info("controller boardInsertForm userId : {}", userId);
		log.info("controller boardInsertForm bigCode : {}", bigCode);
		log.info("controller boardInsertForm smallCode : {}", smallCode);

		model.addAttribute("userId", userId);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		log.info("controller boardInsertForm end!");

		return "board/boardInsertForm";
	}

	// 통합게시판 생성 Logic
	@RequestMapping(value = "/boardInsert")
	public String boardInsert(Board board, Model model) {

		log.info("controller boardInsert userId : {}", board.getUser_id());
		log.info("controller boardInsert bigCode : {}", board.getBig_code());
		log.info("controller boardInsert smallCode : {}", board.getSmall_code());
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
			return null;
		} else {
			model.addAttribute("msg", "글쓰기 실패!, 다시 입력해주세요.");
			return "forward:/boardInsertForm";
		}
	}
}
