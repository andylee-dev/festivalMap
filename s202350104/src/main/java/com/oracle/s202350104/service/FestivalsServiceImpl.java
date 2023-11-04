package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.ContentsDao;
import com.oracle.s202350104.dao.FestivalsDao;
import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FestivalsServiceImpl implements FestivalsService {
	
	private final FestivalsDao fd;
	private final ContentsDao cd;
	
	@Override
	public List<FestivalsContent> listFestivals(FestivalsContent festival) {
		List<FestivalsContent> listFestivals = fd.listFestivals(festival);
		
		/* 시도, 시군구 내용 확인
		 * for(FestivalsContent festi : listFestivals) {
		 * festi.setArea_content(ad.areaContent(festi.getArea()));
		 * festi.setSigungu_content(ad.sigunguContent(festi.getSigungu())); }
		 */

		if(listFestivals == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 리스트가 존재하지 않습니다.");
		}

		return listFestivals;
	}

	@Override
	public FestivalsContent detailFestivals(int contentId) {
		FestivalsContent festival = fd.detailFestivals(contentId);
		
		if(festival == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 축제 정보가 존재하지 않습니다.");
		}
		
		return festival;
	}

	@Override
	public int totalFestivals() {
		int totalFestCnt = fd.totalFestivals();
		return totalFestCnt;
	}

	@Override
	public void insertFestival(FestivalsContent festival) {
		int contentResult = 0;
		contentResult = fd.insertContent(festival);
		int festivalResult = 0;
		festivalResult = fd.insertFestival(festival);
		
		if(contentResult <= 0 || festivalResult <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 정보 등록에 실패하였습니다.");
		}

	}

}
