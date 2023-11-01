package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.boot.context.annotation.DeterminableImports;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.CourseDao;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class CourseServiceImpl implements CourseService {

	private final CourseDao cd;

	@Override
	public int courseCount(Course course) {
		int courseCount = 0;
		courseCount = cd.courseCount(course);
		log.info("CourseServiceImpl courseCount courseCount ->" + courseCount);
		
		return courseCount;
	}

	@Override
	public List<Course> courseList(Course course) {
		List<Course> courseList = null;
		courseList = cd.courseList(course);
		
		if(courseList == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "코스 리스트가 없습니다.");
		}
		
		return courseList;
	}

//	@Override
//	public List<Course> courseDetail(Course course) {
//		List<Course> courseDetail = null;
//		courseDetail = cd.courseDetail(course);
//		
//		if(courseDetail == null) {
//			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "코스 아디가 없습니다.");
//		}
//		
//		return courseDetail;
//	}

	@Override
	public CourseContent detailList(int course_id) {
		System.out.println("course_id ->" + course_id);
		CourseContent detailList = null;
		detailList = cd.detailList(course_id);
		
		return detailList;
	}
}
