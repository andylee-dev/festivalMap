package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.ContentSerivce;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ContentController {
	
	private final BannerService bannerService;
	private final ContentSerivce contentService;

	@RequestMapping(value = "/")
	public String home(Model model) {	
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "home", "start");
			List<Banner> bannerFooter = bannerService.getFooterBanner();	
			model.addAttribute("bannerFooter", bannerFooter); 
		
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "home", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "home", "end");
		}		
		
		return "home";
	}

	@ResponseBody
    @RequestMapping(value = "/api/content", method = RequestMethod.GET)
    public List<Contents> getContentsList() {
		UUID transactionId = UUID.randomUUID();
		List<Contents> contentList =null;
		try {
			log.info("[{}]{}:{}",transactionId, "getContentsList", "start");
	        contentList = contentService.listContents();
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "getContentsList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "getContentsList", "end");
		}		
        return contentList;
    }

	/*TODO : big_code/small_code/area*/	
	@ResponseBody
	@RequestMapping(value = "/api/searchContents", method = RequestMethod.POST)
    public List<Contents> searchContentsList(@RequestBody Contents contents) {
		UUID transactionId = UUID.randomUUID();
		List<Contents> contentList =null;
		try {
			log.info("[{}]{}:{}",transactionId, "searchContentsList", "start");
			/* TODO :  contents filter list*/
			log.info("{}",contents.toString());
			
			contentList = contentService.getSearchContentsList(contents);
			log.info("contentList:{}",contentList.toString());

		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "searchContentsList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "searchContentsList", "end");
		}		
        return contentList;
    }
	
	
	
}
