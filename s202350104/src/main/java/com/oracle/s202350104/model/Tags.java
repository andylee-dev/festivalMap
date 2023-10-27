package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class Tags {
	private int id;
	private String name;
	private int board_id;
	private int content_id;
	private int user_id;	
}
