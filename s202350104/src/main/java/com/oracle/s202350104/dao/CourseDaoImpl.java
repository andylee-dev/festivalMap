package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.CourseContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class CourseDaoImpl implements CourseDao {

	private final SqlSession session;

	@Override
	public int courseCount() {
		int courseCount = 0;
		log.info("CourseDaoImpl courseCount start...");
		try {
			courseCount = session.selectOne("courseCount");
			log.info("CourseDaoImpl courseCount courseCount ->" + courseCount);
		} catch (Exception e) {
			log.info("CourseDaoImpl courseCount e.getMessage() ->" + e.getMessage());
		}
		return courseCount;
	}

	
	@Override
	public List<Course> courseList(Course course) {
		List<Course> courseList = null;
		log.info("CourseDaoImpl courseList start...");
		try {
			courseList = session.selectList("courseListAll", course);
			log.info("CourseDaoImpl courseList courseList.size() ->" + courseList.size());
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseList e.getMessage() ->" + e.getMessage());
		}
		
		return courseList;
	}

	
	@Override
	public List<Course> courseDetail(int course_id) {
		log.info("course_id ->" + course_id);
		List<Course> courseDetailList = null;
		try {
			courseDetailList = session.selectList("noCourseDetailList", course_id);
			log.info("CourseDaoImpl courseDetail courseDetailList.size() ->" + courseDetailList.size());
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseDetail e.getMessage() ->" + e.getMessage());
		}
		return courseDetailList;
	}


	@Override
	public int courseInsert(Course course) {
		int result = 0;
		int newCourseId= 0;
		try {
			log.info("CourseDaoImpl courseInsert courseInsert id->" + course.getId());
			result = session.insert("noCourseInsert", course);
			newCourseId = course.getId();
			log.info("CourseDaoImpl courseInsert courseInsert ->" + result);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseInsert e.getMessage() ->" + e.getMessage());
		}
		return newCourseId;
	}


	@Override
	public int courseContentInsert(List<CourseContent> courseContentList) {
		int courseContentInsert = 0;
		try {
			courseContentInsert = session.insert("noCourseContentInsert", courseContentList);
			log.info("CourseDaoImpl courseInsert courseContentInsert ->" + courseContentInsert);
			
		} catch (Exception e) {
			log.info("CourseDaoImpl courseContentInsert e.getMessage() ->" + e.getMessage());
		}
		return courseContentInsert;
	}

	
//	@Override
//	public Course courseDetailContent(int id) {
//		log.info("id ->" + id);
//		Course courseDetailContent = null;
//		try {
//			courseDetailContent = session.selectOne("noCourseDetailContent",id);
//			log.info("CourseDaoImpl courseDetailContent courseDetailContent ->" + courseDetailContent);
//			
//		} catch (Exception e) {
//			log.info("CourseDaoImpl courseDetailContent e.getMessage() ->" + e.getMessage());
//		}
//		return courseDetailContent;
//	}
}
