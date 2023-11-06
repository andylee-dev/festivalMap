package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
}

