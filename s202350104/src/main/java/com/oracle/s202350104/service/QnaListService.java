package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Qna;

public interface QnaListService {

	int 	  totalQnaList();
	List<Qna> listQnaList(Qna qna);
	Qna       detailQna(int user_id, int id);
	int       insertQna(Qna qna);
	Qna       selectQna(int user_id, int id);
	int       updateQna(Qna qna);

}
