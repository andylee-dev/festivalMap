package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

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
	public int courseCount(Course course) {
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


//	@Override
//	public List<Course> courseDetail(Course course) {
//		List<Course> courseDetail = null;
//		log.info("CourseDaoImpl courseDetail cstart...");
//		try {
//			courseDetail = session.selectOne("courseDetail", course);
//			log.info("CourseDaoImpl courseDetail courseDetail ->" + courseDetail);
//			
//		} catch (Exception e) {
//			log.info("CourseDaoImpl courseDetail e.getMessage() ->" + e.getMessage());
//		}
//		return courseDetail;
//	}

	@Override
	public CourseContent detailList(int course_id) {
		System.out.println("course_id ->" + course_id);
		try {
			CourseContent detailList = null;
			detailList = session.selectOne("detailList", course_id);
			
		} catch (Exception e) {
			System.out.println("CourseDaoImpl detailList e.getMessage() ->" + e.getMessage());
		}
		return detailList(course_id);
	}
}
