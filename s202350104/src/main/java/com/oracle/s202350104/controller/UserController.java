package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.eclipse.jdt.internal.compiler.flow.FinallyFlowContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.Qna;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.QnaListService;
import com.oracle.s202350104.service.TagsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class UserController {
	
	private final QnaListService qs;
	private final TagsService ts;

	@RequestMapping(value = "user")
	public String userList() {
		return "user";
	}
	
	@RequestMapping(value = "user/join")
	public String userJoin() {
		return "auth/join";
	}
	
	@RequestMapping(value = "user/joinForm")
	public String userJoinForm(Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "userJoinForm", "start");
			List<Tags> listTags = ts.listTagsAll();
			model.addAttribute("listTags", listTags);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "userJoinForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "userJoinForm", "end");
		}
		return "auth/joinForm";
	}
	
	@RequestMapping(value = "user/bizJoinForm")
	public String bizJoinForm() {
		return "auth/bizJoinForm";
	}
	
	@RequestMapping(value = "user/login")
	public String userLogin() {
		return "auth/login";
	}
	
	@RequestMapping(value = "user/idSearch")
	public String userIdSearch() {
		return "auth/idSearch";
	}
	
	@RequestMapping(value = "user/idSearchResult")
	public String idSearchResult() {
		return "auth/idSearchResult";
	}
	
	@RequestMapping(value = "user/passwordSearch")
	public String userPwSearch() {
		return "auth/passwordSearch";
	}
	
	@RequestMapping(value = "user/passwordSearchResult")
	public String pwSearchResult() {
		return "auth/passwordSearchResult";
	}
	
	@RequestMapping(value = "user/mypage/myInfo")
	public String myInfo() {
		return "user/mypage/myInfo";
	}
	
	@RequestMapping(value = "user/mypage/myLike")
	public String myLike() {
		return "user/mypage/myLike";
	}
	
	@RequestMapping(value = "user/mypage/myPoint")
	public String myPoint() {
		return "user/mypage/myPoint";
	}
	
	@RequestMapping(value = "user/mypage/qnaDetail")
	public String qnaDetail() {
		return "user/mypage/qnaDetail";
	}

	@RequestMapping(value = "user/mypage/qnaForm")
	public String qnaForm() {
		return "user/mypage/qnaForm";
	}
	
	@RequestMapping(value = "user/myPage/qnaList")
	public String qnaList(Qna qna , String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "qnaList", "start");
			int totalQnaList = qs.totalQnaList();
			log.info("totalQnaList=>"+totalQnaList);
		
			Paging page = new Paging(totalQnaList, currentPage);
		
			qna.setStart(page.getStart());
			qna.setEnd(page.getEnd());
		
			List<Qna> listQnaList = qs.listQnaList(qna);
			log.info("listQnaList=>"+listQnaList.size());
			model.addAttribute("totalQnaList",totalQnaList);
			model.addAttribute("listQnaList",listQnaList);
			model.addAttribute("page",page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "qnaList", e.getMessage());
		}finally { 
			log.info("[{}]{}:{}",transactionId, "qnaList", "end");
		}	
		return "user/myPage/myQnaList";
	}
	
	@RequestMapping(value = "user/mypage/myTag")
	public String myTag() {
		return "user/mypage/myTag";
	}

}
