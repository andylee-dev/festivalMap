package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.service.Paging;
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
			
			Paging page = new Paging(totalTags, currentPage);
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
			
			Paging page = new Paging(totalTags, currentPage);
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
			
			Paging page = new Paging(totalTags, currentPage);
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
			
			Paging page = new Paging(totalTags, currentPage);
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
}
