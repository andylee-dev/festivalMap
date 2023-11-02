package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.CommonCodeService;
import com.oracle.s202350104.service.Paging;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/admin/*")
public class AdminAdminController {
	
	private final CommonCodeService ccs;
	// private final AreaService as;
	
	
	@RequestMapping(value = "/adminList")
	public String adminList() {
			
		return "admin/admin/adminList";
	}
	
	@RequestMapping(value = "/areaCode")
	public String areaCode() {
		
		return "admin/admin/areaCode";
	}
	
	@RequestMapping(value = "/commonCode")
	public String commonCode(CommonCodes commonCode, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "commonCode", "start");
			int totalCommonCode = ccs.totalCommonCode();
			
			Paging page = new Paging(totalCommonCode, currentPage);
			commonCode.setStart(page.getStart());
			commonCode.setEnd(page.getEnd());
			
			List<CommonCodes> listCommonCode = ccs.listCommonCode(commonCode);
			
			model.addAttribute("totalCommonCode", totalCommonCode);
			model.addAttribute("listCommonCode", listCommonCode);
			model.addAttribute("page", page);
			
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "commonCode", e.getMessage());
		} finally {
			log.error("[{}]{}:{}", transactionId, "commonCode", "end");
		}
		
		
		return "admin/admin/commonCode";
	}
	
	
}
