package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class CommonCodes {
	private int big_code;
	private int small_code;
	private String content;
	
	// 페이지 처리용
	private String pageNum;
	private int    start;
	private int    end;
	
	
}
