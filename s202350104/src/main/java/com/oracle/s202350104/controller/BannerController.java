package com.oracle.s202350104.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.service.BannerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BannerController {

	private final BannerService bannerService;

	// Banner 생성 form Logic
	@RequestMapping(value = "/bannerInsertForm")
	public String bannerInsertForm(String userId, String bigCode, String smallCode, Model model) {

		log.info("BannerController bannerInsertForm start!");
		log.info("BannerController bannerInsertForm userId : {}", userId);
		log.info("BannerController bannerInsertForm bigCode : {}", bigCode);
		log.info("BannerController bannerInsertForm smallCode : {}", smallCode);

		model.addAttribute("userId", userId);
		model.addAttribute("bigCode", bigCode);
		model.addAttribute("smallCode", smallCode);

		log.info("BannerController bannerInsertForm end!");

		return "banner/bannerInsertForm";
	}

	// Banner 생성 Logic
	@RequestMapping(value = "/bannerInsert")
	public String bannerInsert(Banner Banner, MultipartFile file, Model model) throws IOException, Exception {

		log.info("BannerController bannerInsert bigCode : {}", Banner.getBig_code());
		log.info("BannerController bannerInsert smallCode : {}", Banner.getSmall_code());	
		
		String resultUrl = "";
		
		int insertBoard = bannerService.bannerInsert(Banner);
		
		if (insertBoard > 0) {
			resultUrl = "redirect:/admin/notice/banner";
		} else {
			model.addAttribute("msg", "글쓰기 실패!, 다시 입력해주세요.");
			resultUrl = "forward:/bannerInsertForm";
		}
		
		return resultUrl;		
	}

	// Banner 삭제 Logic
	@RequestMapping(value = "/bannerDelete")
	public String bannerDelete(int id, Model model) {

		//log.info("BannerController bannerDelete small_code : {}", smallCode);
		log.info("BannerController bannerDelete id : {}", id);
		//log.info("BannerController bannerDelete userId : {}", userId);

		int deleteBanner = bannerService.bannerDelete(id);

		String redirectURL = "";

		if (deleteBanner > 0) {
			redirectURL = "redirect:/admin/notice/banner";
		} else {
			model.addAttribute("msg", "삭제 실패!!, 관리자에게 문의해주세요.");
			redirectURL = "redirect:/admin/notice/banner";
		}
		return redirectURL;
	}
}
