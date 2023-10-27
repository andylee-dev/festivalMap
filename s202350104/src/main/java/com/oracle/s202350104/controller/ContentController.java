package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ContentController {

	@RequestMapping(value = "/")
	public String home() {
		return "home";
	}

	@RequestMapping(value = "/festival")
	public String festival() {
		return "festivals/index";
	}

	@RequestMapping(value = "/restaurant")
	public String restaurant() {
		return "restaurant/index";
	}
	@RequestMapping(value = "/accomodation")
	public String accomodation() {
		return "accomodation/index";
	}
	@RequestMapping(value = "/spot")
	public String spot() {
		return "spot/index";
	}
	@RequestMapping(value = "/experience")
	public String experience() {
		return "experience/index";
	}

}
