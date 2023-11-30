package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.AccomodationContent;
import com.oracle.s202350104.model.Point;
import com.oracle.s202350104.model.PointHistory;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PointHistoryService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AdminPointHistoryController {
	
	private final PointHistoryService phs;
	
	@GetMapping(value = "pointhistory")
		public String pointhistory(PointHistory pointhistory, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		
		
		try {
			
			log.info("[{}]{}:{}",transactionId, "pointhistory", "start");
			
		int path = 0;
		int totalpointhistory = phs.totalpointHistory();
		
		PagingList page = new Paging(totalpointhistory, currentPage);
		log.info("totalpointhistory{}",totalpointhistory);
		log.info("currentPage {}",currentPage);

		pointhistory.setStart(page.getStart());
		log.info("Start {}",page.getStart());
		pointhistory.setEnd(page.getEnd());
		log.info("End {}",page.getEnd());
		List<PointHistory> listPointHistory = phs.listPointHistory();
		log.info("listPointHistory {}",listPointHistory.size());
		List<PointHistory> sortedList = phs.listPointHistorySortedByDateDesc(listPointHistory);
		log.info("sortedList {}",sortedList.size());

        model.addAttribute("listPointHistory", sortedList);
        model.addAttribute("totalpointHistory", totalpointhistory);
        model.addAttribute("page",page);
		model.addAttribute("path",path);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "admin pointhistory", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "admin pointhistory", "end");
		}
		
		return "admin/point/pointhistory";
		
	}
	
	@RequestMapping(value = "/admin/point/deletePointHistory")
	public String deletePointHistory(Integer id, Model model) {
		
		phs.deletePointHistory(id);
	   
		return "redirect:/admin/point/pointhistory";
	}
	
	@GetMapping(value = "/admin/point/pointhistory")
	public String pointhistoryList(PointHistory pointhistory, String currentPage, Model model) {
	UUID transactionId = UUID.randomUUID();
	
	
	
	try {
		
		log.info("[{}]{}:{}",transactionId, "pointhistory", "start");
		
	int path = 0;
	int totalpointhistory = phs.totalpointHistory();
	
	PagingList page = new Paging(totalpointhistory, currentPage);
	log.info("totalpointhistory{}",totalpointhistory);
	log.info("currentPage {}",currentPage);

	pointhistory.setStart(page.getStart());

	pointhistory.setEnd(page.getEnd());
	
	List<PointHistory> listPointHistory = phs.listPointHistory1(pointhistory);
	List<PointHistory> sortedList = phs.listPointHistorySortedByDateDesc(listPointHistory);

    model.addAttribute("listPointHistory", sortedList);
    model.addAttribute("totalpointHistory", totalpointhistory);
    model.addAttribute("page",page);
	model.addAttribute("path",path);
	
	} catch (Exception e) {
		log.error("[{}]{}:{}",transactionId,  "admin pointhistory", e.getMessage());
	}finally {
		log.info("[{}]{}:{}",transactionId, "admin pointhistory", "end");
	}
	
	return "admin/point/pointhistory";
	
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
	
	@RequestMapping("/admin/point/pointhistorySearch")
    public String pointhistorySearch(PointHistory pointhistory, String currentPage, Model model, HttpServletRequest request) {
		
    	UUID transactionId = UUID.randomUUID();
    	
    	try {
			log.info("[{}]{}:{}", transactionId, "PointHistoryController pointhistorySearch", "Start");
    	
		int path 			= 1;
    	
    	int totalPointhistory = phs.conTotalPointHistory(pointhistory);
    	String keyword		= request.getParameter("keyword");
    	String user_name  = request.getParameter("user_name");
    	log.info("user_name {}",user_name);
    	String point_title  = request.getParameter("point_title");
    	String point_point  = request.getParameter("point_point");
    	log.info("keyword {}",keyword);
    	
    	Paging page = new Paging(totalPointhistory, currentPage);
    	pointhistory.setStart(page.getStart());
    	log.info("Start {}",page.getStart());
    	pointhistory.setEnd(page.getEnd());
    	log.info("End {}",page.getEnd());
    	
        List<PointHistory> searchResult = phs.searchPointHistorylist(pointhistory);
        
        model.addAttribute("totalPointhistory", totalPointhistory);
        model.addAttribute("listPointHistory", searchResult);
        model.addAttribute("path", path);
        model.addAttribute("page", page);
        model.addAttribute("keyword", keyword);	
        model.addAttribute("user_name", user_name);	
        model.addAttribute("point_title", point_title);	
        model.addAttribute("point_point", point_point);	
        
    	} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "PointHistoryController pointhistorySearch", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "PointHistoryController pointhistorySearch", "end");
		}	
        
        return "admin/point/pointhistory";
    }
	

}
