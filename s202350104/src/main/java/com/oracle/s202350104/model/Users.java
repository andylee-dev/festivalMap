package com.oracle.s202350104.model;

import java.util.Date;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class Users {
	private int id;
	private int big_code;
	private int small_code;
	@NotBlank(message = "이름 필수 입력 값입니다.")
	private String name;
	@NotBlank(message = "비밀번호는 필수 입력 값입니다.")
	@Pattern(regexp = "(?=.*[0-9])(?=.*[a-zA-Z]).{8,16}", message = "비밀번호는 8~16자 영문 대 소문자와 숫자를 사용하세요.")
	private String password;
	@Pattern(regexp = "^[ㄱ-ㅎ가-힣a-z0-9-_]{2,10}$", message = "닉네임은 특수문자를 제외한 2~10자리여야 합니다.")
	private String nickname;
	private String birthday;
	private String phone_num;
	@NotBlank(message = "이메일은 필수 입력 값입니다.")
	@Email
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
	private String dateOptions;
	private String searchType;
	private String keyword;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date startDate;
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date endDate;
	
}
