package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class ExperienceContent {
	private int id;
	private int area;
	private int sigungu;
	private int big_code;
	private int small_code;
	private String title;
	private String content;
	private String status;
	private String img1;
	private String img2;
	private String img3;
	private String address;
	private int postcode;
	private String mapx;
	private String mapy;
	private String email;
	private String phone;
	private String homepage;
	private int readcount;
	private String user_id;
	private Date created_at;
	private Date deleted_at;
	private String is_deleted;
	
	
	private int content_id;
	private String capacity;
	private String age;
	private String inform;
	private String open_time;
	private String rest_time;
	private String cost;
	private String is_credit;
	private String is_pet;
	private String is_parking;
	private String is_stroller;	
	
	private String pageNum;
	private int    start;
	private int    end;
	
	private String keyword;
	
}
