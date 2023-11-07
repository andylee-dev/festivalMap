package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.service.ContentSerivce;
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
	private final ContentSerivce contentService;
	
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
	public String courseInsertForm(Course Course , Contents contents, Model model) {
		log.info("AdminCourseController courseInsertForm start...");
		log.info("AdminCourseController courseInsertForm contents.getId() ->{}", contents.getId());
		
		
		return "course/courseInsertForm";
	}
	
	@RequestMapping(value = "/courseInsert")
	public String courseInsert(Course course, Contents contents , Model model) {
		try {
			log.info("AdminCourseController courseInsert start...");
			log.info("AdminCourseController courseInsert course ->" + course);
			int courseInsert = cs.courseInsert(course);
			log.info("AdminCourseController courseInsert courseInsert ->" + courseInsert);
			
		} catch (Exception e) {
			log.error("AdminCourseController courseInsert e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseInsert end...");
		}
		return "redirect:list";
	}
	
	
	@RequestMapping(value = "/contentListAll")
	public String contentListAll(Contents content, String currentPage, Model model) {
		log.info("AdminCourseController contentListAll start...");
		try {
			List<Contents> listContents = contentService.listContents();
			log.info("ContentController contentListAll listContents.size() ->" + listContents.size());
			
			model.addAttribute("listContents", listContents);
			
		} catch (Exception e) {
			log.error("ContentController contentListAll e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("ContentController contentListAll end...");
		}
		return "content/contentListAll";
	}
}
