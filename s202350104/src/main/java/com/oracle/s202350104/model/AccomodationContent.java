package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class AccomodationContent {
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
		
		// Accomodations 컬럼
		private int    content_id;
		private int	   room_count;
		private String reservation_url;
		private String refund;
		private String check_in;
		private String check_out;
		private String is_pickup;
		private String is_cook;
		private String is_parking;
		
		// 페이지 처리용
		private String pageNum;
		private int    start;
		private int    end;
		
		// 검색용
		private String keyword;
		
		// join용
		private String area_content;
		private String sigungu_content;
}
