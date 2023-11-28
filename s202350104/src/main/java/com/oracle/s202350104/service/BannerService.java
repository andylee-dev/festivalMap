package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;

public interface BannerService {

	List<Banner> getFooterBanner();

	List<Banner> getHeaderBanner();

	List<Banner> getBannerAllList(Banner banner);

	int bannerCount(Banner banner);

	int bannerInsert(Banner banner);

	int bannerDelete(int id);

	Banner bannerRead(int id);

	int bannerUpdate(Banner banner);

	int bannerRecycle(int id);



}
