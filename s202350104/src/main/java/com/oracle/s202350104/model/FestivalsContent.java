package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class FestivalsContent {
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
	
	// Festivals 컬럼
	private int    content_id;
	private String hours;
	private String start_date;
	private String end_date;
	private String sponsor;
	private String eventplace;
	private String cost;
	private String overview;
	private String is_parking;
	private String is_stroller;
	private String is_wheelchair;
	private String is_restroom;
	
}
