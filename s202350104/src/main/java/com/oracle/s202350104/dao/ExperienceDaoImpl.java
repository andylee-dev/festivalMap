package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Experience;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ExperienceDaoImpl implements ExperienceDao {
	
	private final SqlSession session;

	@Override
	public List<Experience> listExperience() {
		List<Experience> listExperience = null;
		System.out.println("ExperienceDaoImpl listExperience start");
		
		try {
			listExperience = session.selectList("shExperienceListAll");
			System.out.println("ExperienceDaoImpl listExperience.size()->"+listExperience.size());
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
		return listExperience;
	}

}
