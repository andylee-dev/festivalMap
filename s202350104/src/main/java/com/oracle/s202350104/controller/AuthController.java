package com.oracle.s202350104.controller;

import java.net.URLEncoder;
import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.TagsService;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class AuthController {
	private final UserService us;
	private final TagsService ts;

	@RequestMapping(value = "/login")
	public String login(Model model, String error, String logout) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "userJoinForm", "start");
			if ( error != null ) {
				log.info("errorMsg", error);
			}
			if ( logout != null ) {
				log.info("msg", "You have been logged out successfully");
			}
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "userJoinForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "userJoinForm", "end");
		}
		
		return "auth/login";
	}

	@RequestMapping(value = "/join")
	public String userJoin() {
		return "auth/join";
	}
	
	@RequestMapping(value = "/passwordSearch")
	public String userPwSearch() {
		return "auth/passwordSearch";
	}
	
	@RequestMapping(value = "/idSearch")
	public String userIdSearch() {
		return "auth/idSearch";
	}
	
	@RequestMapping(value = "/idSearchResult")
	public String idSearchResult() {
		return "auth/idSearchResult";
	}
	@RequestMapping(value = "/passwordSearchResult")
	public String pwSearchResult() {
		return "auth/passwordSearchResult";
	}
	@RequestMapping(value = "/bizJoinForm")
	public String bizJoinForm() {
		return "auth/bizJoinForm";
	}
	@RequestMapping(value = "/signUp/user")
	public String userSignUp(Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "userSignUp", "start");
			Tags tag = new Tags();
			List<Tags> listTags = ts.listTags(tag);
			log.info("listTags"+listTags.size());
			model.addAttribute("listTags", listTags);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "userSignUp", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "userSignUp", "end");
		}
		return "auth/joinForm";
	}

	@RequestMapping(value = "/signUp/biz")
	public String bizSignUp() {
		return "auth/bizJoinForm";
	}

	@RequestMapping(value = "/signUp/admin")
	public String adminSignUp() {
		return "auth/adminJoinForm";
	}
	
	@RequestMapping(value = "/signUp")
	public String SignUp(@Valid Users user,BindingResult bindingResult, Model model) {
		List<String> errorMessages= null;
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "userJoinForm", "start");
        	log.info(user.toString());
            if (bindingResult.hasErrors()) {
                errorMessages = bindingResult.getAllErrors()
                        .stream()
                        .map(DefaultMessageSourceResolvable::getDefaultMessage)
                        .collect(Collectors.toList());
                log.info(errorMessages.toString());
                String url="";
                model.addAttribute("errorMessages", errorMessages);
                model.addAttribute("user", user);

    			switch (user.getSmall_code()) {
					case 2: 
						url= "/signUp/user";
						break;
					case 3:
						url= "/signUp/biz";
						break;
					default:
						url = "/signUp";
						break;
				}
                return "redirect:" + url+"?errorMessages="+URLEncoder.encode(errorMessages.get(0), "UTF-8");	           
            }else {
                log.info("valid Pass");
            	us.insertUser(user);            	
                log.info("no error");
            }
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "userSignUp", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "userSignUp", "end");
		}
        return "redirect:/login";
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request, HttpServletResponse response) {
		new SecurityContextLogoutHandler().logout(request, response, SecurityContextHolder.getContext().getAuthentication());
		return "redirect:/login";
	}

}
