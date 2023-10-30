package com.oracle.s202350104.service;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.CourseDao;
import com.oracle.s202350104.model.Course;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CourseServiceImpl implements CourseService {

	private final CourseDao cd;

	@Override
	public int courseCount(Course course) {
		int courseCount = 0;
		System.out.println("CourseServiceImpl courseCount start...");
		courseCount = cd.courseCount(course);
		System.out.println("CourseServiceImpl courseCount courseCount ->" + courseCount);
		
		return courseCount;
	}
}
