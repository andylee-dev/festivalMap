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
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.ContentSerivce;
import com.oracle.s202350104.service.PagingList;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ContentController {
	private final BoardService boardService;
	private final BannerService bannerService;
	private final ContentSerivce contentService;
	
	/* 전체적으로 각 Method들이 무슨 기능을 하고 있는지 간략하게 주석을 남겨주시면 다른 분들도 이해하기 좋을 것  같아요.
	 * by.엄민용
	 */ 

	@RequestMapping(value = "/")
	public String home(Model model) {	
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}",transactionId, "home", "start");
			List<Banner> bannerFooter = bannerService.getFooterBanner();	
			model.addAttribute("bannerFooter", bannerFooter); 
			Board board = new Board();
			board.setStart(0);
			board.setEnd(2);
			List<Board> magazineList  = boardService.getMagazinAllList(board); 
			model.addAttribute("magazineList", magazineList);
			log.info("magazineList[0]:{}",magazineList.get(0));
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "home", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "home", "end");
		}		
		
		return "home";
	}
	
	
	@ResponseBody
    @RequestMapping(value = "/api/content", method = RequestMethod.GET)
    public List<Contents> getContentsList(Contents content) {
		UUID transactionId = UUID.randomUUID();
		List<Contents> contentList =null;
		try {
			log.info("[{}]{}:{}",transactionId, "getContentsList", "start");
	        contentList = contentService.listContents(content);
		} catch (Exception e) {
			log.error("[{}]{}:{}",transactionId, "getContentsList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}",transactionId, "getContentsList", "end");
		}		
        return contentList;
    }

	@ResponseBody
	@RequestMapping(value = "/content/searchContents", method = RequestMethod.POST)
    public List<Contents> searchContentsList(@RequestBody Contents contents, String currentPage) {
		UUID transactionId = UUID.randomUUID();
		List<Contents> contentList =null;
		try {
			log.info("[{}]{}:{}",transactionId, "searchContentsList", "start");
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
