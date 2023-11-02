package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.ExperienceContent;

public interface ExperienceService {

	List<ExperienceContent> 	listExperience(ExperienceContent experience);
	ExperienceContent 			detailExperience(int content_id);
	int  						totalExperience();
	int 						experienceDelete(int content_id);
	List<ExperienceContent> 	deletedExperience(ExperienceContent experience);
	int totalExperience2();
	
}
