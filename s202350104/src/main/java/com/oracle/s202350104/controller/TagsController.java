package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.service.FestivalsService;
import com.oracle.s202350104.service.TagsService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class TagsController {

	private final TagsService ts;
	
	
	// 하나의 컨텐츠가 가진 tag들을 모두 불러와 view단으로 전달(contentTags)
	@ResponseBody
	@RequestMapping(value = "/getMyContentTags")
	public List<Tags> getMyContentTags(int contentId) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> contentTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getMyContentTags", "start");
			contentTags = ts.searchContentTags(contentId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getMyContentTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getMyContentTags", "end");
		}
		
		return contentTags;
	}
	
	// 하나의 게시글이 가진 tag들을 모두 불러와 view단으로 전달(boardTags)
	@ResponseBody
	@RequestMapping(value = "/getMyBoardTags")
	public List<Tags> getMyBoardTags(int boardId) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> boardTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getMyBoardTags", "start");
			boardTags = ts.searchBoardTagsOne(boardId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getMyBoardTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getMyBoardTags", "end");
		}
		
		return boardTags;
	}
	
	// 하나의 코스가 가진 tag들을 모두 불러와 view단으로 전달(courseTags)
	@ResponseBody
	@RequestMapping(value = "/getMyCourseTags")
	public List<Tags> getMyCourseTags(int courseId) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> courseTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getMyCourseTags", "start");
			courseTags = ts.searchCourseTags(courseId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getMyCourseTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getMyCourseTags", "end");
		}
		
		return courseTags;
	}
	
	// 한 명의 유저가 저장한 tag들을 모두 불러와 view단으로 전달(userTags)
	@ResponseBody
	@RequestMapping(value = "/getMyUserTags")
	public List<Tags> getMyUserTags(int userId) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> userTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getMyUserTags", "start");
			userTags = ts.searchUserTagsOne(userId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getMyUserTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getMyUserTags", "end");
		}
		
		return userTags;
	}
	
	// 검색 조건에 따라 해당하는 전체 태그 리스트를 불러와 전달(AJAX 연결)
	@ResponseBody
	@RequestMapping(value = "/getAllTags")
	public List<Tags> getAllTags() {
		UUID transactionId = UUID.randomUUID();
		List<Tags> allTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getAllTags", "start");
			Tags tags = new Tags();
			allTags = ts.listTags(tags);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getAllTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getAllTags", "end");
		}
		
		return allTags;
	}
	
}
