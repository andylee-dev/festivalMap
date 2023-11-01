package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;

public interface CourseDao {

	int               		courseCount(Course course);
	List<Course>      		courseList(Course course);
	List<CourseContent> 	courseDetail(int course_id);

}
