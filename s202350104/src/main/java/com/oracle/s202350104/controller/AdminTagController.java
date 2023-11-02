package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PagingList;
import com.oracle.s202350104.service.TagsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/tag")
public class AdminTagController {

	private final TagsService ts;
	
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
	
	@RequestMapping(value = "userTag")
	public String userTagList(Tags tags, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "userTagList", "start");
			int totalTags = ts.totalUserTags();
			
			PagingList page = new PagingList(totalTags, currentPage);
			tags.setStart(page.getStart());
			tags.setEnd(page.getEnd());
			
			List<Tags> listTags = ts.listUserTags(tags);
			
			model.addAttribute("totalTags", totalTags);
			model.addAttribute("listTags", listTags);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "userTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "userTagList", "end");
		}	
		
		return "admin/tag/userTag";
	}
	
	@RequestMapping(value = "boardTag")
	public String boardTagList(Tags tags, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "userTagList", "start");
			int totalTags = ts.totalBoardTags();
			
			PagingList page = new PagingList(totalTags, currentPage);
			tags.setStart(page.getStart());
			tags.setEnd(page.getEnd());
			
			List<Tags> listTags = ts.listBoardTags(tags);
			
			model.addAttribute("totalTags", totalTags);
			model.addAttribute("listTags", listTags);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "userTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "userTagList", "end");
		}		
		
		return "admin/tag/boardTag";
	}
	
	@RequestMapping(value = "contentTag")
	public String contentTagList(Tags tags, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}",transactionId, "userTagList", "start");
			int totalTags = ts.totalContentTags();
			
			PagingList page = new PagingList(totalTags, currentPage);
			tags.setStart(page.getStart());
			tags.setEnd(page.getEnd());
			
			List<Tags> listTags = ts.listContentTags(tags);
			
			model.addAttribute("totalTags", totalTags);
			model.addAttribute("listTags", listTags);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "userTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "userTagList", "end");
		}	
		
		return "admin/tag/contentTag";
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
	 
}
