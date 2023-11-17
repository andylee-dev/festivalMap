package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Point;
import com.oracle.s202350104.service.point.PointService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j

public class AdminPointController {
	
	private final PointService ps;
	
	@GetMapping(value = "/admin/point/point")
		public String point(Point point, Model model) {
		
		List<Point> listPoint = ps.listPoint();
		
		model.addAttribute("listPoint", listPoint);
		
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
