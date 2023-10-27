package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CourseController {
	
	@RequestMapping(value = "courses")
	public String courses() {
		return "/courses/coursesList";
	}
	
	@RequestMapping(value = "courses/detail")
	public String courseDetail() {
		return "/courses/courseDetail";
	}
}
