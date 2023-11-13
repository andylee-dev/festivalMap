package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.ContentSerivce;
import com.oracle.s202350104.service.PagingList;

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

	@ResponseBody
	@RequestMapping(value = "/api/searchContents", method = RequestMethod.POST)
    public List<Contents> searchContentsList(@RequestBody Contents contents, String currentPage) {
		UUID transactionId = UUID.randomUUID();
		List<Contents> contentList =null;
		try {
			log.info("[{}]{}:{}",transactionId, "searchContentsList", "start");
			log.info("{}",contents.toString());
//			int totalContents = contentService.getTotalSearchCount(contents);
//			log.info("totalContents:{}",totalContents);
//			PagingList page = new PagingList(totalContents, currentPage);
//			contents.setStart(page.getStart());
//			contents.setEnd(page.getEnd());
//			contents.setPageList(page);
			contentList = contentService.getSearchContentsList(contents);
			log.info("contentList.size():{}",contentList.size());
			
			
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "searchContentsList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "searchContentsList", "end");
		}		
        return contentList;
    }
}
