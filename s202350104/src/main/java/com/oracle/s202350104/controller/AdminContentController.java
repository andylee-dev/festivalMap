package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/content")
public class AdminContentController {

	@RequestMapping(value = "festival")
	public String festival() {
		return "admin/content/festival";
	}

	@RequestMapping(value = "experience")
	public String experience() {
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
