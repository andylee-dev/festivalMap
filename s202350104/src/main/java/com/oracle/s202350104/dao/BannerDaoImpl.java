package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class BannerDaoImpl implements BannerDao {

	private final SqlSession session;
	
	// Paging 처리용
	@Override
	public int bannerCount() {

		int countBanner = 0;

		try {
			countBanner = session.selectOne("bannerCount");
		} catch (Exception e) {
			log.error("BoardDao boardCount Exception : {}", e.getMessage());
		}

		return countBanner;
	}
	
	// Footer Logic
	@Override
	public List<Banner> getFooterBanner() {
		log.info("BannerDao getFooterBanner Start!!");
		
		List<Banner> bannerFooter = null;
		
		try {
			bannerFooter = session.selectList("footerBanner");
			log.info("BannerDao bannerFooter URL : {}", bannerFooter.get(0).getUrl());
		} catch (Exception e) {
			log.error("BannerDao getFooterBanner Exception : {}", e.getMessage());
		} finally {
			log.info("BannerDao getFooterBanner End..");
		}

		return bannerFooter;
	}
	
	// Header Logic	
	@Override
	public List<Banner> getHeaderBanner() {
		log.info("BannerDao getHeaderBanner Start!!");
		
		List<Banner> bannerHeader = null;
		
		try {
			bannerHeader = session.selectList("headerBanner");
			log.info("BannerDao bannerFooter URL : {}", bannerHeader.get(0).getUrl());
		} catch (Exception e) {
			log.error("BannerDao getHeaderBanner Exception : {}", e.getMessage());
		} finally {
			log.info("BannerDao getHeaderBanner End..");
		}
		
		return bannerHeader;
	}
	
	@Override
	public List<Banner> getBannerAllList(Board board) {
		log.info("BannerDao getBannerAllList Start!!");
		
		List<Banner> bannerAllList = null;
		
		try {
			bannerAllList = session.selectList("bannerAllList", board);
			log.info("BannerDao bannerAllList size : {}", bannerAllList.size());
		} catch (Exception e) {
			log.error("BannerDao getBannerAllList Exception : {}", e.getMessage());
		} finally {
			log.info("BannerDao getBannerAllList End..");
		}
		
		return bannerAllList;
	}

}
