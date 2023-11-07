package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.configuration.Role;
import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Favorite;
import com.oracle.s202350104.model.RestaurantsContent;
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
	public String userList(Model model) {
		UUID transactionId = UUID.randomUUID();
		String errMsg ="Success";
		try {
			log.info("[{}]{}:{}",transactionId, "userList", "start");		
			List<Users> listUsers = us.getUserList(2);
			if(listUsers == null) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 리스트가 존재하지 않습니다.");
			}
			model.addAttribute("listUsers", listUsers);
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
	public String favoritSearch(Favorite favorite, String currentPage, Model model) {
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
	
	
	@RequestMapping(value = "favoriteSearch")
	public String favoriteList(Favorite favorite, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin favoriteSearch", "start");
			int totalFavorite = fas.condTotalFavorite(favorite);
			
			Paging page = new Paging(totalFavorite, currentPage);
			favorite.setStart(page.getStart());
			favorite.setEnd(page.getEnd());
			
			List<Favorite> listSearchFavorite = fas.listSearchFavorite(favorite);
						
			model.addAttribute("totalFavorite", totalFavorite);
			model.addAttribute("page",page);
			model.addAttribute("listFavorite", listSearchFavorite);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin favoriteSearch", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "admin favoriteSearch", "end");
		}
				
		return "admin/user/favoriteList";
	}
	
	
	
}
