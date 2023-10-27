package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ExperienceController {

	@RequestMapping(value = "/experience")
	public String Experience() {
		return "Experience/ExperienceList";
	}
	
	@RequestMapping(value = "/experience/detail")
	public String experienceDetail() {
		return "experience/experienceDetail";
	}
}
