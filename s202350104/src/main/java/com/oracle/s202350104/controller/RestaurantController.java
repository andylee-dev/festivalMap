package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Restaurants;
import com.oracle.s202350104.model.RestaurantsContent;
import com.oracle.s202350104.service.RestaurantService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
public class RestaurantController {
	private final RestaurantService rs;
	
	@RequestMapping(value = "/restaurant")
	public String restaurant(Model model) {
		log.info("RestaurantController listRestaurant Start...");
				
		List<Restaurants> listRestaurant = rs.listRestaurant();
		log.info("RestaurantController listRestaurant.size()->" + listRestaurant.size());
				
		model.addAttribute("listRestaurant", listRestaurant);
				
		return "restaurant/restaurantList";
	}
	
	
	@RequestMapping(value= "/restaurant/detail")
	public String restuarntDetail(int content_id, Model model) {
		log.info("RestaurantController detailRestaurant Start...");
		
		RestaurantsContent restaurant = rs.detailRestaurant(content_id);
		
		model.addAttribute("restaurant", restaurant);
		
		return "restaurant/restaurantDetail";
	}
	
	
}
