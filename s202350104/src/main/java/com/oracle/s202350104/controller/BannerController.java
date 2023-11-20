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
	public String bannerInsert(Banner banner, MultipartFile file, Model model) throws IOException, Exception {
		
		// value 확인용
		log.info("BannerController bannerInsert bigCode : {}", banner.getBig_code());
		log.info("BannerController bannerInsert smallCode : {}", banner.getSmall_code());	
		log.info("BannerController bannerInsert getImage : {}", banner.getImage());
		log.info("BannerController bannerInsert getOriginalFilename : {}", file.getOriginalFilename().length());
		
		// File upload Logic
        UUID uuid = UUID.randomUUID();		
		String pathDB = null;
		String fileName = null;
		String realPath = null;		
		File savaFile = null;
		int realName = file.getOriginalFilename().length();
		
		
		try {
			log.info("BannerController bannerInsert File Start!!");
			// 파일 값이 있으면 저장
			if(realName > 0) {
				fileName = "..\\image\\" + uuid + "_" + file.getOriginalFilename();
				
				//컬럼 확장용
				pathDB = "..\\image\\";
				
				realPath = System.getProperty("user.dir") + "\\src\\main\\webapp\\image";
				
				savaFile = new File(realPath, fileName);
				
				log.info("BannerController fileName : {}", fileName);
				log.info("BannerController pathDB : {}", pathDB);
				log.info("BannerController realPath : {}", realPath);
				log.info("BannerController savaFile : {}", savaFile);
				
				file.transferTo(savaFile);
			} else {
				log.info("BannerController bannerInsert File Save False! = Null!");		
			}			

		} catch (Exception e) {
			log.error("BannerController File upload error : {}", e.getMessage());
		} finally {
			log.info("BannerController bannerInsert File End..");
		}		
		
		// 배너 생성 Logic(초기화)		
		String resultUrl = "";
		int insertBoard = 0;
				
		if(realName > 0) {
			log.info("BannerController bannerInsert imageInsert Start!!");
			// File명, 경로 setting
			banner.setImage(fileName);	
			insertBoard = bannerService.bannerInsert(banner);
			
		} else {
			log.info("BannerController bannerInsert normalInsert Start!!");
			insertBoard = bannerService.bannerInsert(banner);
		}
		
		// 배너 생성 후 Page Handling		
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
		// value 확인용
		log.info("BannerController bannerDelete id : {}", id);

		// 원본 File 삭제 Logic
		Banner banner = null;
		String path = null;
		String fileName = null;
		File deleteFile = null;
		
		try {
			log.info("BannerController bannerDelete File start!");
			// DB에 저장 된 파일명 조회
			banner = bannerService.bannerRead(id);
			
			// 실제 경로 
			path = System.getProperty("user.dir") + "\\src\\main\\webapp\\image";
			
			// DB에 저장 된 파일명 가져오기
			fileName = banner.getImage();
			
			// 구현체 생성(실  경로 + 파일명)
			deleteFile = new File(path, fileName);
			
			// 원본 File 삭제
			deleteFile.delete();
		} catch (Exception e) {
			log.error("BannerController bannerDelete File : {}", e.getMessage());
		} finally {
			log.info("BannerController bannerDelete File End..");
		}
		
		// DB 삭제 Logic
		String redirectURL = "";
		int deleteBanner = 0;
		
		try {
		 	log.info("BannerController bannerDelete Start!!");
			
		 	deleteBanner = bannerService.bannerDelete(id);
		 	
		 	// 삭제 결과값에 따라 redirect 경로 지정
			if (deleteBanner > 0) {
				redirectURL = "redirect:/admin/notice/banner";
				
			} else {
				model.addAttribute("msg", "삭제 실패!!, 관리자에게 문의해주세요.");
				redirectURL = "redirect:/admin/notice/banner";
			}
			
		} catch (Exception e) {
			log.error("BannerController bannerDelete File : {}", e.getMessage());
		}
		
		// 결과값에 따른 경로 이동
		return redirectURL;
	}
}
