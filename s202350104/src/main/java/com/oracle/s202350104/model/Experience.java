package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class Experience {
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
	
	//contents 조회용 
	private int    area;
	private int    sigungu;
	private String title;
	private String content;
	private String img1;
	private int    id;
	
}
