package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Favorite;

public interface FavoriteService {

	List<Favorite>       listFavorite(Favorite favorite);
	int 				 totalFavorite();
	int                  condTotalFavorite(Favorite favorite);
	List<Favorite>       listSearchFavorite(Favorite favorite);
	List<Favorite>       getMyLikeList(Favorite favorite);
	int                  totalMyLikeList();
	int                  deleteMyLikeList(int id);
	int                  insertFavorite(Favorite favorite);
	int                  deleteFavorite(Favorite favorite);
	Favorite             detailFavorite(Favorite favorite);
	int                  updateFavorite(Favorite favorite);
	Favorite             getMyFavoriteOne(Favorite favorite);
	
}
