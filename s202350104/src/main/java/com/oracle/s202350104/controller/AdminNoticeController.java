package com.oracle.s202350104.controller;

import java.io.File;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

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
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.user.UserService;
import com.oracle.s202350104.utils.FileUploadDeleteUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/notice")
public class AdminNoticeController {
	
	private final BoardService boardService;
	private final BannerService bannerService;
	private final UserService us;	
	
	// 공지사항 List Logic
	@RequestMapping(value = "/notice")
	public String noticBoardList(Board board, String currentPage, Model model) {
		log.info("AdminNoticeController noticBoardList Start!!");
		int bigCode = 0;
		board.setSmall_code(1); // 분류 code 강제 지정
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(board);
		
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
		log.info("AdminNoticeController noticBoardList smallCode : {} ", board.getSmall_code());
		log.info("AdminNoticeController noticBoardList page : {} ", page);
		log.info("AdminNoticeController noticBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", noticAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", board.getSmall_code());
		model.addAttribute("userId", userId);
		
		log.info("AdminNoticeController noticBoardList End..");

		return "admin/notification/notice";
	}
	
	// 이벤트 List Logic
	@RequestMapping(value = "/event")
	public String eventBoardList(Board board, String currentPage, Model model) {
		log.info("AdminNoticeController eventBoardList Start!!");
		int bigCode = 0;
		board.setSmall_code(5); // 분류 code 강제 지정
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(board);
		
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
		log.info("AdminNoticeController eventBoardList smallCode : {} ", board.getSmall_code());
		log.info("AdminNoticeController eventBoardList page : {} ", page);
		log.info("AdminNoticeController eventBoardList bigCode : {} ", bigCode);

		model.addAttribute("admin", eventAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", board.getSmall_code());
		model.addAttribute("userId", userId);
		
		log.info("AdminNoticeController eventBoardList End..");

		return "admin/notification/notice";
	}
	
	// Banner List Logic
	@RequestMapping(value = "/banner")
	public String bannerBoardList(Banner banner, String currentPage, Model model) {
		log.info("AdminNoticeController bannerBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 0;
		int userId = 1;
		
		// smallCode를 이용해 countBoard를 설정
		int countBanner = bannerService.bannerCount(banner);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBanner);
		banner.setStart(page.getStart());
		banner.setEnd(page.getEnd());
		log.info("AdminNoticeController bannerBoardList before board.getStart : {} ", banner.getStart());
		log.info("AdminNoticeController bannerBoardList before board.getEnd : {} ", banner.getEnd());
		
		List<Banner> bannerAllList = bannerService.getBannerAllList(banner);
		log.info("AdminNoticeController bannerAllList size : {}", bannerAllList.size());

		log.info("AdminNoticeController bannerBoardList after board.getStart : {} ", banner.getStart());
		log.info("AdminNoticeController bannerBoardList after board.getEnd : {} ", banner.getEnd());

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
		model.addAttribute("userId", userId);
		
		log.info("AdminNoticeController bannerBoardList End..");

		return "admin/notification/notice";
	}
	
	// 통합게시판 상세정보 Logic
	@RequestMapping(value = "/noticeDetail")
	public String noticeDetail(int id, Integer userId, Model model) {

		log.info("AdminNoticeController noticeDetail boardId : {} ", id);
		log.info("AdminNoticeController noticeDetail userId : {} ", userId);
		
		Optional<Users> loginUser = null;
		
		if(userId > 0) {
			loginUser = us.getUserById(userId);
			log.info("AdminNoticeController loginUser : {} ", loginUser);
			
			if(loginUser.isPresent()) {
				model.addAttribute("loginUser", loginUser.get());				
			}
		} 		

		Board boards = boardService.boardDetail(id);
		List<Board> comments = boardService.commentDetail(id);
		
		model.addAttribute("board", boards);
		model.addAttribute("comment", comments);
		model.addAttribute("userId", userId);

		return "admin/notification/noticeDetail";
	}
	
	// notice 삭제 Logic(New, status로 삭제 여부)
	@RequestMapping(value = "/noticeDelete")
	public String noticeDelete(int id, Model model) {
		// value 확인용
		log.info("AdminNoticeController noticeDelete id : {}", id);
		
		// 복원 Logic
		String redirectURL = "";
		int deleteDelete = 0;
		
		try {
		 	log.info("AdminNoticeController noticeDelete Start!!");
			
		 	deleteDelete = boardService.boardDeleteNew(id);
		 	
		 	// 결과값에 따라 redirect 경로 지정
			if (deleteDelete > 0) {
				redirectURL = "redirect:/admin/notice/notice";
				
			} else {
				model.addAttribute("msg", "복원 실패!!, 관리자에게 문의해주세요.");
				redirectURL = "redirect:/admin/notice/notice";
			}
			
		} catch (Exception e) {
			log.error("AdminNoticeController noticeDelete errer : {}", e.getMessage());
		}
		
		// 결과값에 따른 경로 이동
		return redirectURL;
	}
	
	// notice 복원 Logic
	@RequestMapping(value = "/noticeRecycle")
	public String noticeRecycle(int id, Model model) {
		// value 확인용
		log.info("AdminNoticeController noticeRecycle id : {}", id);
		
		// 복원 Logic
		String redirectURL = "";
		int recycleNotice = 0;
		
		try {
			log.info("AdminNoticeController noticeRecycle Start!!");
			
			recycleNotice = boardService.boardRecycle(id);
			
			// 결과값에 따라 redirect 경로 지정
			if (recycleNotice > 0) {
				redirectURL = "redirect:/admin/notice/notice";
				
			} else {
				model.addAttribute("msg", "복원 실패!!, 관리자에게 문의해주세요.");
				redirectURL = "redirect:/admin/notice/notice";
			}
			
		} catch (Exception e) {
			log.error("AdminNoticeController noticeRecycle errer : {}", e.getMessage());
		}
		
		// 결과값에 따른 경로 이동
		return redirectURL;
	}
	
	// 통합게시판 수정 form Logic
	@RequestMapping(value = "/noticeUpdateForm")
	public String noticeUpdateForm(int id, int userId, Model model) {

		log.info("AdminNoticeController noticeUpdateForm boardId : {} ", id);
		log.info("AdminNoticeController noticeUpdateForm userId : {} ", userId);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);
		model.addAttribute("userId", userId);

		return "admin/notification/noticeUpdateForm";
	}
	
	// 통합게시판 수정 Logic
	@PostMapping(value = "/noticeUpdate")
	public String noticeUpdate(Board board, int userId,  MultipartFile file, Model model) {
		// value 확인용
		log.info("AdminNoticeController boardUpdate getFile_name : {}", board.getFile_name());
		log.info("AdminNoticeController boardUpdate getOriginalFilename : {}", file.getOriginalFilename().length());		
		log.info("AdminNoticeController noticeUpdate getTitle : {}", board.getTitle());

		// File upload Logic
		String pathDB = null;
		String fileName = null;
		String realFileSize = null;
		FileUploadDeleteUtil fileUploadDeleteUtil = new FileUploadDeleteUtil();
		int realName = file.getOriginalFilename().length();
		
		try {
			log.info("BoardController boardUpdate realName : {}", realName);
			
			// DB에 저장 된 파일명 조회
			Board deleteImageNameFind = boardService.boardRead(board.getId());

			// DB에 저장 된 파일명 가져오기
			fileName = deleteImageNameFind.getFile_name();
			
			// 기존 첨부파일 삭제(로컬)
			fileUploadDeleteUtil.deleteFile(fileName);				
			
			// 파일 값이 있으면 저장
			if (realName > 0) {
				log.info("BoardController boardUpdate File Start!!");
			
				String[] uploadResult = fileUploadDeleteUtil.uploadFile(file);

				fileName = uploadResult[0];
				pathDB = uploadResult[1];
				realFileSize = uploadResult[2];

			} else {
				log.info("BoardController boardUpdate File Save False! = Null!");
			}

		} catch (Exception e) {
			log.error("BoardController File upload error : {}", e.getMessage());
		} finally {
			log.info("BoardController boardUpdate File End..");
		}
		
		// 게시물 생성 Logic(초기화)
		int updateNotice = 0;
		// User ID 값이 있어야만 실행
		board.setUser_id(userId);

		if (board.getUser_id() > 0) {
			log.info("BoardController boardUpdate Start!!");
			log.info("BoardController boardUpdate realName : {}", realName);

			if (realName > 0) {
				log.info("BoardController boardUpdate image Start!!");
				// File명, 경로 setting
				board.setFile_name(fileName);
				board.setFile_path(pathDB);
				board.setFile_size(realFileSize);

				updateNotice = boardService.boardUpdate(board);

			} else {
				log.info("BoardController boardUpdate normal Start!!");
				updateNotice = boardService.boardUpdate(board);
			}
			log.info("AdminNoticeController noticeUpdate updateNotice : {}", updateNotice);
			model.addAttribute("board", updateNotice);
		}

		log.info("BoardController boardUpdate userId : {}", userId);

		model.addAttribute("userId", userId);

		
		return "forward:noticeDetail";
	}	
}
