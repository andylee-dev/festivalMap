package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Experience;
import com.oracle.s202350104.model.ExperienceContent;
import com.oracle.s202350104.model.Report;
import com.oracle.s202350104.service.ExperienceService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ExperienceController {

	private final ExperienceService es;
	
	@RequestMapping(value = "experience")
	public String experience(Model model) {

		List<Experience> listExperience = es.listExperience();
		model.addAttribute("listExperience", listExperience);
		
		return "experience/experienceList";
	}
	
	@RequestMapping(value = "experience/detail")
	public String experienceDetail(int content_id, Model model) {
		ExperienceContent experience = es.detailExperience(content_id);
		model.addAttribute("experience", experience);
		
		return "experience/experienceDetail";
	}
	
	@RequestMapping(value = "experience/writeForm")
	public String writeFormExperience(Model model) {
		
		return "experience/writeFormExperience";
	}
	
}
