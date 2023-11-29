package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Point;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.point.PointService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j

public class AdminPointController {
	
	private final PointService ps;
	
	@GetMapping(value = "/admin/point/point")
		public String point(Point point, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		int path = 0;
		
		try {
			log.info("[{}]{}:{}",transactionId, "pointhistory", "start");
			
			int totalpoint = ps.totalpoint();
		
			Paging page = new Paging(totalpoint, currentPage);

			point.setStart(page.getStart());
			point.setEnd(page.getEnd());
		
		List<Point> listPoint = ps.listPoint();
		
		model.addAttribute("listPoint", listPoint);
		model.addAttribute("totalpoint",totalpoint);
		model.addAttribute("page",page);
		model.addAttribute("path",path);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "admin point", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "admin point", "end");
		}
		
		return "admin/point/point";
	}
	
	@GetMapping(value="/admin/point/updateFormPoint")
	public String updateFormPoint(Point point, Model model) {
		
		model.addAttribute("Point", point);
		
		return "admin/point/updateFormPoint";
	}
	
	@PostMapping("/admin/point/updatePoint")
    public String updatePoint(Point point) {
        ps.updatePoint(point);
        return "redirect:/admin/point/point";
    }
	
	@GetMapping(value="/admin/point/writeFormPoint")
	public String writeFormPoint(Point point, Model model) {
		
		model.addAttribute("Point", point);
		
		return "admin/point/writeFormPoint";
	}
	
	@PostMapping("/admin/point/writePoint")
	public String writePoint(Point point) {
	    ps.writePoint(point);
	    return "redirect:/admin/point/point";
	}

}
