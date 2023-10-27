package com.oracle.s202350104.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Controller
@RequiredArgsConstructor
@Slf4j
public class RestaurantController {
	
	@RequestMapping(value = "/restaurant")
	public String restaurant() {
		return "restaurant/restaurantIndex";
	}
	
	@RequestMapping(value= "/restaurant/detail")
	public String restuarntDetail() {
		return "restaurant/restaurantDetail";
	}
	
	
}
