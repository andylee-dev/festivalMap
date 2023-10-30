package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Experience;
import com.oracle.s202350104.model.ExperienceContent;

public interface ExperienceDao {

	List<Experience> listExperience();

	ExperienceContent detailExperience(int content_id);

}
