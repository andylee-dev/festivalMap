package com.oracle.s202350104.controller;

import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.ExperienceContent;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;
import com.oracle.s202350104.service.AreaService;
import com.oracle.s202350104.service.BannerService;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.SpotService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class SpotController {
	
	private final SpotService ss;
	private final AreaService as;
	private final BoardService boardService;
	private final BannerService bannerService;
	
	/* 전체적으로 각 Method들이 무슨 기능을 하고 있는지 간략하게 주석을 남겨주시면 다른 분들도 이해하기 좋을 것  같아요.
	 * by.엄민용
	 */ 

	@RequestMapping(value = "spot")
	public String spot(SpotContent spotContent, String currentPage, Model model) {

		UUID transactionId = UUID.randomUUID();

		try {
			log.info("[{}]{}:{}", transactionId, "spot", "start");

			int totalSearchSpot = ss.totalSearchSpot(spotContent);

			Paging page = new Paging(totalSearchSpot, currentPage);
			spotContent.setStart(page.getStart());
			spotContent.setEnd(page.getEnd());

			List<SpotContent> listSpot = ss.listSpot(spotContent);
			List<Areas> listAreas = as.listAreas();

			model.addAttribute("totalSearchSpot", totalSearchSpot);
			model.addAttribute("listSpot", listSpot);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);

			/*
			 * Banner Logic 구간 by 엄민용
			 */
			List<Banner> bannerHeader = bannerService.getHeaderBanner();
			List<Banner> bannerFooter = bannerService.getFooterBanner();

			model.addAttribute("bannerHeader", bannerHeader);
			model.addAttribute("bannerFooter", bannerFooter);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "spot", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "spot", "end");
		}
		return "spot/spotList";
	}

	/*
	 * @ResponseBody
	 * 
	 * @RequestMapping(value = "getSigungu") public List<Areas> getSigungu() { UUID
	 * transactionId = UUID.randomUUID(); List<Areas> listAreas = null; try {
	 * log.info("[{}]{}:{}",transactionId, "getSigungu", "start"); listAreas =
	 * as.listPoint(); } catch (Exception e) { log.error("[{}]{}:{}",transactionId,
	 * "getSigungu", e.getMessage()); } finally {
	 * log.info("[{}]{}:{}",transactionId, "getSigungu", "end"); } return listAreas;
	 * }
	 */

	@RequestMapping(value = "spot/detail")
	public String spotDetail(int contentId, String currentPage, Board board, Model model) {

		UUID transactionId = UUID.randomUUID();

		SpotContent spot = null;

		try {
			log.info("[{}]{}:{}", transactionId, "spot/detail", "start");

			// 상세정보 Logic 구간
			spot = ss.detailSpot(contentId);

			model.addAttribute("spot", spot);

			/*
			 * review page handling용
			 * by 엄민용 
			 */
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("contentId", contentId);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "spot/detail", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "spot/detail", "end");
		}

		/*
		 * review Logic 구간 
		 * by 엄민용
		 * */
		log.info("SpotController review Start!!");
		
		int bigCode = 2;
		// 분류 code 강제 지정
		int smallCode = 6;
		int userId = 1;
		int countBoard = 0;
		
		// review별 count용
		board.setCommBigCode(spot.getBig_code());
		board.setCommSmallCode(spot.getSmall_code());

		try {
			// smallCode를 이용해 countBoard를 설정
			countBoard = boardService.boardCount2(board);

			// Paging 작업
			// Parameter board page 추가
			Paging page = new Paging(countBoard, currentPage);
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());
			board.setContent_id(contentId);
			
			List<Board> reviewAllList = boardService.getReviewAllList(board);
			
			log.info("SpotController reviewBoardList before board.getStart : {} ", board.getStart());
			log.info("SpotController reviewBoardList before board.getEnd : {} ", board.getEnd());
			log.info("SpotController reviewBoardList before board.getEnd : {} ", board.getContent_id());
			log.info("SpotController revicewAllList size : {}", reviewAllList.size());
			log.info("SpotController reviewBoardList after board.getStart : {} ", board.getStart());
			log.info("SpotController reviewBoardList after board.getEnd : {} ", board.getEnd());

			if(reviewAllList.size() != 0) {
				bigCode = reviewAllList.get(0).getBig_code();
			} else {
				log.error("SpotController review 값이 없습니다.");
			}

			log.info("SpotController reviewBoardList totalBoard : {} ", countBoard);
			log.info("SpotController reviewBoardList smallCode : {} ", smallCode);
			log.info("SpotController reviewBoardList page : {} ", page);

			model.addAttribute("reviewBoard", reviewAllList);
			model.addAttribute("page", page);
			model.addAttribute("bigCode", bigCode);
			model.addAttribute("smallCode", smallCode);
			model.addAttribute("userId", userId);
			
		} catch (Exception e) {
			log.error("SpotController reviewBoard error : {}", e.getMessage());
		} finally {
			log.info("SpotController reviewBoard end..");
		}
		
		return "spot/spotDetail";
	}

	@RequestMapping(value = "spot1")
	public String listSearch(SpotContent spotContent, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		try {
			log.info("[{}]{}:{}", transactionId, "spot", "start");
			int totalSearchSpot = ss.totalSearchSpot(spotContent);

			int small_code = spotContent.getSmall_code();
			int big_code = spotContent.getBig_code();
			String keyword = spotContent.getKeyword();

			Paging page = new Paging(totalSearchSpot, currentPage);
			spotContent.setStart(page.getStart());
			spotContent.setEnd(page.getEnd());

			// 테마별 조회
			List<SpotContent> listSpot = ss.listSpot3(spotContent);
			List<Areas> listAreas = as.listAreas();

			model.addAttribute("totalSpot", totalSearchSpot);
			model.addAttribute("listSpot", listSpot);
			model.addAttribute("listAreas", listAreas);
			model.addAttribute("page", page);
			model.addAttribute("small_code", small_code);
			model.addAttribute("big_code", big_code);
			model.addAttribute("keyword", keyword);

			/*
			 * Banner Logic 구간 by 엄민용
			 */
			List<Banner> bannerHeader = bannerService.getHeaderBanner();
			List<Banner> bannerFooter = bannerService.getFooterBanner();

			model.addAttribute("bannerHeader", bannerHeader);
			model.addAttribute("bannerFooter", bannerFooter);

		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "spot", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "spot", "end");
		}
		return "spot/spotList";
	}

}
