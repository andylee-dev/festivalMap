package com.oracle.s202350104.model;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Qna {
	private int		user_id;
	private int		id;
	private	String	question_title;
	private String	question_content;
	private String	answer_title;
	private String	answer_content;
	private Date	created_at;
	private	Date	updated_at;
	private String	status;
	
	// 조회용
	private String search;
	private String keyWord;
	private String pageNum;
	private int	   start;
	private int	   end;

	// user
	private int 	big_code;
	private int 	small_code;
	private String 	name;
	private String 	password;
	private String 	nickname;
	private String 	birthday;
	private String 	phone_num;
	private String 	email;
	private String 	address;
	private int		point;
	private String 	gender;
	private String 	file_name;
	private String 	is_deleted;
	
	//검색용
	
	private String dateOptions;
	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-mm-dd")
	private Date endDate;
}
