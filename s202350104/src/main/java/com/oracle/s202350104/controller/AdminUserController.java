package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.model.Favorite;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.FavoriteService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/user")
public class AdminUserController {

	private final UserService us;
	private final FavoriteService fas;

	@RequestMapping(value = "userList")
	public String userList(Model model, Users user, String currentPage ) {
		UUID transactionId = UUID.randomUUID();
		String errMsg ="Success";
		List<Users> listUsers = null;
		try {
			log.info("[{}]{}:{}",transactionId, "userList", "start");		
			user.setSmall_code(2);
			int totalUsersCount =us.totalUsers(user);
			log.info("totalUsersCount:{}",totalUsersCount);
			log.info("user.getIs_deleted:{}",user.getIs_deleted());

			Paging page = new Paging(totalUsersCount, currentPage);
			user.setStart(page.getStart());
			user.setEnd(page.getEnd());

			listUsers = us.getSearchUserList(user);	
			if(listUsers == null) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 리스트가 존재하지 않습니다.");
			}
			model.addAttribute("listUsers", listUsers);
			model.addAttribute("page", page);
//			model.addAttribute("searchOption",user);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "userList", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "userList", "end");
		}
		return "admin/user/userList";
	}

	@RequestMapping(value = "bizUserList")
	public String bizUserList(Model model) {
		List<Users> listUsers = us.getUserList(3);
		model.addAttribute("listUsers", listUsers);
		return "admin/user/bizUserList";
	}
	
	
	@RequestMapping(value = "favoriteList")
	public String favoriteList(Favorite favorite, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin favorite", "start");
			int totalFavorite = fas.totalFavorite();
			
			Paging page = new Paging(totalFavorite, currentPage);
			favorite.setStart(page.getStart());
			favorite.setEnd(page.getEnd());
			
			List<Favorite> listFavorite = fas.listFavorite(favorite);
						
			model.addAttribute("totalFavorite", totalFavorite);
			model.addAttribute("page",page);
			model.addAttribute("listFavorite", listFavorite);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin favorite", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "admin favorite", "end");
		}
				
		return "admin/user/favoriteList";
	}
		

}
