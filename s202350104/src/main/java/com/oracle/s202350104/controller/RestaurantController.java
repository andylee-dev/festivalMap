package com.oracle.s202350104.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.oracle.s202350104.model.Restaurant;
import com.oracle.s202350104.service.RestaurantService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
public class RestaurantController {
	private final RestaurantService rs;
	
	@RequestMapping(value = "/restaurant")
	public String restaurant(Restaurant restaurant, String currentPage, Model model) {
		System.out.println("RestaurantController listRestaurant Start...");
		
		// int totalRestaurant = rs.totalRestaurant();
		
		List<Restaurant> listRestaurant = rs.listRestaurant(restaurant);
		System.out.println("RestaurantController listRestaurant.size()->" + listRestaurant.size());
		
		// model.addAttribute("totalRestaurant", totalRestaurant);
		model.addAttribute("listRestaurant", listRestaurant);
				
		return "restaurant/restaurantIndex";
	}
	
	
	@RequestMapping(value= "/restaurant/detail")
	public String restuarntDetail() {
		return "restaurant/restaurantDetail";
	}
	
	
}
