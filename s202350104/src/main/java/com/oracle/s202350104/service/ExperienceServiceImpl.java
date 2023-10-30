package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.ExperienceDao;
import com.oracle.s202350104.model.Experience;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ExperienceServiceImpl implements ExperienceService {

	private final ExperienceDao ed;
	
	@Override
	public List<Experience> listExperience() {
		System.out.println("experienceerviceImpl start kkk ....");
		List<Experience> listExperience = ed.listExperience();
		return listExperience;
	}

}
