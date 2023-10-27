package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ContentController {

	@RequestMapping(value = "/home")
	public String home() {
		return "home";
	}

	@RequestMapping(value = "/festival/index")
	public String festival() {
		return "festival/index";
	}

	@RequestMapping(value = "/restaurant/index")
	public String restaurant() {
		return "restaurant/index";
	}
	@RequestMapping(value = "/accomodation/index")
	public String accomodation() {
		return "accomodation/index";
	}
	@RequestMapping(value = "/spot/index")
	public String spot() {
		return "spot/index";
	}
	@RequestMapping(value = "/experience/index")
	public String experience() {
		return "experience/index";
	}

}
