package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Restaurant;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class RestaurantDaoImpl implements RestaurantDao {
	
	private final SqlSession session;

	@Override
	public List<Restaurant> listRestaurant(Restaurant restaurant) {
		List<Restaurant> restaurantList = null;
		System.out.println("RestaurantImpl listRestaurant Start...");
		
		try {
			restaurantList = session.selectList("joRestaurantListAll", restaurant);
			System.out.println("RestaurantDaoImpl listRestaurant restaurantList.size()->" + restaurantList.size());
		} catch (Exception e) {
			System.out.println("RestaurantDaoImpl listRestaurant e.getMessage()->" + e.getMessage());
		}
		return restaurantList;
	}
	
}
