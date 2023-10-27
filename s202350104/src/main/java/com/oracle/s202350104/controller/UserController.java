package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class UserController {

	@RequestMapping(value = "/user")
	public String userList() {
		return "user";
	}
	
	@RequestMapping(value = "/user/join")
	public String userJoin() {
		return "auth/join";
	}
	
	@RequestMapping(value = "/user/login")
	public String userLogin() {
		return "auth/login";
	}
	
	@RequestMapping(value = "/user/idSearch")
	public String userIdSearch() {
		return "auth/idSearch";
	}
	
	@RequestMapping(value = "/user/passwordSearch")
	public String userPwSearch() {
		return "auth/passwordSearch";
	}


}
