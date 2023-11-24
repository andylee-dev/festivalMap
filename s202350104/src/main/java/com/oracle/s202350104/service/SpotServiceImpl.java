package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.controller.SpotController;
import com.oracle.s202350104.dao.AreasDao;
import com.oracle.s202350104.dao.ContentsDao;
import com.oracle.s202350104.dao.SpotDao;
import com.oracle.s202350104.model.ExperienceContent;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class SpotServiceImpl implements SpotService {
	
	private final SpotDao sd;
	private final ContentsDao cd;

	@Override
	public List<SpotContent> listSpot(SpotContent spotContent) {
		List<SpotContent> spotList = sd.listSpot(spotContent);
		
		if(spotList == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "명소 리스트가 존재하지 않습니다.");
		}
		return spotList;
	}

	@Override
	public SpotContent detailSpot(int contentId) {
		SpotContent spot = sd.detailSpot(contentId);
		
		if(spot == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 명소 정보가 존재하지 않습니다.");
		}
		return spot;
	}

	@Override
	public int insertSpot(SpotContent spotContent) {
		int result = 0;
		result = sd.insertSpot(spotContent);
		
		return result;
	}

	@Override
	public int updateSpot(SpotContent spot) {
		int result = sd.updateSpot(spot);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,"명소 정보 수정에 실패하였습니다. ");
		}
		return result;
	}

	@Override
	public int deletespot(SpotContent spot) {
		int result = sd.deleteSpot(spot);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,"명소 정보 삭제에 실패하였습니다. ");
		}
		return result;
	}

	@Override
	public int approveSpot(SpotContent spot) {
		int result = sd.approveSpot(spot);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND,"명소 정보 승인에 실패하였습니다. ");
		}
		return result;
	}

	//테마별 조회
	@Override
	public List<SpotContent> listSpot3(SpotContent spotContent) {
		List<SpotContent> spotList = sd.listSpot3(spotContent);
		
		if(spotList == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "명소 리스트가 존재하지 않습니다.");
		}
		return spotList;
	}

	@Override
	public int totalSearchSpot(SpotContent spotContent) {
		int totalSearchSpot = sd.totalSearchSpot(spotContent);
		return totalSearchSpot;
	}

}
