package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Restaurants;
import com.oracle.s202350104.model.RestaurantsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class RestaurantDaoImpl implements RestaurantDao {
	
	private final SqlSession session;

	@Override
	public List<RestaurantsContent> listRestaurant(RestaurantsContent restaurant) {
		List<RestaurantsContent> restaurantList = null;
		log.info("RestaurantImpl listRestaurant Start...");
		
		try {
			log.info("RestaurantDaoImpl listRestaurant ");
			restaurantList = session.selectList("joRestaurantListAll",restaurant);
			log.info("RestaurantDaoImpl listRestaurant restaurantList.size()->" + restaurantList.size());
		} catch (Exception e) {
			log.info("RestaurantDaoImpl listRestaurant e.getMessage()->" + e.getMessage());
		}
		return restaurantList;
	}

	@Override
	public RestaurantsContent detailRestaurant(int content_id) {
		RestaurantsContent restaurant = new RestaurantsContent();
		
		try {
			restaurant = session.selectOne("joRestaurantDetail", content_id);
			log.info("RestaurantsContent detailRestaurant() restaurant.getTitle ->" + restaurant.getTitle());
					
		} catch (Exception e) {
			log.info("RestaurantsContent detailRestaurant() ->" + e.getMessage());
		}
		return restaurant;
	}

	@Override
	public int totalRestaurant() {
		int totalRestaurant = 0;
		try {
			log.info("RestaurantDaoImpl totalRestaurant ");
			totalRestaurant = session.selectOne("joRestaurantTotal");
		} catch (Exception e) {
			log.info("RestaurantDaoImpl totalRestaurant() Exception ->" + e.getMessage());
		}
		
		return totalRestaurant;
	}
	
}
