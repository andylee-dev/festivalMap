package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.service.CourseService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CourseController {
	
	private final CourseService cs;
	
	@RequestMapping(value = "course")
	public String courses(Course course, String currentPage, Model model) {
		try {
			log.info("CourseController courses start...");
			int courseCount = cs.courseCount(course);
			log.info("CourseController courses courseCount ->" + courseCount);
			
			Paging page = new Paging(courseCount, currentPage);
			course.setStart(page.getStart());
			course.setEnd(page.getEnd());
			
			List<Course> courseList = cs.courseList(course);
			log.info("CourseController courses courseList.size() ->" + courseList.size());
			
			model.addAttribute("courseCount", courseCount);
			model.addAttribute("courseList", courseList);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("CourseController courses e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("CourseController courses end");
		}
		
		return "course/courseList";
	}
	
	
	@RequestMapping(value = "course/detail")
	public String courseDetail() {
		return "course/courseDetail";
	}
}
