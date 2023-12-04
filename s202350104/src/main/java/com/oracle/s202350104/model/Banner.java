package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class Banner {
	private int id;
	private int big_code;
	private int small_code;
	private String title;
	private String status;
	private String content;
	private String url;
	private String image;
	private Date created_at;
	private Date updated_at;
	
	
	// 조회용
	private int start;
	private int end;
	private String keyword;
	private String pageNum;
	private String type;
}
