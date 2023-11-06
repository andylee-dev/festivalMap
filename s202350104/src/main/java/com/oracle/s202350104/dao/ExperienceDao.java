package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.ExperienceContent;

public interface ExperienceDao {

	List<ExperienceContent> 	listExperience(ExperienceContent experience);
	ExperienceContent 			detailExperience(int contentId);
	int 						totalExperience();
	int 						experienceDelete(int contentId);
	int 						totalSearchExperience(ExperienceContent experience);
	List<ExperienceContent> 	listSearchExperience(ExperienceContent experience);
	List<ExperienceContent> 	listSmallCode(ExperienceContent experience);
	int experienceRestore(int contentId);

}
