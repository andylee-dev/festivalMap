package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.ExperienceContent;

public interface ExperienceService {

	List<ExperienceContent> 	listExperience(ExperienceContent experience);
	ExperienceContent 			detailExperience(int contentId);
	int  						totalExperience();
	int 						experienceDelete(int contentId);	
	int 						totalSearchExperience();
	List<ExperienceContent> 	listSearchExperience(ExperienceContent experience);
	List<ExperienceContent> 	listSmallCode(ExperienceContent experience);
	
}
