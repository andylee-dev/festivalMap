package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

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
	
	@Override
	public List<FestivalsContent> listFestivals(FestivalsContent festival) {
		List<FestivalsContent> listFestivals = fd.listFestivals(festival);

		if(listFestivals == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 리스트가 존재하지 않습니다.");
		}

		return listFestivals;
	}

	@Override
	public FestivalsContent detailFestivals(int contentId) {
		FestivalsContent festival = fd.detailFestivals(contentId);
		
		return festival;
	}

	@Override
	public int totalFestivals() {
		int totalFestCnt = fd.totalFestivals();
		return totalFestCnt;
	}

}
