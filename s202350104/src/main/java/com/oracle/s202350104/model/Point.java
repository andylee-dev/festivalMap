package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class Point {
	
	private int 	id;
	private Date 	create_at;
	private String	title;
	private String 	content;
	private int		point;
	
	//pointhistory 처리용
	
	private int 	user_id;
	private int 	point_id;
	private Date 	created_at;
	
    //페이징 작업용
 	private String pageNum;
 	private int    start;
 	private int    end;
	
}
