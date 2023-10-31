package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Qna;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class QnaListDaoImpl implements QnaListDao {
	
	private final SqlSession session;
	
	@Override
	public int totalQnaList() {
		int totQnaCount = 0;
		
		try {
			totQnaCount = session.selectOne("qnaTotal");
		} catch (Exception e) {
			log.info("QnaListDaoImpl totalQnaList Exception => " + e.getMessage());
		}
		return totQnaCount;
	}

	@Override
	public List<Qna> listQnaList(Qna qna) {
		List<Qna> qnaList = null;
		
		try {
			qnaList = session.selectList("dhQnaListAll", qna);
			log.info("QnaListDaoImpl qnaList() => " + qnaList.size());
		} catch (Exception e) {
			log.info("QnaListDaoImpl qnaList() => " + e.getMessage());
		}
		return qnaList;
	}
	
}
