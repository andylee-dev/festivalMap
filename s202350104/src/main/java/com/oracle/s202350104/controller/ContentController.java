package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.service.ContentSerivce;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ContentController {

	private ContentSerivce contentService;

	@RequestMapping(value = "/")
	public String home() {
		return "home";
	}
	
	@RequestMapping(value = "/contentListAll")
	public String listContents(Contents contents, String currentPage, Model model) {
		log.info("ContentController contentListAll start...");
		try {
			List<Contents> listContents = contentService.listContents();
			log.info("ContentController contentListAll listContents.size() ->" + listContents.size());
			
			model.addAttribute("listContents", listContents);
			
		} catch (Exception e) {
			log.error("ContentController contentListAll e.getMessage() ->" + e.getMessage());
		} finally {
			log.info("ContentController contentListAll end...");
		}
		return "content/contentListAll";
	}

}
