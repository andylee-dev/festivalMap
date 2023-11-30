package com.oracle.s202350104.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;

import javax.servlet.http.HttpServletResponse;

import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.server.ResponseStatusException;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.PointHistory;
import com.oracle.s202350104.model.Qna;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.model.Favorite;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.CommonCodeService;
import com.oracle.s202350104.service.ContentSerivce;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PagingList;
import com.oracle.s202350104.service.PointHistoryService;
import com.oracle.s202350104.service.QnaListService;
import com.oracle.s202350104.service.TagsService;
import com.oracle.s202350104.service.user.UserService;
import com.oracle.s202350104.service.user.oAuthService;
import com.oracle.s202350104.service.FavoriteService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/user")
public class UserController {

	private final QnaListService qs;
	private final UserService us;
	private final CommonCodeService cs;
	private final TagsService ts;
	private final FavoriteService fs;
	private final BoardService boardService;
	private final PointHistoryService pointHistoryService;
	private final ContentSerivce contentService;

	@RequestMapping(value = "user")
	public String userList() {
		return "user";
	}

	@RequestMapping(value = "myPage")
	public String myPage(Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "myPage", "start");
			int userId = us.getLoggedInId();
			log.info("userId:{}/ userRole:{}", userId, us.getLoggedInUserRole());
			Optional<Users> user = us.getUserById(userId);
			if (user.isPresent()) {
				model.addAttribute("user", user.get());
				List<PointHistory> pointHistoryList = pointHistoryService.getPointHistoryByUserId(userId);
				log.info("pointHistoryList:{}", pointHistoryList);
				model.addAttribute("pointHistoryList", pointHistoryList);

			}
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "myPage", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "myPage", "end");
		}
		return "user/myPage/index";

	}

	@RequestMapping(value = "myPage/myLike")
	public String myLike(String currentPage, Model model, Favorite favorite) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "myLike", "Start");
			int user_id = us.getLoggedInId();
			favorite.setUser_id(user_id);

			int totalMyLikeList = fs.totalFavorite1(favorite);

			Paging page = new Paging(totalMyLikeList, currentPage);
			favorite.setStart(page.getStart());
			favorite.setEnd(page.getEnd());

			log.info("page.getStart -> {}", page.getStart());
			List<Favorite> myLikeList = fs.listFavorite(favorite);
			;

			model.addAttribute("totalMyLikeList", totalMyLikeList);
			model.addAttribute("page", page);
			model.addAttribute("myLikeList", myLikeList);
			model.addAttribute("currentPage", currentPage);

		} catch (Exception e) {
			log.error("UserController myLike Exception -> " + e.getMessage());

		} finally {
			log.info("[{}]{}:{}", transactionId, "myLike", "End");
		}
		return "user/myPage/myLike";
	}

	@RequestMapping(value = "myPage/myLikeDelete")
	public String deleteCofirm(Integer content_id, Favorite favorite) {
		UUID transactionId = UUID.randomUUID();

		try {
			int user_id = us.getLoggedInId();
			log.info("[{}]{}:{}", transactionId, "UserController deleteConfirm", "Start");
			log.info("content_id ->" + content_id);
			favorite.setUser_id(user_id);
			int result = fs.deleteFavorite(favorite);

		} catch (Exception e) {
			log.error("UserController myLike deleteConfirm Exception ->" + e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "UserController deleteConfirm", "End");
		}

		return "redirect:/user/myPage/myLike";
	}

	// 나의 태그 관리 페이지로 이동
	@RequestMapping(value = "myPage/myTag")
	public String myTag(Model model) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "UserController myTag", "Start");
			int userId = us.getLoggedInId();
			log.info("userId:{}/ userRole:{}", userId, us.getLoggedInUserRole());
			List<Tags> listMyTags = ts.searchUserTagsOne(userId);
			Tags tags = new Tags();
			List<Tags> listAllTags = ts.listTags(tags);

			model.addAttribute("listMyTags", listMyTags);
			model.addAttribute("listAllTags", listAllTags);
			model.addAttribute("userId", userId);
		} catch (Exception e) {
			log.error("UserController myTag Exception ->" + e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "UserController myTag", "End");
		}
		return "user/myPage/myTag";
	}

	// 태그를 수정하고 그 결과에 따라 메세지를 반환(AJAX 연결)
	@ResponseBody
	@RequestMapping(value = "myPage/userTagsUpdate")
	public String userTagsUpdate(@RequestParam(value = "tagId[]", required = false) int[] finalTags, int userId,
			Model model) {
		UUID transactionId = UUID.randomUUID();
		String str = "";

		try {
			log.info("[{}]{}:{}", transactionId, "UserController userTagsUpdate", "Start");
			int result = ts.updateUserTags(userId, finalTags);
			// update결과에 따라 다른 메세지 반환
			if (result == 1) {
				str = "태그 수정이 성공적으로 완료되었습니다.";
			} else {
				str = "태그 수정에 실패하였습니다.";
			}
			log.info("finalTags" + finalTags.toString());
			log.info("userId" + userId);
		} catch (Exception e) {
			log.error("UserController userTagsUpdate Exception ->" + e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "UserController userTagsUpdate", "End");
		}

		return str;
	}

	@RequestMapping(value = "bizPage")
	public String bizPage(Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "bizPage", "Start");
			int userId = us.getLoggedInId();
			log.info("userId:{}/ userRole:{}", userId, us.getLoggedInUserRole());
			Optional<Users> user = us.getUserById(userId);
			if (user.isPresent()) {
				model.addAttribute("user", user.get());
			}

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "bizPage", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "bizPage", "End");
		}
		return "user/bizPage/index";
	}

	@RequestMapping(value = "bizPage/content")
	public String bizContent(Model model, Contents content, String currentPage) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "bizContent", "Start");

			Contents contents = new Contents();
			contents.setUser_id(String.valueOf(us.getLoggedInId()));

			int totalCotnents = contentService.getTotalSearchCount(contents);
			log.info("totalCotnents:{}", totalCotnents);

			Paging page = new Paging(totalCotnents, currentPage);
			content.setStart(page.getStart());
			content.setEnd(page.getEnd());

			List<Contents> contentsList = contentService.getSearchContentsList(contents);
			if (contentsList == null) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "컨텐츠 리스트가 존재하지 않습니다.");
			}
			model.addAttribute("page", page);
			model.addAttribute("contentsList", contentsList);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "bizContent", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "bizContent", "End");
		}

		return "user/bizPage/bizContentList";
	}

	@RequestMapping(value = "bizPage/addContent")
	public String bizAddContent(Model model) {
		Tags tag = new Tags();

		List<CommonCodes> listCodes = cs.listCommonCode();
		List<Tags> listAllTags = ts.listTags(tag);
		// 로그인한 아이디 저장(신청자 아이디)
		int userId = us.getLoggedInId();
		
		model.addAttribute("listAllTags", listAllTags);
		model.addAttribute("listCodes", listCodes);
		model.addAttribute("userId", userId);

		return "user/bizPage/bizContentInsert";
	}

	@RequestMapping(value = "bizPage/qna")
	public String bizQna() {
		return "user/bizPage/bizQnaList";
	}

	@RequestMapping(value = "myPage/myPost")
	public String myPost(Board board, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		log.info("[{}]{}:{}", transactionId, "myPost", "start");
		
		/* 초기 유저 ID setting */
		int userId = us.getLoggedInId();
		board.setUser_id(userId);
		board.setIs_deleted("0");
		
		/* 멤버변수 선언을 해서 각각 paging 처리 */ 
		int countBoard = 0;
		Paging pageBoard = null;
		Paging pageReview = null;
		
		List<Board> oneBoardList = null;
		List<Board> oneReviewList = null;
		
		/* userId값으로 자유게시글 먼저 선점  */
		if(userId > 0) {			
			/* small_code & userId 값으로 전체 게시글 count */
			board.setSmall_code(3); // 분류 code 강제 지정			
			countBoard = boardService.boardCount(board);
			log.info("userController countBoard : {}", countBoard);
			
			pageBoard = new Paging(countBoard, currentPage);
			board.setStart(pageBoard.getStart());
			board.setEnd(pageBoard.getEnd());
			
			oneBoardList = boardService.getBoardOneList(board);
			
			model.addAttribute("searchOption", board);
			model.addAttribute("smallCode", board.getSmall_code());
			model.addAttribute("countBoard", countBoard);
			model.addAttribute("pageBoard", pageBoard);
			model.addAttribute("oneBoardList", oneBoardList);
			
			/* 자유게시글 size로 리뷰게시글 핸들링  */
			if(oneBoardList.size() > 0) {
				/* small_code & userId 값으로 전체 게시글 count */
				board.setSmall_code(6); // 분류 code 강제 지정
				countBoard = boardService.boardCount(board);
				log.info("userController countReview : {}", countBoard);
				
				pageReview = new Paging(countBoard, currentPage);
				board.setStart(pageReview.getStart());
				board.setEnd(pageReview.getEnd());
				
				oneReviewList = boardService.getReviewOneList(board);
				
				model.addAttribute("searchOption", board);
				model.addAttribute("smallCode", board.getSmall_code());
				model.addAttribute("countBoard", countBoard);
				model.addAttribute("pageReview", pageReview);
				model.addAttribute("oneReviewList", oneReviewList);
			}			
		}
		
		return "user/myPage/myPost";
	}

	@RequestMapping(value = "myPage/myPostDetail")
	public String myPostDetail(int id, Integer userId, Model model) {
		UUID transactionId = UUID.randomUUID();

		log.info("[{}]{}:{}", transactionId, "myPost", "start");

		Optional<Users> loginUser = null;

		if (userId > 0) {
			loginUser = us.getUserById(userId);
			log.info("userController loginUser : {} ", loginUser);

			if (loginUser.isPresent()) {
				model.addAttribute("loginUser", loginUser.get());
			}
		}

		Board boards = boardService.boardDetail(id);
		// List<Tags> hashTags = tagsService.boardTagDetail(id);

		// log.info("AdminCommunityController boardContent hashTags.size : {} ",
		// hashTags.size());

		model.addAttribute("board", boards);
		// model.addAttribute("hashTag", hashTags);
		model.addAttribute("userId", userId);

		return "user/myPage/myPostDetail";
	}
	
	// 통합게시판 삭제 Logic(New, status로 삭제 여부)
	@RequestMapping(value = "myPage/myPostDelete")
	public String myPostDelete(int id, Model model) {
		// value 확인용
		log.info("userController myPostDelete id : {}", id);
		
		// 복원 Logic
		String redirectURL = "";
		int deleteDelete = 0;
		
		try {
		 	log.info("userController myPostDelete Start!!");
			
		 	deleteDelete = boardService.boardDeleteNew(id);
		 	
		 	// 결과값에 따라 redirect 경로 지정
			if (deleteDelete > 0) {
				redirectURL = "redirect:/user/myPage/myPost";
				
			} else {
				model.addAttribute("msg", "복원 실패!!, 관리자에게 문의해주세요.");
				redirectURL = "redirect:/user/myPage/myPost";
			}
			
		} catch (Exception e) {
			log.error("userController myPostDelete errer : {}", e.getMessage());
		}
		
		// 결과값에 따른 경로 이동
		return redirectURL;
	}

	@RequestMapping(value = "myPage/qnaDetail")
	public String qnaDetail(int user_id, int id, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "qnaDetail", "start");

			Qna qna = qs.detailQna(user_id, id);
			model.addAttribute("qna", qna);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "qnaDetail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "qnaDetail", "end");
		}
		return "user/myPage/myQnaDetail";
	}

	@RequestMapping(value = "myPage/insertQnaForm")
	public String insertQnaForm(Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "qnaInsert", "start");
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "qnaInsert", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "qnaInsert", "end");
		}
		return "user/myPage/myQnaInsertForm";
	}

	@RequestMapping(value = "myPage/insertQnaResult")
	public String insertQnaResult(Qna qna, Model model) {
		UUID transactionId = UUID.randomUUID();
		Optional<Users> user = null;
		int result = 0;
		try {
			log.info("[{}]{}:{}", transactionId, "qnaInsertResult", "start");
			int userId = us.getLoggedInId();
			qna.setUser_id(userId);
			user = us.getUserById(userId);
			result = qs.insertQna(qna);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "qnaInsertResult", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "qnaInsertResult", "end");
		}
		if (result > 0) {
			return "redirect:qnaList";
		} else {
			model.addAttribute("msg", "등록에 실패하였습니다.");
			return "forward:insertQnaForm";
		}
	}

	@RequestMapping(value = "myPage/updateQnaForm")
	public String updateQnaForm(int user_id, int id, Model model) {
		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "updateQnaForm", "start");
			Qna qna = qs.selectQna(user_id, id);
			model.addAttribute("qna", qna);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "updateQnaForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "updateQnaForm", "end");
		}
		return "user/myPage/myQnaUpdateForm";
	}

	@RequestMapping(value = "myPage/updateQnaResult")
	public String updateQnaResult(Qna qna, Model model) {
		UUID transactionId = UUID.randomUUID();
		int result = 0;
		try {
			log.info("[{}]{}:{}", transactionId, "updateQnaResult", "start");
			result = qs.updateQna(qna);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "updateQnaResult", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "updateQnaResult", "end");
		}
		if (result > 0) {
			return "redirect:qnaList";
		} else {
			model.addAttribute("user_id", qna.getUser_id());
			model.addAttribute("id", qna.getId());
			model.addAttribute("msg", "등록에 실패하였습니다.");
			return "forward:updateQnaForm";
		}
	}

	@RequestMapping(value = "myPage/qnaList")
	public String qnaList(Qna qna, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		Optional<Users> user = null;
		try {
			log.info("[{}]{}:{}", transactionId, "qnaList", "start");

			int userId = us.getLoggedInId();
			qna.setUser_id(userId);
			int small_code = qna.getSmall_code();
			user = us.getUserById(userId);
			int totalQnaList = qs.totalQnaList(qna);

			PagingList page = new PagingList(totalQnaList, currentPage);
			qna.setStart(page.getStart());
			qna.setEnd(page.getEnd());

			log.info("qna list" + totalQnaList);
			log.info("startPage" + page.getStartPage());
			log.info("startDate" + qna.getStartDate());
			log.info("endDate" + qna.getEndDate());

			List<Qna> listQnaList = qs.listQnaList(qna);

			model.addAttribute("searchOption", qna);
			model.addAttribute("small_code", small_code);
			model.addAttribute("totalQnaList", totalQnaList);
			model.addAttribute("listQnaList", listQnaList);
			model.addAttribute("page", page);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "qnaList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "qnaList", "end");
		}
		if (user.isPresent() && user.get().getSmall_code() == 2) {
			return "user/myPage/myQnaList";
		} else if (user.isPresent() && user.get().getSmall_code() == 3) {
			return "user/bizPage/bizQnaList";

		} else {
			return "home";

		}
	}

	@ResponseBody
	@RequestMapping(value = "/deleteQnaPro")
	public String deleteQna(Qna qna) {
		log.info("delete 실행");
		int result = qs.deleteQna(qna.getId(), qna.getUser_id());
		String resultStr = Integer.toString(result);
		return resultStr;
	}

	@GetMapping("/kakao")
	public void getKakaoAuthUrl(HttpServletResponse response) throws IOException {
		response.sendRedirect(kakaoOauth.responseUrl());
	}

	@GetMapping("login/kakao")
	public ResponseEntity<String> kakaoLogin(@RequestParam(name = "code") String code) throws IOException {
		log.info("카카오 API 서버 code : " + code);
		return oAuthService.kakaoLogin(code);
	}

}