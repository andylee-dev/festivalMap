package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Restaurants;
import com.oracle.s202350104.model.RestaurantsContent;

public interface RestaurantDao {

	List<RestaurantsContent> 	listRestaurant(RestaurantsContent restaurant);
	RestaurantsContent 			detailRestaurant(int content_id);
	int 						totalRestaurant();
	
	
}
	