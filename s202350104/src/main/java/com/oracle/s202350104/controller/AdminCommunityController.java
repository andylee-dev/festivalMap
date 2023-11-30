package com.oracle.s202350104.controller;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Paging;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.TagsService;
import com.oracle.s202350104.service.user.UserService;
import com.oracle.s202350104.utils.FileUploadDeleteUtil;

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
		board.setSmall_code(2); // 분류 code 강제 지정
		int userId = 1;

		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(board);

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
		log.info("AdminCommunityController magazinBoardList smallCode : {} ", board.getSmall_code());
		log.info("AdminCommunityController magazinBoardList page : {} ", page);
		log.info("AdminCommunityController magazinBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", magazinAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", board.getSmall_code());
		model.addAttribute("userId", userId);

		log.info("AdminCommunityController magazinBoardList End..");

		return "admin/community/communityBoard";
	}

	// 자유게시판 List Logic
	@RequestMapping(value = "/board")
	public String freeBoardList(Board board, String currentPage, Model model) {
		log.info("AdminCommunityController freeBoardList Start!!");
		int bigCode = 0;
		board.setSmall_code(3); // 분류 code 강제 지정
		// board.setComment_indent(0);
		board.setIs_deleted("0");
		int userId = 1;

		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(board);

		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("AdminCommunityController freeBoardList before board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController freeBoardList before board.getEnd : {} ", board.getEnd());
		log.info("AdminCommunityController freeBoardList before currentPage : {} ", currentPage);

		List<Board> freeAllList = boardService.getFreeAllList(board);
		log.info("AdminCommunityController freeAllList size : {}", freeAllList.size());

		log.info("AdminCommunityController freeBoardList after board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController freeBoardList after board.getEnd : {} ", board.getEnd());
		log.info("AdminCommunityController freeBoardList after currentPage : {} ", currentPage);

		if (freeAllList.size() != 0) {
			bigCode = freeAllList.get(0).getBig_code();
		} else {
			log.error("BoardController freeBoard 값이 없습니다.");
		}

		log.info("AdminCommunityController freeBoardList totalBoard : {} ", countBoard);
		log.info("AdminCommunityController freeBoardList smallCode : {} ", board.getSmall_code());
		log.info("AdminCommunityController freeBoardList page : {} ", page);
		log.info("AdminCommunityController freeBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", freeAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", board.getSmall_code());
		model.addAttribute("userId", userId);

		log.info("AdminCommunityController freeBoardList End..");

		return "admin/community/communityBoard";
	}

	// 리뷰 List Logic
	@RequestMapping(value = "/review")
	public String reviewBoardList(Board board, String currentPage, Model model) {
		log.info("AdminCommunityController reviewBoardList Start!!");
		int bigCode = 0;
		board.setSmall_code(6); // 분류 code 강제 지정
		board.setIs_deleted("0");
		int userId = 1;

		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.adminboardCount(board);

		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		log.info("AdminCommunityController reviewBoardList before board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController reviewBoardList before board.getEnd : {} ", board.getEnd());
		log.info("AdminCommunityController reviewBoardList before currentPage : {} ", currentPage);

		List<Board> reviewAllList = boardService.getReviewAllList(board);
		log.info("AdminCommunityController reviewBoardList size : {}", reviewAllList.size());

		log.info("AdminCommunityController reviewBoardList after board.getStart : {} ", board.getStart());
		log.info("AdminCommunityController reviewBoardList after board.getEnd : {} ", board.getEnd());
		log.info("AdminCommunityController reviewBoardList after currentPage : {} ", currentPage);

		if (reviewAllList.size() != 0) {
			bigCode = reviewAllList.get(0).getBig_code();
		} else {
			log.error("BoardController freeBoard 값이 없습니다.");
		}

		log.info("AdminCommunityController reviewBoardList totalBoard : {} ", countBoard);
		log.info("AdminCommunityController reviewBoardList smallCode : {} ", board.getSmall_code());
		log.info("AdminCommunityController reviewBoardList page : {} ", page);
		log.info("AdminCommunityController reviewBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", reviewAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", board.getSmall_code());
		model.addAttribute("userId", userId);

		log.info("AdminCommunityController reviewBoardList End..");

		return "admin/community/communityBoard";
	}

	// 통합게시판 상세정보 Logic
	@RequestMapping(value = "/communityDetail")
	public String communityContent(int id, Integer userId, Model model) {

		log.info("AdminCommunityController communityContent boardId : {} ", id);
		log.info("AdminCommunityController communityContent userId : {} ", userId);

		Optional<Users> loginUser = null;

		if (userId > 0) {
			loginUser = us.getUserById(userId);
			log.info("AdminCommunityController loginUser : {} ", loginUser);

			if (loginUser.isPresent()) {
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
	public String communityUpdate(Board board, int userId, MultipartFile file, Model model) {

		log.info("AdminCommunityController communityUpdate getTitle : {}", board.getTitle());

		// File upload Logic
		String pathDB = null;
		String fileName = null;
		String realFileSize = null;
		FileUploadDeleteUtil fileUploadDeleteUtil = new FileUploadDeleteUtil();
		int realName = file.getOriginalFilename().length();

		try {
			log.info("AdminCommunityController communityUpdate realName : {}", realName);

			// DB에 저장 된 파일명 조회
			Board deleteImageNameFind = boardService.boardRead(board.getId());
			log.info("AdminCommunityController communityUpdate getTitle filePart1 : {}", board.getTitle());
			// DB에 저장 된 파일명 가져오기
			fileName = deleteImageNameFind.getFile_name();

			// 기존 첨부파일 삭제(로컬)
			fileUploadDeleteUtil.deleteFile(fileName);
			log.info("AdminCommunityController communityUpdate getTitle filePart2 : {}", board.getTitle());

			// 파일 값이 있으면 저장
			if (realName > 0) {
				log.info("AdminCommunityController communityUpdate File Start!!");

				String[] uploadResult = fileUploadDeleteUtil.uploadFile(file);

				fileName = uploadResult[0];
				pathDB = uploadResult[1];
				realFileSize = uploadResult[2];
				log.info("AdminCommunityController communityUpdate getTitle filePart3 : {}", board.getTitle());

			} else {
				log.info("AdminCommunityController communityUpdate File errer : {}", "저장 할 파일이 없습니다.");
				log.info("AdminCommunityController communityUpdate getTitle filePart4 : {}", board.getTitle());
			}

		} catch (Exception e) {
			log.error("AdminCommunityController File upload error : {}", e.getMessage());
		} finally {
			log.info("AdminCommunityController communityUpdate File End..");
		}		
			
		// 게시물 생성 Logic(초기화)
		int updateCommunity = 0;
		// User ID 값이 있어야만 실행
		board.setUser_id(userId);
		log.info("AdminCommunityController communityUpdate getTitle2 : {}", board.getTitle());
		if (board.getUser_id() > 0) {
			log.info("AdminCommunityController communityUpdate Start!!");
			log.info("AdminCommunityController communityUpdate realName : {}", realName);

			if (realName > 0) {
				log.info("AdminCommunityController communityUpdate image Start!!");
				// File명, 경로 setting
				board.setFile_name(fileName);
				board.setFile_path(pathDB);
				board.setFile_size(realFileSize);

				updateCommunity = boardService.boardUpdate(board);
				log.info("AdminCommunityController communityUpdate getTitle3 : {}", board.getTitle());
			} else {
				log.info("AdminCommunityController communityUpdate normal Start!!");
				updateCommunity = boardService.boardUpdate(board);
				log.info("AdminCommunityController communityUpdate getTitle4 : {}", board.getTitle());
			}

			model.addAttribute("board", updateCommunity);
		}

		log.info("AdminCommunityController communityUpdate userId : {}", userId);

		model.addAttribute("userId", userId);		

		return "forward:communityDetail";
	}

	// 통합게시판 삭제 Logic(New, status로 삭제 여부)
	@RequestMapping(value = "/communityDelete")
	public String communityDelete(int id, Model model) {
		// value 확인용
		log.info("AdminCommunityController communityDelete id : {}", id);

		// 복원 Logic
		String redirectURL = "";
		int deleteDelete = 0;

		try {
			log.info("AdminCommunityController communityDelete Start!!");

			deleteDelete = boardService.boardDeleteNew(id);

			// 결과값에 따라 redirect 경로 지정
			if (deleteDelete > 0) {
				redirectURL = "redirect:/admin/community/magazin";

			} else {
				model.addAttribute("msg", "복원 실패!!, 관리자에게 문의해주세요.");
				redirectURL = "redirect:/admin/community/magazin";
			}

		} catch (Exception e) {
			log.error("AdminCommunityController communityDelete errer : {}", e.getMessage());
		}

		// 결과값에 따른 경로 이동
		return redirectURL;
	}

	// 통합게시판 복원 Logic
	@RequestMapping(value = "/communityRecycle")
	public String communityRecycle(int id, Model model) {
		// value 확인용
		log.info("AdminCommunityController communityRecycle id : {}", id);

		// 복원 Logic
		String redirectURL = "";
		int recycleNotice = 0;

		try {
			log.info("AdminCommunityController communityRecycle Start!!");

			recycleNotice = boardService.boardRecycle(id);

			// 결과값에 따라 redirect 경로 지정
			if (recycleNotice > 0) {
				redirectURL = "redirect:/admin/community/magazin";

			} else {
				model.addAttribute("msg", "복원 실패!!, 관리자에게 문의해주세요.");
				redirectURL = "redirect:/admin/community/magazin";
			}

		} catch (Exception e) {
			log.error("AdminCommunityController communityRecycle errer : {}", e.getMessage());
		}

		// 결과값에 따른 경로 이동
		return redirectURL;
	}

}
