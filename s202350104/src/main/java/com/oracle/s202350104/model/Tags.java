package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class Tags {

	private int id;
	private String name;
	private int board_id;
	private int content_id;
	private int user_id;
	private int course_id;
	private int group_id;
	private String group_name;
	
	// 페이징 처리용
	private String pageNum;
	private int    start;
	private int    end;
	
	// join용
	private int    tag_id;
	private String tag_name;
	private String cc_content; 		// 공통코드 내용
	private int    big_code;
	private int    small_code;
	private String bcode_content; 	// 대분류 내용
	private String scode_content; 	// 소분류 내용
	private int    area;
	private int    sigungu;
	private String area_content;  	// 시도 이름
	private String sigungu_content; // 시군구 이름
	private String user_name;		// user 이름
	private String birthday;		// user 생일
	private String email;			// user 이메일
	private String address;			// user 주소
	private String gender;			// user 성별
	private String title;			// board / content / course 이름
	private Date   created_at;		// board 생성일
	
	// 검색용
	private String searchType;
	private String keyword;
	private String ordering;
	
	// 통계용(count)
	private int userCnt;
	private int boardCnt;
	private int contentCnt;
	private int courseCnt;

}
