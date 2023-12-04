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
	public int bannerCount(Banner banner) {

		int countBanner = 0;

		try {
			countBanner = session.selectOne("bannerCount", banner);
		} catch (Exception e) {
			log.error("BoardDao boardCount Exception : {}", e.getMessage());
		} finally {
			log.info("BannerDao boardCount End..");
		}

		return countBanner;
	}

	// Footer, DB연동
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

	// Header, DB연동
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

	// 배너 조회(ALL), DB연동
	@Override
	public List<Banner> getBannerAllList(Banner banner) {
		log.info("BannerDao getBannerAllList Start!!");

		List<Banner> bannerAllList = null;

		try {
			bannerAllList = session.selectList("bannerAllList", banner);

			log.info("BannerDao bannerAllList size : {}", bannerAllList.size());
		} catch (Exception e) {
			log.error("BannerDao getBannerAllList Exception : {}", e.getMessage());
		} finally {
			log.info("BannerDao getBannerAllList End..");
		}

		return bannerAllList;
	}

	// 배너 생성, DB연동
	@Override
	public int bannerInsert(Banner banner) {
		log.info("BannerDao bannerInsert Start!!");

		log.info("BannerDao bannerInsert bigCode : {}", banner.getBig_code());
		log.info("BannerDao bannerInsert smallCode : {}", banner.getSmall_code());
		log.info("BannerDao bannerInsert getImage : {}", banner.getImage());

		int insertBanner = 0;
		String insertHandling = banner.getImage();

		log.info("BannerDao bannerInsert insertHandling : {}", insertHandling);

		try {

			if (insertHandling != null) {
				log.info("BannerDao bannerInsert imageInsert Start!!");
				insertBanner = session.insert("bannerImageInsert", banner);

			} else {
				log.info("BannerDao bannerInsert normalInsert Start!!");
				insertBanner = session.insert("bannerNormalInsert", banner);
			}

		} catch (Exception e) {
			log.error("BannerDao bannerInsert Exception : {}", e.getMessage());
		} finally {
			log.info("BannerDao bannerInsert End..");
		}
		return insertBanner;
	}

	// 배너 삭제, DB연동
	@Override
	public int bannerDelete(int id) {
		log.info("BannerDao bannerDelete Start!!");

		int deleteBanner = 0;

		try {
			deleteBanner = session.delete("bannerDelete", id);

		} catch (Exception e) {
			log.error("BannerDao bannerDelete Exception : {}", e.getMessage());
		} finally {
			log.info("BannerDao bannerDelete End..");
		}
		return deleteBanner;
	}

	@Override
	public Banner bannerRead(int id) {

		Banner banner = null;

		try {
			log.info("BannerDao bannerRead Start!!");

			banner = session.selectOne("bannerRead", id);
			log.info("BannerDao bannerRead getTitle : {}", banner.getTitle());

		} catch (Exception e) {
			log.error("BannerDao bannerRead Exception : {}", e.getMessage());
		} finally {
			log.info("BannerDao bannerRead End..");
		}

		return banner;
	}

	@Override
	public int bannerUpdate(Banner banner) {
		int updateBanner = session.update("bannerUpdate", banner);
		return updateBanner;
	}

	@Override
	public int bannerRecycle(int id) {
		int recycleBanner = session.update("bannerRecycle", id);
		return recycleBanner;
	}
}
