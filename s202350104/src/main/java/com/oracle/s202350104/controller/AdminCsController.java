package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Qna;
import com.oracle.s202350104.model.Report;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PagingList;
import com.oracle.s202350104.service.QnaListService;
import com.oracle.s202350104.service.ReportService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AdminCsController {
	
	private final ReportService res;
	private final QnaListService qs;
	
	@RequestMapping(value = "admin/cs/report")
	public String report(Model model) {
		List<Report> listReport = res.listReport();
		model.addAttribute("listReport",listReport);
		return "admin/cs/report";
	}
	
	@RequestMapping(value = "admin/cs/reportDetail")
	public String reportDetail(int boardId, Model model) {
		Report boardDetail = res.boardDetail(boardId);
		List<Report> reportDetail = res.reportDetail(boardId);
		model.addAttribute("boardDetail", boardDetail);
		model.addAttribute("reportDetail", reportDetail);
		return "admin/cs/reportDetail";
	}
	
	@RequestMapping(value = "admin/cs/reportBoardUpdate")
	public String reportBoardUpdate(int id, Model model ) {
		int boardUpdate = res.reportBoardUpdate(id);
		
		return "redirect:report";
	}
	
	@RequestMapping(value = "admin/cs/reportUpdate")
	public String reportUpdate(int id, Model model ) {
		int reportUpdate = res.reportUpdate(id);
		
		return "redirect:report";		
	}
	@RequestMapping(value = "admin/cs/qna")
	public String ana(Qna qna, String currentPage, Model model ) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "admin Qna", "start");
			int totalQnaList = qs.totalQnaList();
			log.info("totalQnaList=>"+totalQnaList);
			
			PagingList page = new PagingList(totalQnaList, currentPage);
			
			qna.setStart(page.getStart());
			qna.setEnd(page.getEnd());
		
			List<Qna> listQnaList = qs.listQnaList(qna);
			log.info("listQnaList=>"+listQnaList.size());
			model.addAttribute("totalQnaList",totalQnaList);
			model.addAttribute("listQnaList",listQnaList);
			model.addAttribute("page",page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "admin Qna", e.getMessage());
		}finally { 
			log.info("[{}]{}:{}",transactionId, "admin Qna", "end");
		}	
			
		return "admin/cs/qna";
	}
	@RequestMapping(value = "admin/cs/qnaUpdate")
	public String qnaUpdate(int user_id, int id, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "qnaUpdate", "start");
			Qna qna = qs.selectQna(user_id, id);
			model.addAttribute("qna", qna);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "qnaUpdate", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "qnaUpdate", "end");
		}	
			return "admin/cs/qnaUpdate";
	}
	
	@RequestMapping(value = "admin/cs/qnaUpdateResult")
	public String qnaUpdateResult(Qna qna, Model model) {
		UUID transactionId = UUID.randomUUID();
		int result = 0;
		try {
			log.info("[{}]{}:{}",transactionId, "qnaUpdateResult", "start");
			result = qs.adminUpdateQna(qna);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "qnaUpdateResult", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "qnaUpdateResult", "end");
		}	
			if(result > 0) {
				return "redirect:qna";
			} else {
				model.addAttribute("user_id", qna.getUser_id());
				model.addAttribute("id", qna.getId());
				model.addAttribute("msg","등록에 실패하였습니다.");
			return "forward:qnaUpdate";
			}
	}
	@ResponseBody
	@RequestMapping(value = "admin/cs/qnaDelete")
	public String deleteQna(Qna qna) {
		log.info("delete 실행");
		int result = qs.deleteQna(qna.getId(), qna.getUser_id());
		String rsultStr = Integer.toString(result);
		return rsultStr;
	}
	
}
