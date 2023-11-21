package com.oracle.s202350104.controller;

import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
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
import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Favorite;
import com.oracle.s202350104.model.History;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.FavoriteService;
import com.oracle.s202350104.service.HistoryService;
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
	private final HistoryService hs;

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
			
			History pHistory = new History();
			pHistory.setBig_code(user.getBig_code());
			pHistory.setTarget_id(user.getId());
			History history = hs.getLatestHistory(pHistory);

			model.addAttribute("listUsers", listUsers);
			model.addAttribute("history", history);
			model.addAttribute("page", page);
			model.addAttribute("searchOption",user);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "bizUserList", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "bizUserList", "end");
		}
		return "admin/user/bizUserList";
	}
	
	@RequestMapping(value = "userDetail/{id}")
    public String userDetail(@PathVariable("id") int id, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "userDetail", "start");	
			Users user = us.getUserById(id)
			  .orElseThrow(() -> new IllegalArgumentException("Invalid user Id:" + id));
			log.info("user : {}", user);
			
			History pHistory = new History();
			pHistory.setBig_code(user.getBig_code());
			pHistory.setTarget_id(user.getId());
			History history = hs.getLatestHistory(pHistory);
			if( history != null) {
				log.info("history : {}", history);				
			}
			model.addAttribute("history", history);
			model.addAttribute("user", user);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "userDetail", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "userDetail", "end");
		}
        return "admin/user/userDetail";
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
	
	@RequestMapping("/updateUser")
    public String updateUser( Users user,History history, Model model) {
        String url = "";
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "updateUser", "start");	
			log.info("user:{}",user.toString());
			int result = us.updateUser(user);
			if(result  == 1) {
				log.info("history:{}",history.toString());
				if(history.getTitle() != null && history.getTitle() != "") {
					int hsResult = hs.insertHistory(history);
					log.info("history insert result:{}",hsResult);
				}
			}
			log.info("result : {}",result);
			model.addAttribute("user", user);
			

			/* 1:ADMIN 2:USER 3:BIZ */
			int role = us.getLoggedInUserRole();
			log.info("role:{}",role);
			switch (role) {
				case 1: 
					url ="/admin/user/userDetail/"+user.getId();
					break;
				case 2: 
					url= "/user/myPage";
					break;
				case 3:
					break;
	
				default:
					url ="/admin/user/userDetail/"+user.getId();
					break;
			}
			
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId,  "updateUser", e.getMessage());
		}finally {
			log.info("[{}]{}:{}",transactionId, "updateUser", "end");
		}		
        return "redirect:"+url;
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
			model.addAttribute("currentPage", currentPage);
			
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
			log.info("[{}]{}:{}", transactionId, "admin favoriteSearch", "end");
		}
				
		return "admin/user/favoriteList";
	}
	
	
	@RequestMapping(value = "favoriteInsertForm")
	public String favoriteInsertForm() {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin favoriteInsertForm", "Start");
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin favoriteInsertForm Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin favoriteInsertForm", "End");
		}
			
		return "admin/user/favoriteInsertForm";
	}
	
	
	@RequestMapping(value = "favorite/insert")
	public String favoriteInsert(Model model, Favorite favorite) {
		UUID transactionId = UUID.randomUUID();
		
		int result = fas.insertFavorite(favorite);
		
		if(result>0) {
			return "redirect:/admin/user/favorite";
		} else {
			model.addAttribute("msg", "입력실패 확인해보세요");
			return "forward:favoriteInsertForm";
		}
	}
	
	
	@RequestMapping(value = "favoriteDelete")
	public String favoriteDelete(Favorite favorite, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin favoriteDelete", "start");;
			int result = fas.deleteFavorite(favorite);
		
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin favoriteDelete Exception", e.getMessage());
		
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin favoriteDelete", "end");
		}
		
		return "redirect:favoriteList";	
	} 
	
	
	@RequestMapping(value = "favoriteUpdateForm")
	public String favoriteUpdateForm(Model model, Favorite favorite, String currentPage, HttpServletRequest request) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin favoriteUpdateForm", "start" );
			String create_at = request.getParameter("create_at");
			
			log.info("user_id -> {}", favorite.getUser_id());
			log.info("id -> {}", favorite.getContent_id());
			log.info("create_at -> {}", favorite.getCreate_at());
			
			Favorite favoriteDetail = fas.detailFavorite(favorite);
						
			model.addAttribute("favoriteDetail", favoriteDetail);
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("create_at", create_at);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin favoriteUpdateForm Exception", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin favoriteUpdateForm", "end");
		}
		return "admin/user/favoriteUpdateForm";
	}
	
	
	@RequestMapping(value = "favoriteUpdate")
	public String favoriteUpdaete(Model model, Favorite favorite, String currentPage) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "admin favoriteUpdate", "start" );
			int result = fas.updateFavorite(favorite);
			log.info("admin favoriteUpdate result ->" + result);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "admin favoriteUpdate Exception", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "admin favoriteUpdate", "end");
		}
		return "redirect:/admin/user/favoriteList";
	}
		
	
}
