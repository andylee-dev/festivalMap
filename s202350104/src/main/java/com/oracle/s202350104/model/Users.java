package com.oracle.s202350104.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Users {
	private int id;
	private int big_code;
	private int small_code;
	private String name;
	private String password;
	private String nickname;
	private String birthday;
	private String phone_num;
	private String email;
	private String address;
	private String status;
	private int point;
	private String gender;
	private Date created_at;
	private Date updated_at;
	private String file_name;
	private String is_deleted;
	
	// 페이징 처리
	private String pageNum;
	private int    start;
	private int    end;

	// 검색용
	private String searchType;
	private String keyword;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	
}
