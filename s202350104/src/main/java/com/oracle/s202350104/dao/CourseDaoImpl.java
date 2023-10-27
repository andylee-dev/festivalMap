package com.oracle.s202350104.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Course;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
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
}
