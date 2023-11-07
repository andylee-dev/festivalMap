package com.oracle.s202350104.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.oracle.s202350104.model.Banner;
import com.oracle.s202350104.model.Board;

public interface BannerService {

	List<Banner> getFooterBanner();

	List<Banner> getHeaderBanner();

	List<Banner> getBannerAllList(Board board);

	int bannerCount();

	int bannerInsert(Banner banner, MultipartFile file) throws Exception;

	int bannerDelete(int id);

}
