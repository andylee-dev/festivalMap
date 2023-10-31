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
	
	@RequestMapping(value = "/admin/cs/report")
	public String report(Model model) {
		List<Report> listReport = res.listReport();
		model.addAttribute("listReport",listReport);
		return "admin/cs/report";
	}

}

