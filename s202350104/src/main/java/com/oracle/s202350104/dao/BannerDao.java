package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Banner;

public interface BannerDao {

	List<Banner> getBannerAllList();

	List<Banner> getMainBanner();

}
