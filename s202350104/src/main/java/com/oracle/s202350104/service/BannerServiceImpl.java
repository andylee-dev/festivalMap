package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.s202350104.dao.BannerDao;
import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Transactional
@Slf4j
public class BannerServiceImpl implements BannerService {

	private final BannerDao bannerdao;

	// paging Logic
	@Override
	public int bannerCount() {

		int countbanner = 0;

		try {
			log.info("BoardService bannerCount Start!!");
			countbanner = bannerdao.bannerCount();

		} catch (Exception e) {
			log.error("BoardService bannerCount Error : {}", e.getMessage());

		} finally {
			log.info("BoardService bannerCount End..");
		}

		return countbanner;
	}

	// footer logic
	@Override
	public List<Banner> getFooterBanner() {

		List<Banner> bannerMain = null;

		try {
			log.info("BoardService getFooterBanner Start!!");

			bannerMain = bannerdao.getFooterBanner();

		} catch (Exception e) {
			log.error("BoardService getFooterBanner Error : {}", e.getMessage());
		} finally {
			log.info("BoardService getFooterBanner End..");
		}

		return bannerMain;
	}

	// header logic
	@Override
	public List<Banner> getHeaderBanner() {

		List<Banner> bannerHeader = null;

		try {
			log.info("BoardService getHeaderBanner Start!!");

			bannerHeader = bannerdao.getHeaderBanner();

		} catch (Exception e) {
			log.error("BoardService getHeaderBanner Error : {}", e.getMessage());
		} finally {
			log.info("BoardService getHeaderBanner End..");
		}

		return bannerHeader;
	}

	// 배너 조회 logic
	@Override
	public List<Banner> getBannerAllList(Board board) {

		List<Banner> bannerAllList = null;

		try {
			log.info("BoardService getBannerAllList Start!!");

			bannerAllList = bannerdao.getBannerAllList(board);

		} catch (Exception e) {
			log.error("BoardService getBannerAllList Error : {}", e.getMessage());
		} finally {
			log.info("BoardService getBannerAllList End..");
		}

		return bannerAllList;
	}

	// 배너 생성 logic
	@Override
	public int bannerInsert(Banner banner) {
		log.info("BoardService bannerInsert bigCode : {}", banner.getBig_code());
		log.info("BoardService bannerInsert smallCode : {}", banner.getSmall_code());	
		log.info("BoardService bannerInsert getImage : {}", banner.getImage());
		int insertbanner = 0;

		try {
			log.info("BoardService bannerInsert Start!!");

			insertbanner = bannerdao.bannerInsert(banner);

		} catch (Exception e) {
			log.error("BoardService bannerInsert Error : {}", e.getMessage());
		} finally {
			log.info("BoardService bannerInsert End..");
		}

		return insertbanner;
	}

	// 배너 삭제 logic
	@Override
	public int bannerDelete(int id) {

		int deletebanner = 0;

		try {
			log.info("BoardService bannerDelete Start!!");

			deletebanner = bannerdao.bannerDelete(id);

		} catch (Exception e) {
			log.error("BoardService bannerDelete Error : {}", e.getMessage());
		} finally {
			log.info("BoardService bannerDelete End..");
		}

		return deletebanner;
	}
	
	// 배너 첨부파일 삭제 logic	
	@Override
	public Banner bannerRead(int id) {
		
		Banner banner = bannerdao.bannerRead(id);
		
		return banner;
	}
	
	@Override
	public int bannerUpdate(Banner banner) {
		int updateBanner = bannerdao.bannerUpdate(banner);
		return updateBanner;
	}
	
	@Override
	public int bannerRecycle(int id) {
		int recycleBanner = bannerdao.bannerRecycle(id);
		return recycleBanner;
	}
}
