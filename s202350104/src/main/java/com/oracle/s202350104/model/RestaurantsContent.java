package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class RestaurantsContent {
	// Contents 컬럼
	private int    area;
	private int    sigungu;
	private int    big_code;
	private int    small_code;
	private String title;
	private String content;
	private String status;
	private String img1;
	private String img2;
	private String img3;
	private String address;
	private int    postcode;
	private String mapx;
	private String mapy;
	private String email;
	private String phone;
	private String homepage;
	private int    readcount;
	private String user_id;
	
	// Restaurants 컬럼
	private int content_id;
	private String first_menu;
	private String menu;
	private String open_time;
	private String rest_date;
	private String is_smoking;
	private String is_packing;
	private String is_parking;
	
}
