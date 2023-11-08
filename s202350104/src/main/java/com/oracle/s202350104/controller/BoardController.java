package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Paging;
import com.oracle.s202350104.model.Report;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.ReportService;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	private final BoardService boardService;
	//게시판 신고기능 위해 service 추가
	private final ReportService res;
	private final UserService us;
	
	
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
		int userId = 1001;
		
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
		model.addAttribute("userId", userId);
		
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
		int userId = 1001;
		
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
		model.addAttribute("userId", userId);
		
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
		int userId = 1001;
		
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
		int userId = 1001;
		
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
		model.addAttribute("userId", userId);
		
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
		int userId = 1001;
		
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
		model.addAttribute("userId", userId);
		
		log.info("controller eventBoardList End..");

		return "board/photoEventBoardList";
	}
	
	/*
	 * review 통합 테스트용	
	 * */	
	// review List Logic
	@RequestMapping(value = "/reviewBoardList")
	public String reviewBoardList(Board board, String currentPage, Model model) {
		log.info("BoardController reviewBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 6;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("BoardController reviewBoardList before board.getStart : {} ", board.getStart());
		log.info("BoardController reviewBoardList before board.getEnd : {} ", board.getEnd());
		
		List<Board> revicewAllList = boardService.getReviewAllList(board);
		log.info("BoardController revicewAllList size : {}", revicewAllList.size());

		log.info("BoardController reviewBoardList after board.getStart : {} ", board.getStart());
		log.info("BoardController reviewBoardList after board.getEnd : {} ", board.getEnd());

		bigCode = revicewAllList.get(0).getBig_code();

		log.info("BoardController reviewBoardList totalBoard : {} ", countBoard);
		log.info("BoardController reviewBoardList smallCode : {} ", smallCode);
		log.info("BoardController reviewBoardList smallCode : {} ", bigCode);
		log.info("BoardController reviewBoardList page : {} ", page);

		model.addAttribute("board", revicewAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		
		log.info("BoardController reviewBoardList End..");

		return "board/integratedBoardList";
	}

	// 통합게시판 상세정보 Logic
	@RequestMapping(value = "/boardDetail")
	public String boardContent(int id, int userId, Model model) {

		log.info("BoardController boardContent boardId : {} ", id);
		log.info("BoardController boardContent userId : {} ", userId);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);
		model.addAttribute("userId", userId);

		return "board/boardDetail";

	}

	// 이벤트,포토게시판 상세정보 Logic
	@RequestMapping(value = "/photoEventBoardDetail")
	public String photoBoardDetail(int id, int userId, Model model) {

		log.info("BoardController boardContent boardId : {} ", id);
		log.info("BoardController boardContent userId : {} ", userId);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);
		model.addAttribute("userId", userId);

		return "board/photoEventBoardDetail"; 

	}

	// 통합게시판 수정 form Logic
	@RequestMapping(value = "/boardUpdateForm")
	public String boardUpdateForm(int id, Model model) {

		log.info("BoardController boardUpdateForm boardId : {} ", id);

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
	public String boardDelete(int id, int userId, int smallCode) {

		log.info("BoardController boardDelete small_code : {}", smallCode);
		log.info("BoardController boardDelete id : {}", id);
		log.info("BoardController boardDelete userId : {}", userId);

		boardService.boardDelete(id);

		String redirectURL = "";		
		
		if(smallCode == 1) {
			if(userId > 1) {
				redirectURL = "redirect:/noticBoardList";	
			} else {
				redirectURL = "redirect:/admin/notice/notice";
			}
		} else if(smallCode == 2) {
			if(userId > 1) {
				redirectURL = "redirect:/magazinBoardList";	
			} else {
				redirectURL = "redirect:/admin/community/magazin";
			}
		} else if(smallCode == 3) {
			if(userId > 1) {
				redirectURL = "redirect:/freeBoardList";	
			} else {
				redirectURL = "redirect:/admin/community/board";
			}
		} else if(smallCode == 4) {
			if(userId > 1) {
				redirectURL = "redirect:/photoBoardList";	
			} else {
				redirectURL = "redirect:/admin/community/photo";
			}
		} else if(smallCode == 5) {
			if(userId > 1) {
				redirectURL = "redirect:/eventBoardList";	
			} else {
				redirectURL = "redirect:/admin/notice/event";
			}
		} else if(smallCode == 6) {
			if(userId > 1) {
				redirectURL = "redirect:/reviewBoardList";	
			} else {
				redirectURL = "redirect:/admin/community/review";
			}
		} else {
			redirectURL = "redirect:/";
		}
		return redirectURL;
	}

	// review 게시물 생성 form Logic
	@RequestMapping(value = "/boardInsertForm")
	public String boardInsertForm(String userId, String bigCode, String smallCode, String contentId, String currentPage, Model model) {

		log.info("BoardController boardInsertForm start!");
		log.info("BoardController boardInsertForm userId : {}", userId);
		log.info("BoardController boardInsertForm bigCode : {}", bigCode);
		log.info("BoardController boardInsertForm smallCode : {}", smallCode);
		log.info("BoardController boardInsertForm contentId : {}", contentId);
		log.info("BoardController boardInsertForm currentPage : {}", currentPage);

		model.addAttribute("userId", userId);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("contentId", contentId);
		model.addAttribute("currentPage", currentPage);
		log.info("BoardController boardInsertForm end!");

		return "board/boardInsertForm";
	}

	// review 게시물 생성  Logic
	@RequestMapping(value = "/boardInsert")
	public String boardInsert(Board board, Model model) {

		log.info("BoardController boardInsert userId : {}", board.getUser_id());
		log.info("BoardController boardInsert bigCode : {}", board.getBig_code());
		log.info("BoardController boardInsert smallCode : {}", board.getSmall_code());
		log.info("BoardController boardInsert contentId : {}", board.getContent_id());

		int insertBoard = boardService.boardInsert(board);

		if (insertBoard > 0 && board.getSmall_code() == 1) {
			return "redirect:/noticBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 2) {
			return "redirect:/magazinBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 3) {
			return "redirect:/freeBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 4) {
			return "redirect:/photoBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 5) {
			return "redirect:/eventBoardList";
		} else if (insertBoard > 0 && board.getSmall_code() == 6) {
			return "redirect:/";
		} else {
			model.addAttribute("msg", "글쓰기 실패!, 다시 입력해주세요.");
			return "forward:/boardInsertForm";
		}
	}
	
	// 통합게시물 생성 form Logic	
	@RequestMapping(value = "/integratedBoardInsertForm")
	public String integratedBoardInsertForm(String userId, String bigCode, String smallCode, Model model) {
		
		log.info("BoardController integratedBoardInsertForm start!");
		log.info("BoardController integratedBoardInsertForm userId : {}", userId);
		log.info("BoardController integratedBoardInsertForm bigCode : {}", bigCode);
		log.info("BoardController integratedBoardInsertForm smallCode : {}", smallCode);
		
		model.addAttribute("userId", userId);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		
		log.info("BoardController integratedBoardInsertForm end!");
		
		return "board/integratedBoardInsertForm";
	}
	
	// 통합게시판 생성 Logic
	@RequestMapping(value = "/integratedboardInsert")
	public String integratedboardInsert(Board board, Model model) {

		log.info("BoardController integratedboardInsert userId : {}", board.getUser_id());
		log.info("BoardController integratedboardInsert bigCode : {}", board.getBig_code());
		log.info("BoardController integratedboardInsert smallCode : {}", board.getSmall_code());

		int insertBoard = boardService.boardInsert(board);

		if (insertBoard > 0 && board.getSmall_code() == 1) {
			if(board.getUser_id() == 1){
				return "redirect:/admin/notice/notice";
			}
			return "forward:/noticBoardList";
			
		} else if (insertBoard > 0 && board.getSmall_code() == 2) {
			if(board.getUser_id() == 1){
				return "redirect:/admin/community/magazin";
			}
			return "forward:/magazinBoardList";
			
		} else if (insertBoard > 0 && board.getSmall_code() == 3) {
			if(board.getUser_id() == 1){
				return "redirect:/admin/community/board";
			}
			return "forward:/freeBoardList";
			
		} else if (insertBoard > 0 && board.getSmall_code() == 4) {
			return "forward:/photoBoardList";
			
		} else if (insertBoard > 0 && board.getSmall_code() == 5) {
			if(board.getUser_id() == 1){
				return "redirect:/admin/notice/event";
			}
			return "forward:/eventBoardList";
			
		} else if (insertBoard > 0 && board.getSmall_code() == 6) {
			if(board.getUser_id() == 1){
				return "redirect:/admin/community/review";
			}
			return "forward:/";
		} else {
			model.addAttribute("msg", "글쓰기 실패!, 다시 입력해주세요.");
			return "forward:/integratedBoardInsertForm";
		}
	}
	
	// 게시판 신고기능 -송환
	@GetMapping("/reportBoardFoam")
    public String reportBoard(int boardId, Model model) {
		log.info("boardId->"+ boardId);
		try {
			Board reportBoard = boardService.boardDetail(boardId);
		int userid = us.getLoggedInId();
		model.addAttribute("board",reportBoard );
		model.addAttribute("userId",userid);
		} catch (Exception e) {
			
		}
		
        return "board/boardReportForm";
    }
	// 게시판 신고기능 -송환
	@RequestMapping(value = "boardReportUpdate")
	public String boardReportUpdate(Report report, Model model) {
		UUID transactionId = UUID.randomUUID();
		String message = "";
		try {
			log.info("[{}]{}:{}",transactionId, "admin festivalDetail", "start");
			int result = res.boardReportUpdate(report);
			 if (result == 0) {
				 message = "이미 신고한 게시글입니다.";
		     }else if (result ==1 ) {
		    	 message = "신고완료";
			}
			 model.addAttribute("message", message);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "admin detailExperience", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "admin detailExperience", "end");
		}		
		return "board/boardReportClose";
	}
} 
