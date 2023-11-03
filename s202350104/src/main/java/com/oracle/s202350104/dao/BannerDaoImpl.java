package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Banner;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class BannerDaoImpl implements BannerDao {

	private final SqlSession session;

	@Override
	public List<Banner> getBannerAllList() {

		List<Banner> bannerAllList = null;

		try {
			bannerAllList = session.selectList("bannerAllList");
			log.info("BannerDao bannerAllList size : {}", bannerAllList.size());

		} catch (Exception e) {
			log.error("BannerDao getBannerAllList : {}", e.getMessage());
		}
		return bannerAllList;
	}

	@Override
	public List<Banner> getMainBanner() {
		List<Banner> bannerMain = session.selectList("mainBanner");
		log.info("BannerDao getMainBanner : {}", bannerMain.get(0).getUrl());
		return bannerMain;
	}
}
