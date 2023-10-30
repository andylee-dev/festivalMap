package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.RestaurantDao;
import com.oracle.s202350104.model.Restaurant;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class RestaurantServiceImpl implements RestaurantService {
	private final RestaurantDao rd;
	
	@Override
	public List<Restaurant> listRestaurant(Restaurant restaurant) {
		List<Restaurant> listRestaurant = null;
		System.out.println("RestaurantImpl listManager Start...");
		listRestaurant = rd.listRestaurant(restaurant);
		
		return listRestaurant;
	}

}
