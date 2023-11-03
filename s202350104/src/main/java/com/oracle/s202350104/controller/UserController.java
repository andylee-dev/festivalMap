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
@RequestMapping(value = "/user")
public class UserController {
	
	private final QnaListService qs;

	@RequestMapping(value = "/")
	public String userList() {
		return "user";
	}
		
	@RequestMapping(value = "/myPage")
	public String myPage() {
		return "user/myPage/index";
	}
	
	@RequestMapping(value = "/myPage/myLike")
	public String myLike() {
		return "user/myPage/myLike";
	}
	
	@RequestMapping(value = "/myPage/QnaDetail")
	public String QnaDetail() {
		return "user/myPage/QnaDetail";
	}

	@RequestMapping(value = "/myPage/QnaForm")
	public String QnaForm() {
		return "user/myPage/QnaForm";
	}
	
	@RequestMapping(value = "/myPage/QnaList")
	public String QnaList(Qna qna , String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "QnaList", "start");
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
			log.error("[{}]{}:{}",transactionId,  "QnaList", e.getMessage());
		}finally { 
			log.info("[{}]{}:{}",transactionId, "QnaList", "end");
		}	
		return "user/myPage/myQnaList";
	}
	
	@RequestMapping(value = "/myPage/myTag")
	public String myTag() {
		return "user/myPage/myTag";
	}

	@RequestMapping(value = "/myPage/myPost")
	public String myPost() {
		return "user/myPage/myPost";
	}

	@RequestMapping(value = "/bizPage")
	public String bizPage() {
		return "user/bizPage/index";
	}

	@RequestMapping(value = "/bizPage/content")
	public String bizContent() {
		return "user/bizPage/bizContent";
	}
	@RequestMapping(value = "/bizPage/qna")
	public String bizQna() {
		return "user/bizPage/bizQna";
	}

}
