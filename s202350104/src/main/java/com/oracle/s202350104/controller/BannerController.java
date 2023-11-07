package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	public String bannerInsert(Banner Banner, Model model) {

		log.info("BannerController bannerInsert bigCode : {}", Banner.getBig_code());
		log.info("BannerController bannerInsert smallCode : {}", Banner.getSmall_code());

		int insertBoard = bannerService.bannerInsert(Banner);

		if (insertBoard > 0) {
			return "redirect:/admin/notice/banner";
		} else {
			model.addAttribute("msg", "글쓰기 실패!, 다시 입력해주세요.");
			return "forward:/bannerInsertForm";
		}
	}

	// 통합게시판 삭제 Logic
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
