package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.RestaurantDao;
import com.oracle.s202350104.model.Restaurants;
import com.oracle.s202350104.model.RestaurantsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class RestaurantServiceImpl implements RestaurantService {
	
	private final RestaurantDao rd;
	
	@Override
	public List<Restaurants> listRestaurant() {
		List<Restaurants> listRestaurant = null;
		log.info("RestaurantImpl listManager Start...");
		listRestaurant = rd.listRestaurant();
		
		return listRestaurant;
	}

	@Override
	public RestaurantsContent detailRestaurant(int content_id) {
		RestaurantsContent restaurant = null;
		log.info("RestaurantImpl detailRestaurant Start...");
		restaurant = rd.detailRestaurant(content_id);
		
		return restaurant;
	}

}
