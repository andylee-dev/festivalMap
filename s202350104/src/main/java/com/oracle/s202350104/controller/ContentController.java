package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class ContentController {

	@RequestMapping(value = "/")
	public String home() {
		return "home";
	}
}
