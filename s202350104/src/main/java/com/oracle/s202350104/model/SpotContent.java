package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class SpotContent {
	
	// Contents 컬럼
	private int   	 area;
	private int    	sigungu;
	private int    	big_code;
	private int    	small_code;
	private String 	title;
	private String 	content;
	private String 	status;
	private String 	img1;
	private String 	img2;
	private String 	img3;
	private String 	address;
	private int    	postcode;
	private String 	mapx;
	private String 	mapy;
	private String 	email;
	private String 	phone;
	private String 	homepage;
	private int    	readcount;
	private String 	user_id;
	
	// Spot 컬럼
	private int 	content_id;
	private String	opening_hours;
	private String	rest_date;
	private String	entrance_fee;
	private String	is_restroom;
	private String	is_wheelchair;
	private String	is_stroller;
	private String	is_pet;
	private String	is_parking;

	
}
