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

	@Override
	public Qna detailQna(int user_id, int id) {
		Qna qnadetail = new Qna();
		Qna qna = new Qna();
		qna.setUser_id(user_id);
		qna.setId(id);
		try {
			qnadetail = session.selectOne("dhDetailQna", qna);
			log.info("QnaListDaoImpl detailQna() qna.getAnswer_title => " + qna.getAnswer_title());
		} catch (Exception e) {
			log.info("QnaListDaoImpl detailQna() => " + e.getMessage());
		}
		return qnadetail;
	}

	@Override
	public int insertQna(Qna qna) {
		int result = 0;
		try {
			result = session.insert("dhQnaInsert", qna);
		}catch (Exception e) {
			log.info("QnaListDaoImpl insertqna() => " + e.getMessage());
		}
		return result;
		}

	@Override
	public Qna selectQna(int user_id, int id) {
		Qna qnaselect = new Qna();
		Qna qna = new Qna();
		qna.setUser_id(user_id);
		qna.setId(id);
		try {
			qnaselect = session.selectOne("dhQnaSelect", qna);
		}catch (Exception e) {
			log.info("QnaListDaoImpl selectqna() => " + e.getMessage());
		}
		return qnaselect;
	}

	@Override
	public int updateQna(Qna qna) {
		int result = 0;
		try {
			result = session.update("dhQnaUpdate",qna);
		} catch (Exception e) {
			log.info("QnaListDaoImpl updateqna() => " + e.getMessage());
		}
		return result;
		}

	@Override
	public int deleteQna(int id, int user_id) {
		Qna qna = new Qna();
		int result = 0;
		qna.setUser_id(user_id);
		qna.setId(id);
		try {
			result = session.delete("dhQnaDelete", qna);
		}catch (Exception e) {
			log.info("QnaListDaoImpl deleteQna() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public int adminUpdateQna(Qna qna) {
		int result = 0;
		try {
			result = session.update("dhAdminUpdate",qna);
		} catch (Exception e) {
			log.info("QnaListDaoImpl updateqna() => " + e.getMessage());
		}
		return result;
	}
}
