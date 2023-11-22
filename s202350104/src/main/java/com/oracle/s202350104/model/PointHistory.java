package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class PointHistory {
	
	private int 	user_id;
	private int 	point_id;
	private Date 	created_at;
	private int		id;
	
	//조회용
	private String	title;
	private String	content;
	private String	point;
	
	//유저 이름 추가용
    private String user_name;
    
    //포인트 조회용
    private String point_title;
    private String point_point;
}
