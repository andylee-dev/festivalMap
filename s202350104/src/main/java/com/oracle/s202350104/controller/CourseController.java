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
public class CourseController {
	
	private final CourseService cs;
	
	@RequestMapping(value = "course")
	public String courses(Course course, Model model) {
		System.out.println("CourseController course start...");
		int courseCount = cs.courseCount(course);
		System.out.println("CourseController course courseCount ->" + courseCount);
		
		List<Course> CourseList = cs.courseList(course);
		System.out.println("CourseController course CourseList.size() ->" + CourseList.size());
		
		model.addAttribute("courseCount", courseCount);
		model.addAttribute("CourseList", CourseList);
		
		return "course/courseList";
	}
	
	@RequestMapping(value = "course/detail")
	public String courseDetail() {
		return "course/courseDetail";
	}
}
