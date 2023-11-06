package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;

public interface BannerDao {

	List<Banner> getFooterBanner();

	List<Banner> getHeaderBanner();

	List<Banner> getBannerAllList(Board board);

	int bannerCount();

}
