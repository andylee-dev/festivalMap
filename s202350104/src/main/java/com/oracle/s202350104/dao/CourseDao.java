package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;

public interface CourseDao {

	int               		courseCount();
	List<Course>      		courseList(Course course);
	List<Course> 			courseDetail(int course_id);
	int 					courseInsert(Course course);
	int 					courseContentInsert(List<CourseContent> courseContentList);

}
