package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;

public interface CourseService {

	int 					courseCount(Course course);
	List<Course>      		courseList(Course course);
	List<Course> 			courseDetail(int course_id);
	int						courseInsert(Course course);
	int						courseContentInsert(List<CourseContent> courseContentList);
	int 					courseDelete(int id);
	int 					courseContentDelete(int id);
	int 					courseUpdate(Course course);
	Course 					courseUpdateDetail(int id);
	List<CourseContent> 	courseContentList(int id);
	int 					deleteCourseContent(CourseContent courseContent);
	int 					deleteToContent(List<CourseContent> deleteContent);
	int 					maxOrderNum(int id);
	List<Course> 			courseListSmallCode(Course course);

	
}   		  	 		
	 