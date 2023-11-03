package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Banner;

public interface BannerService {

	List<Banner> getBannerAllList();

	List<Banner> getMainBanner();

}
