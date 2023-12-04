package com.oracle.s202350104.controller;

import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Favorite;
import com.oracle.s202350104.service.FavoriteService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class FavoriteRestController {
	private final FavoriteService favoriteService;

	@ResponseBody
	@RequestMapping(value = "/toggleFavoriteAjax", method = RequestMethod.POST)
	public ResponseEntity<Integer> favoriteToggle(@RequestBody Favorite favorite ) {
		UUID transactionId = UUID.randomUUID();
		int result = 0;
		try {
			log.info("[{}]{}:{}", transactionId, "favoriteToggle", "start");
			log.info("favorite:{}",favorite.toString());
			Favorite myFavorite = favoriteService.getMyFavoriteOne(favorite);


			if(myFavorite != null) {
				log.info("찜하기 취소:{}",myFavorite.toString() );
				result = favoriteService.deleteFavorite(favorite);
				if(result <= 0)
					throw new Exception("deleteFavorite  실패");
				result = 0;
			} else {
				log.info("찜하기");
				result = favoriteService.insertFavorite(favorite);
				if(result <= 0)
					throw new Exception("deleteFavorite 실패");
				result = 1;
			}
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "favoriteToggle", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "favoriteToggle", "end");
		}
		
		return ResponseEntity.status(HttpStatus.CREATED).body(result);
	}
}
