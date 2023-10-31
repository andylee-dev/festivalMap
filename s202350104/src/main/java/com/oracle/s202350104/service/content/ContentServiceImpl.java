package com.oracle.s202350104.service.content;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.RestaurantDao;
import com.oracle.s202350104.model.Restaurants;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ContentServiceImpl implements ContentService {
	private final RestaurantDao rd;
	
	@Override
	public List<Restaurants> listRestaurant() {
		List<Restaurants> listRestaurant = rd.listRestaurant();
		return listRestaurant;
	}

}
