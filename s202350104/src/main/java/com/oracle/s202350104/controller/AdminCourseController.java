package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.service.CourseService;
import com.oracle.s202350104.service.PagingList;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/course")
public class AdminCourseController {
	
	private final CourseService cs;
	
	@RequestMapping(value = "/list")
	public String courseList(Course course, String currentPage,  Model model) {
		try {
			log.info("AdminCourseController courseList start");
			int courseCount = cs.courseCount();
			log.info("AdminCourseController courseList courseCount ->" + courseCount);
			
			PagingList page = new PagingList(courseCount, currentPage);
			course.setStart(page.getStart());
			course.setEnd(page.getEnd());
			System.out.println("page.getStart() ->"+ page.getStart());
			System.out.println("page.getEnd() ->"+ page.getEnd());
			
			log.info("AdminCourseController courseList course ->" + course);
			List<Course> courseList = cs.courseList(course);
			log.info("AdminCourseController courseList courseList.size() ->" + courseList.size());
			
			model.addAttribute("courseCount", courseCount);
			model.addAttribute("courseList", courseList);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("AdminCourseController courseList e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseList end");
		}
		
		return "admin/course/list";
	}
	
	
	@RequestMapping(value = "/courseUpdateForm")
	public String courseUpdateForm(Course course, Model model) {
	
		try {
			log.info("AdminCourseController courseUpdateForm course_id ->" + course.getCourse_id());
			List<Course> courseDetailContent = cs.courseDetail(course.getCourse_id());
			log.info("AdminCourseController courseUpdateForm course ->" + courseDetailContent.size());
			
			model.addAttribute("courseContent", courseDetailContent);
			
		} catch (Exception e) {
			log.error("AdminCourseController courseUpdateForm e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseUpdateForm end...");
		}
		return "course/courseUpdateForm";
	}
	
	@RequestMapping(value = "/courseInsertForm")
	public String courseWriteForm(Model model) {
		
		return "course/courseInsertForm";
	}
	
	
	@RequestMapping(value = "/contentListAll")
	public String contentListAll(Contents content, String currentPage, Model model) {
		System.out.println("AdminCourseController contentListAll start...");
		
		return "content/contentListAll";
	}
}
