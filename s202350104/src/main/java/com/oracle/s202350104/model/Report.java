package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class Report {
	private int board_id;
	private int user_id;
	private String result;
	private String status;
	private Date created_at;
	
	//조회용
	private String content;
	private String title;
	private int count;
	private int id;
	private String name;
	private int rn;
	private int small_code;
	private int comment_indent;
	
	
	//paging
	private String pageNum;
	private int    start;
	private int    end;
	
}
