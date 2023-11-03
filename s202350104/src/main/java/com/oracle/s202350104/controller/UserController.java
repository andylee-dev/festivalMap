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

	@RequestMapping(value = "user")
	public String userList() {
		return "user";
	}

	@RequestMapping(value = "myPage")
	public String myPage() {
		return "user/myPage/index";

	}
	
	@RequestMapping(value = "myPage/myLike")
	public String myLike() {
		return "user/myPage/myLike";
	}
	

	@RequestMapping(value = "myPage/qnaDetail")
	public String qnaDetail(int user_id,int id, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "qnaDetail", "start");
			
			Qna qna = qs.detailQna(user_id, id);
			model.addAttribute("qna", qna);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "qnaDetail", e.getMessage());
		}finally { 
			log.info("[{}]{}:{}",transactionId, "qnaDetail", "end");
		}		
		return "user/myPage/myQnaDetail";
	}

	@RequestMapping(value = "myPage/qnaForm")
	public String qnaForm() {
		
		return "user/myPage/myQnaForm";
	}
	
	@RequestMapping(value = "myPage/qnaList")
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
	
	@RequestMapping(value = "myPage/myTag")
	public String myTag() {
		return "user/myPage/myTag";
	}

}
