package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class ReportController {

	@RequestMapping(value = "/report")
	public String experience() {
		return "report/reportList";
	}
	
	@RequestMapping(value = "/report/detail")
	public String experienceDetatil() {
		return "report/reportDetail";
	}
}
