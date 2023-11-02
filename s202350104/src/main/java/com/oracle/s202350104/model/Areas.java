package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class Areas {
	private int area;
	private int sigungu;
	private String content;

	// 페이징처리
	private String pageNum;
	private int start;
	private int end;
	
	
}
