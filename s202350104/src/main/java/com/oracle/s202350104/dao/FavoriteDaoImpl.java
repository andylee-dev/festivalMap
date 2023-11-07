package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Favorite;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class FavoriteDaoImpl implements FavoriteDao {
	
	private final SqlSession session;
		
	@Override
	public List<Favorite> listFavorite(Favorite favorite) {
		List<Favorite> listFavorite = null;
			
		try {
			log.info("FavoriteDaoImpl listFavorite Start...");
			listFavorite = session.selectList("joFavoriteListAll", favorite);
			log.info("FavoriteDaoImpl listFavorite.size() -> " + listFavorite.size());
		} catch (Exception e) {
			log.info("FavoriteDaoImpl listFavorite Exception -> " + e.getMessage());
		}
		
		return listFavorite;
	}

	@Override
	public int totalFavorite() {
		int totalFavorite = 0;
		
		try {
			log.info("FavoriteDaoImpl totalFavorite Start");
			totalFavorite = session.selectOne("joFavoriteTotal");
			log.info("FavoriteDaoImpl totalFavorite -> " + totalFavorite);
		} catch (Exception e) {
			log.info("FavoriteDaoImpl totalFavorite Exception -> " + e.getMessage());
		}
		
		return totalFavorite;
	}

	@Override
	public int condTotalFavorite(Favorite favorite) {
		int condTotalFavorite = 0;
		
		try {
			log.info("FavoriteDaoImpl condTotalFavorite Start");
			condTotalFavorite = session.selectOne("joCondTotalFavorite", favorite);
			log.info("FavoriteDaoImpl condTotalFavorite -> " + condTotalFavorite);
		} catch (Exception e) {
			log.info("FavoriteDaoImpl condTotalFavorite Exception-> " + e.getMessage());
		}
		return condTotalFavorite;
	}

	@Override
	public List<Favorite> listSearchFavorite(Favorite favorite) {
		List<Favorite> listSearchFavorite = null;
		try {
			log.info("FavoriteDaoImpl listSearchFavorite Start");
			listSearchFavorite = session.selectList("joListSearchFavorite", favorite);
			log.info("FavoriteDaoImpl listSearchFavorite.size() -> " + listSearchFavorite.size());
		} catch (Exception e) {
			log.info("FavoriteDaoImpl listSearchFavorite Exception-> " + e.getMessage());
		}
		return listSearchFavorite;
	}

}
