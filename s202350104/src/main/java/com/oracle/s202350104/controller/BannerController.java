package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.service.BannerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class BannerController {

	private final BannerService bannerService;

	@RequestMapping(value = "/banner")
	public String bannerList(Model model) {

		List<Banner> bannerAllList = bannerService.getBannerAllList();

		model.addAttribute("banner", bannerAllList);

		return "/banner/bannerList";
	}

	@RequestMapping(value = "/mainBanner")
	public String mainBanner(Model model) {

		String bannerUrl = "";

		List<Banner> bannerMain = bannerService.getMainBanner();

		bannerUrl = bannerMain.get(0).getUrl();
		log.info("BannerController mainBanner bannerUrl : {}", bannerUrl);

		model.addAttribute("bannerUrl", bannerUrl);
		model.addAttribute("banner", bannerMain);

		return "redirect:/";
	}
}
