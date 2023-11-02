package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.ExperienceContent;

public interface ExperienceDao {

	List<ExperienceContent> listExperience(ExperienceContent experience);

	ExperienceContent detailExperience(int content_id);

	int totalExperience();

	int experienceDelete(int content_id);

}
