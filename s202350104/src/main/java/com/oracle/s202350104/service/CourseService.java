package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Course;

public interface CourseService {

	int               courseCount(Course course);
	List<Course>      courseList(Course course);

}
