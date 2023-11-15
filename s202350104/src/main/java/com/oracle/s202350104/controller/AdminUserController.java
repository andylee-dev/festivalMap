package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.configuration.Role;
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
		List<Users> listUsers = null;
		try {
			log.info("[{}]{}:{}",transactionId, "userList", "start");		
			user.setSmall_code(2);
			int totalUsersCount =us.totalUsers(user);
			log.info(user.toString());

			Paging page = new Paging(totalUsersCount, currentPage);
			user.setStart(page.getStart());
			user.setEnd(page.getEnd());

			listUsers = us.getSearchUserList(user);	
			if(listUsers == null) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 리스트가 존재하지 않습니다.");
			}
			model.addAttribute("listUsers", listUsers);
			model.addAttribute("page", page);
			model.addAttribute("searchOption",user);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "userList", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "userList", "end");
		}
		return "admin/user/userList";
	}
	
	@RequestMapping(value = "bizUserList")
	public String bizUserList(Model model,Users user, String currentPage ) {
		UUID transactionId = UUID.randomUUID();
		List<Users> listUsers = null;
		try {
			log.info("[{}]{}:{}",transactionId, "bizUserList", "start");		
			user.setSmall_code(3);
			int totalUsersCount =us.totalUsers(user);
			log.info(user.toString());

			Paging page = new Paging(totalUsersCount, currentPage);
			user.setStart(page.getStart());
			user.setEnd(page.getEnd());

			listUsers = us.getSearchUserList(user);	
			if(listUsers == null) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 리스트가 존재하지 않습니다.");
			}
			model.addAttribute("listUsers", listUsers);
			model.addAttribute("page", page);
			model.addAttribute("searchOption",user);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "bizUserList", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "bizUserList", "end");
		}
		return "admin/user/bizUserList";
	}
	
	@RequestMapping(value = "userUpdateForm/{id}",  method = RequestMethod.POST)
    public String showUpdateForm(@PathVariable("id") int id, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "userUpdateForm", "start");	
			Users user = us.getUserById(id)
			  .orElseThrow(() -> new IllegalArgumentException("Invalid user Id:" + id));
			model.addAttribute("user", user);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "userUpdateForm", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "userUpdateForm", "end");
		}
        return "admin/user/userUpdateForm";
    }
	
	@RequestMapping("/users")
    public ResponseEntity<Integer> updateUser( int id, Users user, Model model) {
        int result = us.updateUser(user);
        return ResponseEntity.ok(result);
    }
	
	@RequestMapping(value = "userDeleteAjax",  method = RequestMethod.POST)
    public ResponseEntity<Integer> deleteUser( int id, Model model) {
		int result = 0;
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "userUpdateForm", "start");	
			log.info("id:{}",id);
			result = us.deletUser(id);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "userUpdateForm", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "userUpdateForm", "end");
		}		
		return ResponseEntity.ok(result);
    }

	
	@RequestMapping(value = "getTotalSearchUserAjax",  method = RequestMethod.POST)
    public ResponseEntity<Integer> getTotalSearchUser(@RequestBody Users user) {
		int result = 0;
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "getTotalSearchUser", "start");	
			log.info(user.toString());
			result =us.totalUsers(user);
			log.info("totalUsers:{}",result);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "getTotalSearchUser", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "getTotalSearchUser", "end");
		}		
		return ResponseEntity.ok(result);
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
