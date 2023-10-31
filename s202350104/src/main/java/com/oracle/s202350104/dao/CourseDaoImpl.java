package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Course;

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
		System.out.println("CourseDaoImpl courseCount start...");
		try {
			courseCount = session.selectOne("courseCount");
			System.out.println("CourseDaoImpl courseCount courseCount ->" + courseCount);
		} catch (Exception e) {
			System.out.println("CourseDaoImpl courseCount e.getMessage() ->" + e.getMessage());
		}
		return courseCount;
	}

	@Override
	public List<Course> courseList(Course course) {
		List<Course> courseList = null;
		System.out.println("CourseDaoImpl courseList start...");
		try {
			courseList = session.selectList("courseListAll", course);
			System.out.println("CourseDaoImpl courseList courseList.size() ->" + courseList.size());
			
		} catch (Exception e) {
			System.out.println("CourseDaoImpl courseList e.getMessage() ->" + e.getMessage());
		}
		
		return courseList;
	}
}
