package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.CourseService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class CourseController {
	
	private final CourseService cs;
	private final BannerService bannerService;
	
	@RequestMapping(value = "course")
	public String courses(Course course, String currentPage, Model model) {
		try {
			log.info("CourseController courses start...");
			int courseCount = cs.courseCount();
			log.info("CourseController courses courseCount ->" + courseCount);
			
			Paging page = new Paging(courseCount, currentPage);
			course.setStart(page.getStart());
			course.setEnd(page.getEnd());
			
			List<Course> courseList = cs.courseList(course);
			log.info("CourseController courses courseList.size() ->" + courseList.size());
			
			model.addAttribute("courseCount", courseCount);
			model.addAttribute("courseList", courseList);
			model.addAttribute("page", page);
			
			/*
			 * Banner Logic 구간 
			 * by 엄민용
			 * */
			List<Banner> bannerHeader = bannerService.getHeaderBanner();
			List<Banner> bannerFooter = bannerService.getFooterBanner();
			
			model.addAttribute("bannerHeader", bannerHeader);
			model.addAttribute("bannerFooter", bannerFooter);
			
		} catch (Exception e) {
			log.error("CourseController courses e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("CourseController courses end");
		}
		
		return "course/courseList";
	}
	
	
	@RequestMapping(value = "course/detail")
	public String courseDetail(Course course, Model model) {
		try {
			log.info("CourseController courseDetail course.getCourse_id() ->" + course.getCourse_id());
			List<Course> courseDetailList = cs.courseDetail(course.getCourse_id());
			log.info("CourseController courseDetail courseDetail ->" + courseDetailList.size());
			
			model.addAttribute("courseDetail", courseDetailList);
		} catch (Exception e) {
			log.error("CourseController courseDetail e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("CourseController courseDetai end");
		}
		
		return "course/courseDetail";
	}
}
