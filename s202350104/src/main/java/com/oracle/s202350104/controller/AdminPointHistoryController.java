package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.PointHistory;
import com.oracle.s202350104.service.PointHistoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AdminPointHistoryController {
	
	private final PointHistoryService phs;
	
	@GetMapping(value = "/admin/point/pointhistory")
		public String pointhistory(PointHistory pointhistory, Model model) {
		
		List<PointHistory> listPointHistory = phs.listPointHistory();
		
		model.addAttribute("listPointHistory", listPointHistory);
		
		return "admin/point/pointhistory";
		
	}
	
	@RequestMapping(value = "/admin/point/deletePointHistory")
	public String deletePointHistory(int point_id, Model model) {
		phs.deletePointHistory(point_id);
	   
		return "redirect:/admin/point/pointhistory";
	}
	
	

}
