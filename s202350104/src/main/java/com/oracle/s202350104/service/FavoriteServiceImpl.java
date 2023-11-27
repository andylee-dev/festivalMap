package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.FavoriteDao;
import com.oracle.s202350104.model.Favorite;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class FavoriteServiceImpl implements FavoriteService {
	
	private final FavoriteDao fad;
	
	@Override
	public List<Favorite> listFavorite(Favorite favorite) {
		List<Favorite> listFavorite = fad.listFavorite(favorite);
		
		if(listFavorite == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "찜 목록 리스트가 존재하지 않습니다.");
			
		}
		return listFavorite;
	}

	@Override
	public int totalFavorite() {
		int totalFavorite = 0;
		totalFavorite = fad.totalFavorite();
		return totalFavorite;
	}

	@Override
	public int condTotalFavorite(Favorite favorite) {
		int condTotalFavorite = 0;
		condTotalFavorite = fad.condTotalFavorite(favorite);
		log.info("FavoriteServiceImpl condTotalFavorite ->" + condTotalFavorite);
		return condTotalFavorite;
	}

	@Override
	public List<Favorite> listSearchFavorite(Favorite favorite) {
		List<Favorite> listSearchFavorite = fad.listSearchFavorite(favorite);
		
		if(listSearchFavorite == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "찜 목록 리스트가 존재하지 않습니다.");
		}
		return listSearchFavorite;
	}


	@Override
	public int deleteFavorite(Favorite favorite) {
		int result = 0;
		result = fad.deleteFavorite(favorite);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "찜목록  삭제를 실패하였습니다.");
		}
		return result;
	}

	
	@Override
	public Favorite getMyFavoriteOne(Favorite favorite) {
		return fad.getMyFavoriteOne(favorite);
	}

	
	@Override
	public int insertFavorite(Favorite favorite) {
		int result = 0;
		result = fad.insertFavorite(favorite);
		
		if(result <= 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "찜목록  업데이트에 실패하였습니다.");
		}
		return result;
	}

	@Override
	public int totalFavorite1(Favorite favorit) {
		int totalFavorite1 = 0;
		totalFavorite1 = fad.totalFavorite1(favorit);
		return totalFavorite1;
	}
	
	}	