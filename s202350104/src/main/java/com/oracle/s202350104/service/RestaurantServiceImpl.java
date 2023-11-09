package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.RestaurantDao;
import com.oracle.s202350104.model.CommonCodes;
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
	public RestaurantsContent detailRestaurant(int contentId) {
		RestaurantsContent restaurant = null;
		log.info("RestaurantImpl detailRestaurant Start...");
		restaurant = rd.detailRestaurant(contentId);
		
		if(restaurant == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "해당 식당 정보가 존재하지 않습니다");
		}
		
		return restaurant;
	}

	@Override
	public int totalRestaurant() {
		int totalRestaurant = 0;
		totalRestaurant = rd.totalRestaurant();
		return totalRestaurant;
	}

	@Override
	public int conTotalRestaurant(RestaurantsContent restaurant) {
		int conTotalRestaurant = rd.conTotalRestaurant(restaurant);
		return conTotalRestaurant;
	}

	@Override
	public List<RestaurantsContent> listSearchRestaurant(RestaurantsContent restaurant) {
		List<RestaurantsContent> listSearchRestaurant = rd.listSearchRestaurant(restaurant);
		return listSearchRestaurant;
	}

	@Override
	public List<RestaurantsContent> listRestaurant() {
		List<RestaurantsContent> listRestaurant = rd.listRestaurant();
		return listRestaurant;
	}

	@Override
	public int adminConTotalRestaurant(RestaurantsContent restaurant) {
		int adminConTotalRestaurant = rd.adminConTotalRestaurant(restaurant);
		return adminConTotalRestaurant;
	}

	@Override
	public List<RestaurantsContent> adminListSearchRestaurant(RestaurantsContent restaurant) {
		List<RestaurantsContent> adminListSearchRestaurant = rd.adminListSearchRestaurant(restaurant);
		return adminListSearchRestaurant;
	}

	@Override
	public int insertRestaurant(RestaurantsContent restaurant) {
		int result = 0;
		result = rd.insertRestaurant(restaurant);
		
		if(result <= 0) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "맛집 정보 등록에 실패하였습니다");
		}
		
		return result;
	}

	@Override
	public int updateRestaurant(RestaurantsContent restaurant) {
		int result = 0;
		result = rd.updateRestaurant(restaurant);
		
		if(result == 0) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "맛집 정보 수정에 실패하였습니다.");
		}
		return result;
	}

}
