package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Restaurants;
import com.oracle.s202350104.model.RestaurantsContent;

public interface RestaurantService {

	List<Restaurants> 	listRestaurant();
	RestaurantsContent  detailRestaurant(int content_id);
	

}
