package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class Tags {

	private int id;
	private String name;
	private int board_id;
	private int content_id;
	private int user_id;
	private int course_id;
	
	// 페이징 처리용
	private String pageNum;
	private int    start;
	private int    end;
	
	// join용
	private String title; // 콘텐츠, 게시글 제목
	private String cc_content; // 공통코드 내용
	private int tag_id;
	private String tag_name;
	
	// 검색용
	private String search;
	private String keyword;
	private String ordering;

}
