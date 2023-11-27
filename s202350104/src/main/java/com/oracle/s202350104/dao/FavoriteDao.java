package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Favorite;

public interface FavoriteDao {

	List<Favorite>         listFavorite(Favorite favorite);
	int 				   totalFavorite();
	int                    condTotalFavorite(Favorite favorite);
	List<Favorite>         listSearchFavorite(Favorite favorite);
	int                    deleteFavorite(Favorite favorite);
	Favorite               getMyFavoriteOne(Favorite favorite);
	int                    insertFavorite(Favorite favorite);
	int 					totalFavorite1(Favorite favorit);

}
