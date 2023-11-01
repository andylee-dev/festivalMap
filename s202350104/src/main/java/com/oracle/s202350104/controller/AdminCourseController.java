package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.service.CourseService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/course")
public class AdminCourseController {
	
	private final CourseService cs;
	
	@RequestMapping(value = "list")
	public String courselist(Course course, Model model) {
		log.info("AdminCourseController courselist start");
		List<Course> courseList = cs.courseList(course);
		model.addAttribute("courseList", courseList);
		log.info("AdminCourseController courselist courseList.size() ->" + courseList.size());
		
		return "admin/course/list";
	}
}
