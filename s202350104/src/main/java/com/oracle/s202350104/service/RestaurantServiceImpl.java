package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

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
	public List<RestaurantsContent> listRestaurant(RestaurantsContent restaurant) {
		List<RestaurantsContent> listRestaurant = rd.listRestaurant(restaurant);
		
		if(listRestaurant == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "식당 리스트가 존재하지 않습니다.");
		}
		return listRestaurant;
	}

	@Override
	public RestaurantsContent detailRestaurant(int content_id) {
		RestaurantsContent restaurant = null;
		log.info("RestaurantImpl detailRestaurant Start...");
		restaurant = rd.detailRestaurant(content_id);
		
		return restaurant;
	}

	@Override
	public int totalRestaurant() {
		int totalRestaurant = 0;
		totalRestaurant = rd.totalRestaurant();
		return totalRestaurant;
	}

}
