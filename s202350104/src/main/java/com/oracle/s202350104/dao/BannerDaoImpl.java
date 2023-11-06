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
	public List<Banner> getFooterBanner() {
		List<Banner> bannerFooter = session.selectList("footerBanner");
		log.info("BannerDao bannerFooter URL : {}", bannerFooter.get(0).getUrl());
		return bannerFooter;
	}
}
