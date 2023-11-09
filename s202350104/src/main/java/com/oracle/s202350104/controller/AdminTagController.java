package com.oracle.s202350104.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.print.attribute.HashAttributeSet;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.CommonCodeService;
import com.oracle.s202350104.service.ContentSerivce;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PagingList;
import com.oracle.s202350104.service.TagsService;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/tag")
public class AdminTagController {

	private final TagsService ts;
	private final CommonCodeService ccs;
	private final ContentSerivce cs;
	private final BoardService bs;
	private final UserService us;
	
	@RequestMapping(value = "list")
	public String tagList(Tags tags, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "tagList", "start");
			int totalTags = ts.totalTags();
			
			PagingList page = new PagingList(totalTags, currentPage);
			tags.setStart(page.getStart());
			tags.setEnd(page.getEnd());
			
			List<Tags> listTags = ts.listTags(tags);
			
			model.addAttribute("totalTags", totalTags);
			model.addAttribute("listTags", listTags);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "tagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "tagList", "end");
		}		
		
		return "admin/tag/tagList";
	}
	
	@RequestMapping(value = "insertTagsForm")
	public String insertTagsForm(Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "insertTagsForm", "start");
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "insertTagsForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "insertTagsForm", "end");
		}		
		
		return "admin/tag/insertTagsForm";
	}
	
	@RequestMapping(value = "insertTagsResult")
	public String insertTagsResult(Tags tags, Model model) {
		UUID transactionId = UUID.randomUUID();
		int result = 0;
		try {
			log.info("[{}]{}:{}",transactionId, "insertTagsResult", "start");
			result = ts.insertTags(tags);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "insertTagsResult", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "insertTagsResult", "end");
		}	
		
		if(result > 0) {
			return "redirect:list";
		} else if(result == -1) {
			model.addAttribute("msg", "이미 존재하는 태그입니다.");
			return "forward:insertTagsForm";
		} else {
			model.addAttribute("msg", "등록에 실패하였습니다.");
			return "forward:insertTagsForm";
		}
	}
	
	@RequestMapping(value = "updateTagsForm")
	public String updateTagsForm(int id, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "updateTagsForm", "start");
			Tags tags = ts.selectTags(id);
			model.addAttribute("tags", tags);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "updateTagsForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "updateTagsForm", "end");
		}		
		
		return "admin/tag/updateTagsForm";
	}
	
	@PostMapping(value = "updateTagsResult") 
	public String updateTagsResult(Tags tags, Model model) { 
		 UUID transactionId = UUID.randomUUID(); 
		 int result = 0;
		 try { 
			 log.info("[{}]{}:{}",transactionId, "updateTagsResult", "start");
			 result = ts.updateTags(tags); 
		 } catch (Exception e) {
			 log.error("[{}]{}:{}",transactionId, "updateTagsResult", e.getMessage()); 
		 } finally { 
			 log.info("[{}]{}:{}",transactionId, "updateTagsResult", "end"); 
		 }
	  
		 if(result > 0) { 
			 return "redirect:list"; 
		 } else if(result == -1) {
			 model.addAttribute("msg", "이미 존재하는 태그입니다."); 
			 return "forward:updateTagsForm"; 
		 } else { 
			 model.addAttribute("msg", "등록에 실패하였습니다."); 
			 return "forward:updateTagsForm"; 
		 } 
	}
	  
	@ResponseBody
	@RequestMapping(value = "deleteTags")
	public String deleteTags(Tags tags) {
		int result = ts.deleteTags(tags.getId());
		String resultStr = Integer.toString(result);
		return resultStr;
	}
	 
	
	@RequestMapping(value = "userTag")
	public String userTagList(Users user, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "userTagList", "start");
			user.setSmall_code(2);  
			int totalUsers = us.totalUsers(user); // 일반회원만
			
			log.info("totalUsers => " + totalUsers);
			
			PagingList page = new PagingList(totalUsers, currentPage);
			user.setStart(page.getStart());
			user.setEnd(page.getEnd());
			
			List<Users> listUsers = us.getSearchUserList(user); // 일반회원만
			
			log.info("listUsers => " + listUsers.size());
			
			model.addAttribute("totalUsers", totalUsers);
			model.addAttribute("listUsers", listUsers);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "userTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "userTagList", "end");
		}	
		
		return "admin/tag/userTag";
	}
	
	@ResponseBody
	@RequestMapping(value = "getUserTags")
	public List<Tags> getUserTags(Model model) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> listTags = null;
		try {
			log.info("[{}]{}:{}",transactionId, "getUserTags", "start");
			listTags = ts.listUserTags();
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "getUserTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "getUserTags", "end");
		}	
		return listTags;
	}
	
	@RequestMapping(value = "boardTag")
	public String boardTagList(Board board, String smallCodeStr, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		int smallCode = 0;
		if(smallCodeStr == null) {
			smallCode = 2;
		} else {
			smallCode = Integer.parseInt(smallCodeStr);
		}
		
		log.info("controller smallCode => " +smallCode);
		
		try {
			log.info("[{}]{}:{}",transactionId, "boardTagList", "start");
			
			List<Board> listBoard = null;
			
			int totalBoard = bs.boardCount(smallCode);
			log.info("controller totalBoard => " +totalBoard);
			
			PagingList page = new PagingList(totalBoard, currentPage);
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());
				
			switch(smallCode) {
				case 2: listBoard = bs.getMagazinAllList(board); break;
				case 3: listBoard = bs.getFreeAllList(board); break;
				case 4: listBoard = bs.getPhotoAllList(board); break;
				case 5: listBoard = bs.getEventAllList(board); break;
				case 6: listBoard = bs.getReviewAllList(board);
			}
			log.info("controller listBoard => " +listBoard.size());
			
			model.addAttribute("totalBoard", totalBoard);
			model.addAttribute("listBoard", listBoard);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "boardTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "boardTagList", "end");
		}		
		
		return "admin/tag/boardTag";
	}
	
	@ResponseBody
	@RequestMapping(value = "getBoardTags")
	public List<Tags> getBoardTags(String smallCodeStr, Model model) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> listTags = null;
		try {
			log.info("[{}]{}:{}",transactionId, "getBoardTags", "start");
			int smallCode = Integer.parseInt(smallCodeStr);
			log.info("smallCode=>" + smallCode);
			listTags = ts.listBoardTags(smallCode);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "getBoardTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "getBoardTags", "end");
		}	
		return listTags;
	}
	
	@RequestMapping(value = "contentTag")
	public String contentTagList(Contents content, String bigCodeStr, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		int bigCode = 0;
		if(bigCodeStr == null) {
			bigCode = 2;
		} else {
			bigCode = Integer.parseInt(bigCodeStr);
		}
		
		try {
			log.info("[{}]{}:{}",transactionId, "contentTagList", "start");

		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "contentTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "contentTagList", "end");
		}	
		
		return "admin/tag/contentTag";
	}
	
	@RequestMapping(value = "insertContentTagForm")
	public String insertContentTagForm(Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "insertContentTagForm", "start");
			List<CommonCodes> listCodes = ccs.listCommonCode();
			model.addAttribute("listCodes", listCodes);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "insertContentTagForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "insertContentTagForm", "end");
		}	
		return "admin/tag/insertContentTagForm";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getSmallCode")
	public List<CommonCodes> getSmallCode() {
		UUID transactionId = UUID.randomUUID();
		List<CommonCodes> listCodes = null;
		try {
			log.info("[{}]{}:{}",transactionId, "getSmallCode", "start");
			listCodes = ccs.listCommonCode();
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "getSmallCode", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "getSmallCode", "end");
		}
		return listCodes;
	}
	
	@ResponseBody
	@RequestMapping(value = "/getContent")
	public List<Contents> getContent(CommonCodes code) {
		UUID transactionId = UUID.randomUUID();
		List<Contents> listContents = null;
		try {
			log.info("[{}]{}:{}",transactionId, "getContent", "start");
			// listContents = cs.listCommonCode();
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "getContent", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "getContent", "end");
		}
		return listContents;
	}
	
}
