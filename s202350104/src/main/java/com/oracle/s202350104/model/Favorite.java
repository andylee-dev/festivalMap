package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class Favorite {
	
	private int  user_id;
	private int  id;
	private Date create_at;
	
	// 페이지 처리용
	private String pageNum;
	private int    start;
	private int    end;
	
	// 조회용
	private String name;
	
	private String search;
	private String keyword;

	
	
}
