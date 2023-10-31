package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Qna;

public interface QnaListDao {

	int 	  totalQnaList();
	List<Qna> listQnaList(Qna qna);
	
}
