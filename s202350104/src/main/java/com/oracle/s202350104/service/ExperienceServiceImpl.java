package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.ExperienceDao;
import com.oracle.s202350104.model.Experience;
import com.oracle.s202350104.model.ExperienceContent;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ExperienceServiceImpl implements ExperienceService {

	private final ExperienceDao ed;
	
	@Override
	public List<Experience> listExperience() {
		List<Experience> listExperience = ed.listExperience();
		return listExperience;
	}

	@Override
	public ExperienceContent detailExperience(int content_id) {
		ExperienceContent experience = ed.detailExperience(content_id);
		return experience;
	}

}
