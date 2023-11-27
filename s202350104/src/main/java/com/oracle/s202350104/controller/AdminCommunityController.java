package com.oracle.s202350104.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Paging;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.TagsService;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/community")
public class AdminCommunityController {

	private final BoardService boardService;
	private final UserService us;	
	private final TagsService tagsService;

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

		if (magazinAllList.size() != 0) {
			bigCode = magazinAllList.get(0).getBig_code();
		} else {
			log.error("BoardController notice 값이 없습니다.");
		}

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

		if (freeAllList.size() != 0) {
			bigCode = freeAllList.get(0).getBig_code();
		} else {
			log.error("BoardController freeBoard 값이 없습니다.");
		}

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

		if (reviewAllList.size() != 0) {
			bigCode = reviewAllList.get(0).getBig_code();
		} else {
			log.error("BoardController freeBoard 값이 없습니다.");
		}

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

	// 통합게시판 상세정보 Logic
	@RequestMapping(value = "/communityDetail")
	public String communityContent(int id, Integer userId, Model model) {

		log.info("AdminCommunityController communityContent boardId : {} ", id);
		log.info("AdminCommunityController communityContent userId : {} ", userId);
		
		Optional<Users> loginUser = null;
		
		if(userId > 0) {
			loginUser = us.getUserById(userId);
			log.info("AdminCommunityController boardContent loginUser : {} ", loginUser);
			
			if(loginUser.isPresent()) {
				model.addAttribute("loginUser", loginUser.get());				
			}
		} 		

		Board boards = boardService.boardDetail(id);
		List<Tags> hashTags = tagsService.boardTagDetail(id);
		List<Board> comments = boardService.commentDetail(id);
		
		log.info("AdminCommunityController boardContent hashTags.size : {} ", hashTags.size());
		
		model.addAttribute("board", boards);
		model.addAttribute("comment", comments);
		model.addAttribute("hashTag", hashTags);
		model.addAttribute("userId", userId);

		return "admin/community/communityDetail";
	}
	
	// 통합게시판 수정 form Logic
	@RequestMapping(value = "/communityUpdateForm")
	public String communityUpdateForm(int id, int userId, Model model) {

		log.info("AdminCommunityController communityUpdateForm boardId : {} ", id);
		log.info("AdminCommunityController communityUpdateForm userId : {} ", userId);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);
		model.addAttribute("userId", userId);

		return "admin/community/communityUpdateForm";
	}
	
	// 통합게시판 수정 Logic
	@PostMapping(value = "/communityUpdate")
	public String communityUpdate(Board board, int userId, Model model) {
		
		log.info("AdminCommunityController communityUpdate getTitle : {}", board.getTitle());
		
		int updateCommunity = boardService.boardUpdate(board);
		
		log.info("AdminCommunityController communityUpdate updateCommunity : {}", updateCommunity);
		
		model.addAttribute("board", updateCommunity);
		model.addAttribute("userId", userId);
		
		return "forward:communityDetail";
	}


}
