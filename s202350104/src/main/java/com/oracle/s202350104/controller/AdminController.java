package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin")
public class AdminController {
	
	@RequestMapping(value = "")
	public String home() {
		return "admin/index";
	}

	@RequestMapping(value = "userList")
	public String userList() {
		return "admin/user/userList";
	}

	@RequestMapping(value = "bizUserList")
	public String bizUserList() {
		return "admin/user/bizUserList";
	}

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
