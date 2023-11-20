package com.oracle.s202350104.model;

import java.util.Date;

import lombok.Data;

@Data
public class History {
	private int    id;
	private int    big_code;
	private int    small_code;
	private String target_id;
	private String title;
	private String content;
	private Date   create_at;
}
