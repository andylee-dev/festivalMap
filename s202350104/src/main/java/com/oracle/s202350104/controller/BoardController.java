package com.oracle.s202350104.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Required;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Paging;
import com.oracle.s202350104.model.PhotoPaging;
import com.oracle.s202350104.model.Report;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.ReportService;
import com.oracle.s202350104.service.TagsService;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BoardController {

	private final BoardService boardService;
	private final BannerService bannerService;
	private final TagsService tagsService;
	
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
		log.info("BoardController noticBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 1;
		int userId = 1001;
		
		// smallCode를 이용해 countBoard 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		
		List<Board> noticAllList = boardService.getNoticAllList(board);
		
		log.info("BoardController noticBoardList before board.getStart : {} ", board.getStart());
		log.info("BoardController noticBoardList before board.getEnd : {} ", board.getEnd());	
		log.info("BoardController noticAllList size : {}", noticAllList.size());
		log.info("BoardController noticBoardList after board.getStart : {} ", board.getStart());
		log.info("BoardController noticBoardList after board.getEnd : {} ", board.getEnd());
		
		List<Banner> bannerHeader = bannerService.getHeaderBanner();
		List<Banner> bannerFooter = bannerService.getFooterBanner();		
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getTitle());
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getUrl());
		
		model.addAttribute("bannerHeader", bannerHeader);
		model.addAttribute("bannerFooter", bannerFooter);

		if(noticAllList.size() != 0) {
			bigCode = noticAllList.get(0).getBig_code();
		} else {
			log.error("BoardController notice 값이 없습니다.");
		}

		log.info("BoardController noticBoardList totalBoard : {} ", countBoard);
		log.info("BoardController noticBoardList smallCode : {} ", smallCode);
		log.info("BoardController noticBoardList userId : {} ", userId);	
		log.info("BoardController noticBoardList page : {} ", page);

		model.addAttribute("board", noticAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("BoardController noticBoardList End..");

		return "board/integratedBoardList";
	}

	// 이달의 소식 List Logic
	@RequestMapping(value = "/magazinBoardList")
	public String magazinBoardList(Board board, String currentPage, Model model) {
		log.info("BoardController magazinBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 2;
		int userId = 1001;
		
		// smallCode를 이용해 countBoard 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		
		List<Board> magazinAllList = boardService.getMagazinAllList(board);
		log.info("BoardController magazinAllList size : {}", magazinAllList.size());
		
		List<Banner> bannerHeader = bannerService.getHeaderBanner();
		List<Banner> bannerFooter = bannerService.getFooterBanner();		
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getTitle());
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getUrl());
		
		model.addAttribute("bannerHeader", bannerHeader);
		model.addAttribute("bannerFooter", bannerFooter);

		if(magazinAllList.size() != 0) {
			bigCode = magazinAllList.get(0).getBig_code();
		} else {
			log.error("BoardController magazin 값이 없습니다.");
		}

		model.addAttribute("board", magazinAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("BoardController magazinBoardList End..");

		return "board/integratedBoardList";
	}

	// 자유게시판 List Logic
	@RequestMapping(value = "/freeBoardList")
	public String freeBoardList(Board board, String currentPage, Model model) {
		log.info("BoardController freeBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 3;
		int userId = 1001;
		
		// smallCode를 이용해 countBoard 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		Paging page = new Paging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		
		List<Board> freeAllList = boardService.getFreeAllList(board);
		log.info("BoardController freeAllList size : {}", freeAllList.size());
		
		List<Banner> bannerHeader = bannerService.getHeaderBanner();
		List<Banner> bannerFooter = bannerService.getFooterBanner();		
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getTitle());
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getUrl());
		
		model.addAttribute("bannerHeader", bannerHeader);
		model.addAttribute("bannerFooter", bannerFooter); 

		if(freeAllList.size() != 0) {
			bigCode = freeAllList.get(0).getBig_code();
		} else {
			log.error("BoardController magazin 값이 없습니다.");
		}

		model.addAttribute("board", freeAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("BoardController freeBoardList End..");

		return "board/integratedBoardList";
	}

	// 포토게시판 Logic
	@RequestMapping(value = "/photoBoardList")
	public String photoBoardList(Board board, String currentPage, Model model) {
		log.info("BoardController photoBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 4;
		int userId = 1001;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		PhotoPaging page = new PhotoPaging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		
		List<Board> photoAllList = boardService.getPhotoAllList(board);
		log.info("BoardController photoAllList size : {}", photoAllList.size());
		
		List<Banner> bannerHeader = bannerService.getHeaderBanner();
		List<Banner> bannerFooter = bannerService.getFooterBanner();		
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getTitle());
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getUrl());
		
		model.addAttribute("bannerHeader", bannerHeader);
		model.addAttribute("bannerFooter", bannerFooter); 

		if(photoAllList.size() != 0) {
			bigCode = photoAllList.get(0).getBig_code();
		} else {
			log.error("BoardController magazin 값이 없습니다.");
		}

		model.addAttribute("board", photoAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("BoardController photoBoardList End..");

		return "board/photoEventBoardList";
	}

	// 이벤트게시판 Logic
	@RequestMapping(value = "/eventBoardList")
	public String eventBoardList(Board board, String currentPage, Model model) {
		log.info("BoardController eventBoardList Start!!");
		int bigCode = 0;
		// 분류 code 강제 지정
		int smallCode = 5;
		int userId = 1001;
		
		// smallCode를 이용해 countBoard를 설정
		int countBoard = boardService.boardCount(smallCode);
		
		// Paging 작업
		// Parameter board page 추가
		PhotoPaging page = new PhotoPaging(currentPage, countBoard);
		board.setStart(page.getStart());
		board.setEnd(page.getEnd());
		
		List<Board> eventAllList = boardService.getEventAllList(board);
		log.info("BoardController eventAllList size : {}", eventAllList.size());
		
		List<Banner> bannerHeader = bannerService.getHeaderBanner();
		List<Banner> bannerFooter = bannerService.getFooterBanner();		
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getTitle());
		log.info("FestivalController bannerHeader : {}", bannerHeader.get(0).getUrl());
		
		model.addAttribute("bannerHeader", bannerHeader);
		model.addAttribute("bannerFooter", bannerFooter); 

		if(eventAllList.size() != 0) {
			bigCode = eventAllList.get(0).getBig_code();
		} else {
			log.error("BoardController magazin 값이 없습니다.");
		}

		model.addAttribute("board", eventAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("userId", userId);
		
		log.info("BoardController eventBoardList End..");

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
		
		List<Board> revicewAllList = boardService.getReviewAllList(board);
		log.info("BoardController revicewAllList size : {}", revicewAllList.size());

		if(revicewAllList.size() != 0) {
			bigCode = revicewAllList.get(0).getBig_code();
		} else {
			log.error("BoardController magazin 값이 없습니다.");
		}

		model.addAttribute("board", revicewAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		
		log.info("BoardController reviewBoardList End..");

		return "board/integratedBoardList";
	}

	// 통합게시판 상세정보 Logic
	@RequestMapping(value = "/boardDetail")
	public String boardContent(int id, Integer userId, Model model) {

		log.info("BoardController boardContent boardId : {} ", id);
		log.info("BoardController boardContent userId : {} ", userId);

		Board boards = boardService.boardDetail(id);
		List<Tags> hashTags = tagsService.boardTagDetail(id);
		List<Board> comments = boardService.commentDetail(id);
		
		log.info("BoardController boardContent hashTags.size : {} ", hashTags.size());
		
		model.addAttribute("board", boards);
		model.addAttribute("comment", comments);
		model.addAttribute("hashTag", hashTags);
		model.addAttribute("userId", userId);

		return "board/boardDetail";

	}
	
	// 이벤트,포토게시판 상세정보 Logic
	@RequestMapping(value = "/photoEventBoardDetail")
	public String photoBoardDetail(int id, int userId, Model model) {

		log.info("BoardController boardContent boardId : {} ", id);
		log.info("BoardController boardContent userId : {} ", userId);

		Board boards = boardService.boardDetail(id);
		List<Tags> hashTags = tagsService.boardTagDetail(id);

		model.addAttribute("board", boards);
		model.addAttribute("hashTag", hashTags);
		model.addAttribute("userId", userId);

		return "board/photoEventBoardDetail"; 
	}

	// 통합게시판 수정 form Logic
	@RequestMapping(value = "/boardUpdateForm")
	public String boardUpdateForm(int id, int userId, Model model) {

		log.info("BoardController boardUpdateForm boardId : {} ", id);
		log.info("BoardController boardUpdateForm userId : {} ", userId);

		Board boards = boardService.boardDetail(id);

		model.addAttribute("board", boards);
		model.addAttribute("userId", userId);

		return "board/boardUpdateForm";
	}

	// 통합게시판 수정 Logic
	@PostMapping(value = "/boardUpdate")
	public String boardUpdate(Board board, int userId, MultipartFile file, Model model) {
		
		// value 확인용
		log.info("BoardController boardUpdate getFile_name : {}", board.getFile_name());
		log.info("BoardController boardUpdate getOriginalFilename : {}", file.getOriginalFilename().length());	
		
		// File upload Logic
        UUID uuid = UUID.randomUUID();
		String pathDB = null;
		String fileName = null;
		String realPath = null;
		int realName = file.getOriginalFilename().length();

		try {
			log.info("BoardController boardUpdate realName : {}", realName);			
			// 파일 값이 있으면 저장			
			if(realName > 0) {
				log.info("BoardController boardUpdate File Start!!");
				fileName = uuid + "_" + file.getOriginalFilename();

				pathDB = "..\\photos\\";

				realPath = System.getProperty("user.dir") + "\\src\\main\\webapp\\photos";

				File savaFile = new File(realPath, fileName);

				log.info("BannerController fileName : {}", fileName);
				log.info("BannerController pathDB : {}", pathDB);
				log.info("BannerController realPath : {}", realPath);
				log.info("BannerController savaFile : {}", savaFile);

				file.transferTo(savaFile);
				
			} else {
				log.info("BoardController boardUpdate File Save False! = Null!");		
			}			
	
		} catch (Exception e) {
			log.error("BoardController File upload error : {}", e.getMessage());
		} finally {
			log.info("BoardController boardUpdate File End..");
		}		


		// 게시물 생성 Logic(초기화)	
		int updateBoard = 0;
		// User ID 값이 있어야만 실행
		board.setUser_id(userId);
		
		if (board.getUser_id() > 0) {
			log.info("BoardController boardUpdate Start!!");
			log.info("BoardController boardUpdate realName : {}", realName);
			
			if(realName > 0) {
				log.info("BoardController boardUpdate image Start!!");
				// File명, 경로 setting
				board.setFile_name(fileName);
				board.setFile_path(pathDB);
				
				updateBoard = boardService.boardUpdate(board);
			} else {
				log.info("BoardController boardUpdate normal Start!!");
				updateBoard = boardService.boardUpdate(board);
			}
			
			model.addAttribute("board", updateBoard);
		}
		
		log.info("BoardController boardUpdate userId : {}", userId);
		
		model.addAttribute("userId", userId);

		return "forward:/boardDetail"; 
	}

	// 통합게시판 삭제 Logic
	@RequestMapping(value = "/boardDelete")
	public String boardDelete(int id, int userId, int smallCode) {
		// value 확인용
		log.info("BoardController boardDelete small_code : {}", smallCode);
		log.info("BoardController boardDelete id : {}", id);
		log.info("BoardController boardDelete userId : {}", userId);
		
		// 원본 File 삭제 Logic
		Board board = null;
		String path = null;
		String fileName = null;
		File deleteFile = null;
		
		try {
			log.info("BoardController boardDelete File start!");
			// DB에 저장 된 파일명 조회
			board = boardService.boardRead(id);
			
			// 실제 경로 
			path = System.getProperty("user.dir") + "\\src\\main\\webapp\\photos";
			
			// DB에 저장 된 파일명 가져오기
			fileName = board.getFile_name();
			
			// 구현체 생성(실  경로 + 파일명)
			deleteFile = new File(path, fileName);
			
			// 원본 File 삭제
			deleteFile.delete();
		} catch (Exception e) {
			log.error("BoardController boardDelete File : {}", e.getMessage());
		} finally {
			log.info("BoardController boardDelete File End..");
		}

		// DB 삭제 Logic
		String redirectURL = "";	
		int tagDeleteResult = 0;
		
		try {
		 	log.info("BoardController boardDelete Start!!");
		 	
		 	// BoardTags 선 삭제
		 	tagDeleteResult = tagsService.boardTagDelete(id);
		 	
		 	// BoardTags 선 삭제 후 결과값에 따른 Board 삭제
		 	if(tagDeleteResult > 0 || tagDeleteResult == 0) {
			 	boardService.boardDelete(id);
		 	}
		 	
		 	// 게시판 분류와 userId 로 redirect 경로 지정
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
		 	
		} catch (Exception e) {
			log.error("BoardController boardDelete error : {}", e.getMessage());
		} finally {
			
		 	log.info("BoardController boardDelete End..");
		}
		// 결과값에 따른 경로 이동
		return redirectURL;
	}

	// review 게시물 생성 form Logic
	@RequestMapping(value = "/reviewBoardInsertForm")
	public String reviewBoardInsertForm(String userId, String bigCode, String smallCode, 
								  		String contentId, String currentPage, String commonCode, Model model) {

		log.info("BoardController reviewBoardInsertForm start!");
		log.info("BoardController reviewBoardInsertForm userId : {}", userId);
		log.info("BoardController reviewBoardInsertForm bigCode : {}", bigCode);
		log.info("BoardController reviewBoardInsertForm smallCode : {}", smallCode);
		log.info("BoardController reviewBoardInsertForm contentId : {}", contentId);
		log.info("BoardController reviewBoardInsertForm currentPage : {}", currentPage);
		log.info("BoardController reviewBoardInsertForm commonCode : {}", commonCode);

		model.addAttribute("userId", userId);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("contentId", contentId);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("commonCode", commonCode);
		
		log.info("BoardController reviewBoardInsertForm end!");

		return "board/reviewBoardInsertForm";
	}

	// review 게시물 생성  Logic
	@RequestMapping(value = "/reviewBoardInsert")
	public String reviewBoardInsert(Board board, Model model) {

		log.info("BoardController reviewBoardInsert userId : {}", board.getUser_id());
		log.info("BoardController reviewBoardInsert bigCode : {}", board.getBig_code());
		log.info("BoardController reviewBoardInsert smallCode : {}", board.getSmall_code());
		log.info("BoardController reviewBoardInsert contentId : {}", board.getContent_id());
		log.info("BoardController reviewBoardInsert score : {}", board.getScore());

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
			return "forward:/reviewBoardInsertForm";
		}
	}
	
	// 통합게시물 생성 form Logic	
	@RequestMapping(value = "/integratedBoardInsertForm")
	public String integratedBoardInsertForm(String userId, String bigCode, 
											String smallCode,Tags tags, Model model) {
		
		log.info("BoardController integratedBoardInsertForm start!");
		log.info("BoardController integratedBoardInsertForm userId : {}", userId);
		log.info("BoardController integratedBoardInsertForm bigCode : {}", bigCode);
		log.info("BoardController integratedBoardInsertForm smallCode : {}", smallCode);

		List<Tags> tagsAll = tagsService.listTags(tags);		
		
		model.addAttribute("userId", userId);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		model.addAttribute("tagList", tagsAll);
		
		log.info("BoardController integratedBoardInsertForm end!");
		
		return "board/integratedBoardInsertForm";
	}
	
	// 통합게시판 생성 Logic
	@RequestMapping(value = "/integratedboardInsert")
	public String integratedboardInsert(Board board, Tags tags, MultipartFile file, 
										String[] tagsList, Model model) {
		// value 확인용
		log.info("BoardController integratedboardInsert Start!!");
		log.info("BoardController integratedboardInsert userId : {}", board.getUser_id());
		log.info("BoardController integratedboardInsert bigCode : {}", board.getBig_code());
		log.info("BoardController integratedboardInsert smallCode : {}", board.getSmall_code());
		log.info("BoardController integratedboardInsert tagsList : {}", tagsList.length);
		
		// File upload Logic
        UUID uuid = UUID.randomUUID();
		String pathDB = null;
		String fileName = null;
		String realPath = null;
		File savaFile = null;

		try {
			log.info("BoardController integratedboardInsert File Start!!");
			fileName = uuid + "_" + file.getOriginalFilename();

			pathDB = "..\\photos\\";

			realPath = System.getProperty("user.dir") + "\\src\\main\\webapp\\photos";

			savaFile = new File(realPath, fileName);

			log.info("BannerController fileName : {}", fileName);
			log.info("BannerController pathDB : {}", pathDB);
			log.info("BannerController realPath : {}", realPath);
			log.info("BannerController savaFile : {}", savaFile);

			file.transferTo(savaFile);
		} catch (Exception e) {
			log.error("BoardController File upload error : {}", e.getMessage());
		} finally {
			log.info("BoardController integratedboardInsert File End..");
		}
		
		// 게시물 생성 Logic
		String redirectURL = "";

		// User ID 값이 있어야만 실행
		if (board.getUser_id() > 0) {

			// File명, 경로 setting
			board.setFile_name(fileName);
			board.setFile_path(pathDB);

			int insertBoard = boardService.boardInsert(board);
			
			int boardId = board.getId();
			
			// hashTag 값이 있거나 null 아니면 반복문으로 insert query
	        if (tagsList != null && tagsList.length > 0) {
	            for (String i : tagsList) {
	                if (!i.isEmpty()) { // 빈 문자열이 아닌 경우에만 처리
	                    tags.setTag_id(Integer.parseInt(i));
	                    tags.setBoard_id(boardId);
	                    
	                    tagsService.boardTagsInsert(tags);
	                }
	            }
	        }	    

			// 게시물 생성 후 Page Handling
			if (insertBoard > 0 && board.getSmall_code() == 1) {
				if (board.getUser_id() == 1) {
					redirectURL = "redirect:/admin/notice/notice";
				} else {
					redirectURL = "forward:/noticBoardList";
				}

			} else if (insertBoard > 0 && board.getSmall_code() == 2) {
				if (board.getUser_id() == 1) {
					redirectURL = "redirect:/admin/community/magazin";
				} else {
					redirectURL = "forward:/magazinBoardList";
				}

			} else if (insertBoard > 0 && board.getSmall_code() == 3) {
				if (board.getUser_id() == 1) {
					redirectURL = "redirect:/admin/community/board";
				} else {
					redirectURL = "forward:/freeBoardList";					
				}

			} else if (insertBoard > 0 && board.getSmall_code() == 4) {
				redirectURL = "forward:/photoBoardList";

			} else if (insertBoard > 0 && board.getSmall_code() == 5) {
				if (board.getUser_id() == 1) {
					redirectURL = "redirect:/admin/notice/event";
				} else {
					redirectURL = "forward:/eventBoardList";					
				}

			} else if (insertBoard > 0 && board.getSmall_code() == 6) {
				if (board.getUser_id() == 1) {
					redirectURL = "redirect:/admin/community/review";
				} else {
					redirectURL = "forward:/";
				}
				
			} else {
				model.addAttribute("msg", "글쓰기 실패!!, 다시 입력해주세요.");
				redirectURL = "forward:/integratedBoardInsertForm";
			}

		} else {
			model.addAttribute("msg", "글쓰기 실패!!, 회원ID가 일치하지 않습니다. 관리자에게 문의해주세요.");
			redirectURL = "forward:/integratedBoardInsertForm";
		}
		
		log.info("BoardController integratedboardInsert redirectURL :{}", redirectURL);

		log.info("BoardController integratedboardInsert End..");

		return redirectURL;
	}
	
	// 댓글 기능 form Logic
	@RequestMapping(value = "/commentInsertForm")
	public String commentInsertForm(int id, int userId, Model model) {

		log.info("BoardController commentInsertForm boardId : {} ", id);
		log.info("BoardController commentInsertForm userId : {} ", userId);

		Board boards = boardService.boardDetail(id);
		
		log.info("BoardController commentInsertForm getComment_group_id : {} ", boards.getComment_group_id());
		log.info("BoardController commentInsertForm getComment_step : {} ", boards.getComment_step());
		log.info("BoardController commentInsertForm getComment_indent : {} ", boards.getComment_indent());

		model.addAttribute("board", boards);
		model.addAttribute("userId", userId);

		return "board/commentInsertForm";
	}
	
	// 댓글 기능 생성 Logic
	@RequestMapping(value = "/commentInsert")
	public String commentInser(Board board , Model model) {
		
		log.info("BoardController commentInser boardId : {} ", board.getId());
		log.info("BoardController commentInser userId : {} ", board.getUser_id());

		boardService.commentInsert(board);
		

		model.addAttribute("id", board.getId());
		model.addAttribute("userId", board.getUser_id());

		return "forward:/boardDetail";
	}
	
	// 게시판 신고기능 -송환
	@GetMapping("/reportBoardFoam")
	public String reportBoard(int boardId, Model model) {
		log.info("boardId->" + boardId);

		try {
			Board reportBoard = boardService.boardDetail(boardId);
			
			int userid = us.getLoggedInId();
			
			model.addAttribute("board", reportBoard);
			model.addAttribute("userId", userid);
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
			log.info("[{}]{}:{}", transactionId, "admin festivalDetail", "start");
			
			int result = res.boardReportUpdate(report);
			
			if (result == 0) {
				message = "이미 신고한 게시글입니다.";
				
			} else if (result == 1) {
				message = "신고완료";
			}
			
			model.addAttribute("message", message);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin detailExperience", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin detailExperience", "end");
		}
		return "board/boardReportClose";
	}
	
	// BetaPage
	@RequestMapping(value = "/betaPage")
	public String betaPage(Board board, String currentPage, Model model) {			
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
		
		List<Board> revicewAllList = boardService.getReviewAllList(board);
		log.info("BoardController revicewAllList size : {}", revicewAllList.size());

		if(revicewAllList.size() != 0) {
			bigCode = revicewAllList.get(0).getBig_code();
		} else {
			log.error("BoardController magazin 값이 없습니다.");
		}

		model.addAttribute("board", revicewAllList);
		model.addAttribute("page", page);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);
		
		log.info("BoardController reviewBoardList End..");

		return "board/betaPage";
	}
	
	// BetaPage
	@RequestMapping(value = "/betaListPage")
	public String betaListPage(Board board, String currentPage, Model model) {			

		return "board/betaListPage";
	}
} 
