package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Experience;
import com.oracle.s202350104.model.ExperienceContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ExperienceDaoImpl implements ExperienceDao {
	
	private final SqlSession session;

	@Override
	public List<ExperienceContent> listExperience(ExperienceContent experience) {
		List<ExperienceContent> listExperience = null;
		
		try {
			listExperience = session.selectList("shExperienceListAll",experience);
			log.info("ExperienceDaoImpl listExperience() => " + listExperience.size());
		} catch (Exception e) {
			log.info("ExperienceDaoImpl listExperience() => " + e.getMessage());
		}
		return listExperience;
	}

	@Override
	public ExperienceContent detailExperience(int contentId) {
		ExperienceContent experience = new ExperienceContent();
		try {
			experience = session.selectOne("shExperienceDetail", contentId);
		} catch (Exception e) {
			
		}
		return experience;
	}

	@Override
	public int totalExperience() {
		int totalExperienceCnt = 0;
		try {
			totalExperienceCnt = session.selectOne("shExperienceTotal");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return totalExperienceCnt;
	}

	@Override
	public int experienceDelete(int contentId) {
		int experienceDelete = 0;
		try {
			experienceDelete = session.update("shExperienceDelete",contentId);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return experienceDelete;
	}	

	@Override
	public int totalSearchExperience(ExperienceContent experience) {
		int totalSearchExperience = 0;
		try {
			totalSearchExperience = session.selectOne("shExperienceSearchTotal",experience);
			log.info("ExperienceDaoImpl totalSearchExperience()->"+totalSearchExperience);
		} catch (Exception e) {
			log.info("ExperienceDaoImpl totalSearchExperience ->"+e.getMessage() );
		}
		return totalSearchExperience;
	}

	@Override
	public List<ExperienceContent> listSearchExperience(ExperienceContent experience) {
		List<ExperienceContent> listSearchExperience = null;
		
		try {
			listSearchExperience = session.selectList("shExperienceSearchListAll",experience);
			log.info("ExperienceDaoImpl listSearchExperience() => " + listSearchExperience.size());
		} catch (Exception e) {
			log.info("ExperienceDaoImpl listSearchExperience() => " + e.getMessage());
		}
		return listSearchExperience;
	}

	@Override
	public List<ExperienceContent> listSmallCode(ExperienceContent experience) {
		List<ExperienceContent> listSmallCode = null;
		
		try {
			listSmallCode = session.selectList("shListSmallCodeAll",experience);
			log.info("ExperienceDaoImpl listSmallCode() => " + listSmallCode.size());
		} catch (Exception e) {
			// TODO: handle exception
		}
		return listSmallCode;
	}

}
