package com.oracle.s202350104.model;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class FestivalsContent {
	// Contents 컬럼
	private int    area;
	private int    sigungu;
	private int    big_code;
	private int    small_code;
	private String title;
	private String content;
	private String status;
	private String img1;
	private String img2;
	private String img3;
	private String address;
	private int    postcode;
	private String mapx;
	private String mapy;
	private String email;
	private String phone;
	private String homepage;
	private int    readcount;
	private String user_id;
	private Date   created_at;
	private Date   updated_at;
	private String is_deleted;
	
	// Festivals 컬럼
	private int    content_id;
	private String hours;
	private Date   start_date;
	private Date   end_date;
	private String sponsor;
	private String eventplace;
	private String cost;
	private String overview;
	private String is_parking;
	private String is_stroller;
	private String is_wheelchair;
	private String is_restroom;
	
	// 페이징 처리용
	private String pageNum;
	private int    start;
	private int    end;
	
	// join용
	private String area_content;	// 시도
	private String sigungu_content;	// 시군구
	private String bcode_content;	// 대분류
	private String scode_content;	// 소분류
	
	// 검색용
	private String searchType;
	private String keyword;
	private String ordering; // 정렬
	
	// 태그용
	private String[]   finalTags;
	private int        tag_id;
	private List<Tags> myTags;
}
