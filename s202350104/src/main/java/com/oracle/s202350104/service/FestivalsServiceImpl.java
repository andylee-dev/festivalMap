package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.ContentsDao;
import com.oracle.s202350104.dao.FestivalsDao;
import com.oracle.s202350104.model.Contents;
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
	public int totalFestivals(FestivalsContent festival) {
		int totalFestCnt = fd.totalFestivals(festival);
		return totalFestCnt;
	}

	@Override
	public int insertFestival(FestivalsContent festival) {
		int result = fd.insertFestival(festival);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 정보 등록에 실패하였습니다.");
		}
		
		return result;

	}

	@Override
	public int deleteFestivals(int contentId) {
		int result = 0;
		result = fd.deleteFestivals(contentId);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 정보 삭제에 실패하였습니다.");
		}
		
		return result;
	}

	@Override
	public int approveFestival(int contentId) {
		int result = fd.approveFestival(contentId);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 정보 승인에 실패하였습니다.");
		}
		
		return result;
	}

	@Override
	public int updateFestival(FestivalsContent festival) {
		int result = fd.updateFestival(festival);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 정보 수정에 실패하였습니다.");
		}
		
		return result;
	}

	@Override
	public int readcountUp(int contentId) {
		int result = fd.readcountUp(contentId);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "축제 정보 조회수 증가에 실패하였습니다.");
		}
		
		return result;
	}

	@Override
	public Contents detailContents(int contentId) {
		Contents contents = fd.detailContents(contentId);
		
		if(contents == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 컨텐츠 정보가 존재하지 않습니다.");
		}
		
		return contents;
	}

}
