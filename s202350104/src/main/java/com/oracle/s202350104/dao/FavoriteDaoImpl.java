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

	@Override
	public List<Favorite> getMyLikeList(Favorite favorite) {
		List<Favorite> getMyLikeList = null;
		
		try {
			log.info("FavoriteDaoImpl getMyLikeList Start");
			getMyLikeList = session.selectList("joGetMyLikeList", favorite);
			log.info("FavoriteDaoImpl getMyLikeList.size() -> " + getMyLikeList.size());
		} catch (Exception e) {
			log.info("FavoriteDaoImpl getMyLikeList Exception ->" + e.getMessage());
		}
		
		return getMyLikeList;
	}

	@Override
	public int totalMyLikeList() {
		int totalMyLikeList = 0;
		
		try {
			log.info("FavoriteDaoImpl totalMyLikeList Start");
			totalMyLikeList = session.selectOne("joTotalMyLikeList");
			log.info("FavoriteDaoImpl totalMyLikeList ->" + totalMyLikeList);
		
		} catch (Exception e) {
			log.error("FavoriteDaoImpl totalMyLikeList Exception ->" + e.getMessage());
		}
		
		return totalMyLikeList;
	}

	@Override
	public int deleteMyLikeList(int id) {
		int result = 0;
		
		try {
			log.info("FavoriteDaoImpl deleteConfirm Start");
			result = session.delete("joDeleteMyLike", id);
			log.info("FavoriteDaoImpl deleteConfirm -> {}", result);
		} catch (Exception e) {
			log.error("FavoriteDaoImpl deleteConfirm Exception ->" + e.getMessage());
		}
		return result;
	}

	@Override
	public int insertFavorite(Favorite favorite) {
		int result = 0;
		
		try {
			log.info("FavaoriteDaoImpl insertFavorite Start");
			result = session.insert("joInsertFavorite", favorite);
			log.info("FavaoriteDaoImpl insertFavorite -> {}", result);
		} catch (Exception e) {
			log.info("FavaoriteDaoImpl insertFavorite Exception ->" + e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteFavorite(Favorite favorite) {
		int result = 0;
		
		try {
			log.info("FavaoriteDaoImpl deleteFavorite Start");
			result = session.delete("joDeleteFavorite", favorite);
			log.info("FavaoriteDaoImpl deleteFavorite -> {}", result);
		} catch (Exception e) {
			log.info("FavaoriteDaoImpl deleteFavorite Exception ->" + e.getMessage());
		}
		return result;
	}
	
	
	@Override
	public Favorite detailFavorite(Favorite favorite) {
		Favorite detailFavorite = null;
		
		try {
			log.info("FavaoriteDaoImpl detailFavorite Start");
			detailFavorite = session.selectOne("joDetailFavorite", favorite);
			
		} catch (Exception e) {
			log.info("FavaoriteDaoImpl detailFavorite Exception ->" + e.getMessage());
		}
		return detailFavorite;
	}

	
	@Override
	public int updateFavortie(Favorite favorite) {
		int result = 0;
		
		try {
			log.info("FavoriteDaoImpl updateFavorite Start");
			result = session.update("joUpdateFavorite", favorite);
			log.info("FavoriteDaoImpl updateFavorite result -> {}", result);
			
		} catch (Exception e) {
			log.error("FavoriteDaoImpl updateFavorite Exception ->", e.getMessage());
		}
		
		return result;
	}

	@Override
	public Favorite getMyFavoriteOne(Favorite favorite) {
		return session.selectOne("getMyFavoriteOne", favorite);
	}

}
