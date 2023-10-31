package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class Festivals {
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
