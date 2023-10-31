package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;


import com.oracle.s202350104.model.Point;
import com.oracle.s202350104.service.PointService;

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
	

}
