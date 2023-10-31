package com.oracle.s202350104.model;

import java.util.Date;

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

}
