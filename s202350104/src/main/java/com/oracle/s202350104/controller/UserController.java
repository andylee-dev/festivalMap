package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Qna;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.QnaListService;

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
	
	@RequestMapping(value = "myPage/myTag")
	public String myTag() {
		return "user/myPage/myTag";
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
	@RequestMapping(value = "myPage/insertQnaForm")
	public String insertQnaForm(Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "qnaInsert", "start");
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "qnaInsert", e.getMessage());
		}finally { 
			log.info("[{}]{}:{}",transactionId, "qnaInsert", "end");
		}
		return "user/myPage/myQnaInsertForm";
	}

	@RequestMapping(value = "myPage/insertQnaResult")
	public String insertQnaResult(Qna qna, Model model) {
		UUID transactionId = UUID.randomUUID();
		int result = 0;
		try {
			log.info("[{}]{}:{}",transactionId, "qnaInsertResult", "start");
			result = qs.insertQna(qna);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "qnaInsertResult", e.getMessage());
		}finally { 
			log.info("[{}]{}:{}",transactionId, "qnaInsertResult", "end");
		}
		if(result > 0) {
			return "redirect:qnalist";	
		}else {
			model.addAttribute("msg","등록에 실패하였습니다.");
			return "forward:insertQnaForm";
		}
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
	

	
	@RequestMapping(value="bizPage")
	public String bizPage() {
		return "user/bizPage/index";
	}

}
