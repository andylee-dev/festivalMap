package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Report;
import com.oracle.s202350104.service.ReportService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AdminCsController {
	
	private final ReportService res;
	
	@RequestMapping(value = "admin/cs/report")
	public String report(Model model) {
		List<Report> listReport = res.listReport();
		model.addAttribute("listReport",listReport);
		return "admin/cs/report";
	}
	
	@RequestMapping(value = "admin/cs/reportDetail")
	public String reportDetail(int board_id, Model model) {
		Report boardDetail = res.boardDetail(board_id);
		List<Report> reportDetail = res.reportDetail(board_id);
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
}

