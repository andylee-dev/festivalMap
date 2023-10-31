package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Experience;
import com.oracle.s202350104.service.ExperienceService;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/content")
public class AdminContentController {
	
	private final ExperienceService es;

	@RequestMapping(value = "festival")
	public String festival() {
		return "admin/content/festival";
	}

	@RequestMapping(value = "experience")
	public String experience(Model model) {
		List<Experience> listExperience = es.listExperience();
		model.addAttribute("listExperience", listExperience);
		return "admin/content/experience";
	}

	@RequestMapping(value = "restaurant")
	public String restaurant() {
		return "admin/content/restaurant";
	}

	@RequestMapping(value = "spot")
	public String spot() {
		return "admin/content/spot";
	}

	@RequestMapping(value = "accomodation")
	public String accomodation() {
		return "admin/content/accomodation";
	}

}
