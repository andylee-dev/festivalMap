package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FestivalController {
	
	@RequestMapping(value = "/festival")
	public String festival() {
		return "festival/festivalList";
	}
	
	@RequestMapping(value = "/festival/detail")
	public String festivalDetail() {
		return "festival/festivalDetail";
	}
	
	@RequestMapping(value = "/festival/recommendation")
	public String festivalRecommendation() {
		return "festival/festivalRecommendation";
	}
	
	@RequestMapping(value = "/festival/test")
	public String festivalTest() {
		return "festival/festivalTest";
	}
	
	@RequestMapping(value = "/festival/calendar")
	public String festivalCalendar() {
		return "festival/festivalCalendar";
	}
}
