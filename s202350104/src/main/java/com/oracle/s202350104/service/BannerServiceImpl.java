package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.BannerDao;
import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BannerServiceImpl implements BannerService{
	
	private final BannerDao bannerdao;
	
	@Override
	public int bannerCount() {
		
		int countbanner = bannerdao.bannerCount();
		
		return countbanner;
	}
	
	@Override
	public List<Banner> getFooterBanner() {
		
		List<Banner> bannerMain = bannerdao.getFooterBanner();
		
		return bannerMain;
	}
	
	@Override
	public List<Banner> getHeaderBanner() {
		
		List<Banner> bannerHeader = bannerdao.getHeaderBanner();
		
		return bannerHeader;
	}
	
@Override
	public List<Banner> getBannerAllList(Board board) {
		
		List<Banner> bannerAllList = bannerdao.getBannerAllList(board);
		
		return bannerAllList;
	}
}
