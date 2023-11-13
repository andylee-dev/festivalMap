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
	
	@ResponseBody
	@RequestMapping(value = "/getContentTags")
	public List<Tags> getContentTags(int contentId) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> contentTags = null;
		try {
			log.info("[{}]{}:{}", transactionId, "getContentTags", "start");
			contentTags = ts.searchContentTags(contentId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getContentTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getContentTags", "end");
		}
		return contentTags;
	}
	
}
