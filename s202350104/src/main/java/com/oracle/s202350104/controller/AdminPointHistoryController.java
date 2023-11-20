package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Point;
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
		List<PointHistory> sortedList = phs.listPointHistorySortedByDateDesc(listPointHistory);

        model.addAttribute("listPointHistory", sortedList);
		
		return "admin/point/pointhistory";
		
	}
	
	@RequestMapping(value = "/admin/point/deletePointHistory")
	public String deletePointHistory(int point_id, Model model) {
		phs.deletePointHistory(point_id);
	   
		return "redirect:/admin/point/pointhistory";
	}
	
	@GetMapping(value="/admin/point/writeFormPointHistory")
	public String writeFormPoint(PointHistory pointhistory, Model model) {
		
		model.addAttribute("Pointhitory", pointhistory);
		
		return "admin/point/writeFormPointHistory";
	}
	
	@PostMapping("/admin/point/writePointHistory")
	public String writePointHistory(PointHistory pointhistory) {
	    phs.writePointHistory(pointhistory);
	    return "redirect:/admin/point/pointhistory";
	}
	
    @PostMapping("/admin/point/pointhistorySearch")
    public String pointhistorySearch(String search, String keyword, Model model) {
        List<PointHistory> searchResult = phs.searchPointHistory(search, keyword);
        model.addAttribute("listPointHistory", searchResult);
        return "admin/point/pointhistory";
    }
	

}
