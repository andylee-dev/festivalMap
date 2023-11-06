package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.BannerDao;
import com.oracle.s202350104.model.Banner;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class BannerServiceImpl implements BannerService{
	
	private final BannerDao bannerdao;
	
	@Override
	public List<Banner> getFooterBanner() {
		
		List<Banner> bannerMain = bannerdao.getFooterBanner();
		
		return bannerMain;
	}
}
