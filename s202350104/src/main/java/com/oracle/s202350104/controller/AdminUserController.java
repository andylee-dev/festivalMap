package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/user")
public class AdminUserController {

	private final UserService us;

	@RequestMapping(value = "userList")
	public String userList(Model model) {
		List<Users> listUsers = us.listUsers();
		model.addAttribute("listUsers", listUsers);
		return "admin/user/userList";
	}

	@RequestMapping(value = "bizUserList")
	public String bizUserList() {
		return "admin/user/bizUserList";
	}
}
