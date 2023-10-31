package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.QnaListDao;
import com.oracle.s202350104.model.Qna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class QnaListServiceImpl implements QnaListService {

	private final QnaListDao qd;
	@Override
	public int totalQnaList() {
		int totQnaListCnt = qd.totalQnaList();
				
		return totQnaListCnt;
	}

	@Override
	public List<Qna> listQnaList(Qna qna) {
		List<Qna> qnaList = qd.listQnaList(qna);
		return qnaList;
	}

}
