package com.oracle.s202350104.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.oracle.s202350104.dao.ContentDaoImpl;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;
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
		log.info("AdminCourseController courseInsertForm contents.getId() -> {}", contents.getId());

		return "course/courseInsertForm";
	}
	
	@RequestMapping(value = "/courseInsert")
	public String courseInsert(Course course, @RequestParam List<String> contents , Model model) {
		try {
			log.info("AdminCourseController courseInsert start...");
			log.info("AdminCourseController courseInsert course ->" + course);
			
			/*TODO: Course정보를 INSERT.*/
			int newCourseId = cs.courseInsert(course);
			log.info("AdminCourseController courseInsert courseInsert ->" + newCourseId);
			
			
			List<CourseContent> courseContentList = new ArrayList<CourseContent>();
			/*TODO: Content Course정보를 INSERT*/			//	dto
			for (int i = 0; i < contents.size(); i++) {
				CourseContent cc = new CourseContent();
				cc.setContent_id(Integer.parseInt(contents.get(i)));
				log.info("setContent_id newCourseId ->" + (contents.get(i)));
				cc.setCourse_id(newCourseId);
				log.info("setCourse_id newCourseId ->" + newCourseId);
				cc.setOrder_num(i+1);
				log.info("setCourse_id newCourseId ->" + i+1);
				courseContentList.add(cc);
			}
			log.info(contents.toString());				//	Map<int,List()>
			int courseContentInsert = cs. courseContentInsert(courseContentList);		//list 3
																				//	int  1
			log.info("AdminCourseController courseInsert courseInsert ->" + courseContentInsert);
			
			
		} catch (Exception e) {
			log.error("AdminCourseController courseInsert e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseInsert end...");
		}
		return "redirect:/admin/course/list";
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
	
	@RequestMapping(value = "/courseDelete")
	public String courseDelete(int id) {
		log.info("AdminCourseController courseDelete start...");
		try {
			/* TODO: CourseContents 삭제*/
			log.info("AdminCourseController id ->" +id);
			int courseContentDelete = cs.courseContentDelete(id);
			log.info("AdminCourseController courseContentDelete courseDelete ->" + courseContentDelete);
			
			/* TODO: Courses 삭제*/
			int courseDelete = cs.courseDelete(id);
			log.info("AdminCourseController courseDelete courseDelete ->" + courseDelete);
			
		} catch (Exception e) {
			log.error("AdminCourseController courseDelete e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("AdminCourseController courseDelete end...");
		}
		return "redirect:/admin/course/list";
	}
	
}
