package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.QnaListDao;
import com.oracle.s202350104.model.Qna;
import com.sun.net.httpserver.Authenticator.Result;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class QnaListServiceImpl implements QnaListService {

	private final QnaListDao qd;
	@Override
	public int totalQnaList(Qna qna) {
		int totQnaListCnt = qd.totalQnaList(qna);
				
		return totQnaListCnt;
	}

	@Override
	public List<Qna> listQnaList(Qna qna) {
		List<Qna> qnaList = qd.listQnaList(qna);
		return qnaList;
	}

	@Override
	public Qna detailQna(int user_id, int id) {
		Qna qnadetail = qd.detailQna(user_id, id);
		
		return qnadetail;
	}

	@Override
	public int insertQna(Qna qna) {
		int result = 0;
		result = qd.insertQna(qna);
		
		return result;
	}

	@Override
	public Qna selectQna(int user_id, int id) {
		Qna qna = qd.selectQna(user_id, id);
		return qna;
	}

	@Override
	public int updateQna(Qna qna) {
		int result = 0;
		result = qd.updateQna(qna);
		return result;
	}

	@Override
	public int deleteQna(int id, int user_id) {
		int result = qd.deleteQna(id, user_id);
		return result;
	}

	@Override
	public int adminUpdateQna(Qna qna) {
		int result = 0;
		result = qd.adminUpdateQna(qna);
		return result;
	}

}
