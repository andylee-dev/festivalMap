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

	@Override
	public List<CourseContent> courseDetail(int course_id) {
		System.out.println("course_id ->" + course_id);
		List<CourseContent> courseDetailList = cd.courseDetail(course_id);
		
		if(courseDetailList == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "코스 상세 리스트가 없습니다.");
		}
		
		return courseDetailList;
	}
}
