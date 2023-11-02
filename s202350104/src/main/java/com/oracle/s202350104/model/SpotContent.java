package com.oracle.s202350104.model;

import java.util.Date;

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
	private	Date	created_at;
	private Date	updated_at;
	private String	is_deleted;
	
	
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
	private String	is_elevator;
	
	// 조회용
	private String search;
	private String keyWord;
	private String pageNum;
	private int	   start;
	private int	   end;
	
	//분류
	private String cc_content;
}
