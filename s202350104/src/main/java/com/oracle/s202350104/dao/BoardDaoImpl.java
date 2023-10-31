package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class BoardDaoImpl implements BoardDao {

	private final SqlSession session;

	// 조회수 증가 logic
	public void readCountUp(int boardId) {

		log.info("BoardDao readCountUp boardId : {}", boardId);

		try {
			session.selectOne("readCountUp", boardId);
		} catch (Exception e) {
			log.error("BoardDao readCountUp Exception : {}", e.getMessage());
		}
	}

	// Paging logic 일부분
	@Override
	public int boardCount() {

		int countBoard = 0;

		try {
			countBoard = session.selectOne("boardCount");
		} catch (Exception e) {
			log.error("BoardDao boardCount Exception : {}", e.getMessage());
		}

		return countBoard;
	}

	@Override
	public List<Board> getNoticAllList(Board board) {

		List<Board> noticAllList = null;

		try {
			noticAllList = session.selectList("noticAllList", board);
			log.info("BoardDao getNoticAllList size : {}", noticAllList.size());

		} catch (Exception e) {
			log.error("BoardDao getNoticAllList Exception : {}", e.getMessage());
		}

		return noticAllList;
	}

	@Override
	public List<Board> getMagazinAllList(Board board) {

		List<Board> magazinAllList = null;

		try {
			magazinAllList = session.selectList("magazinAllList", board);
			log.info("BoardDao getMagazinAllList size : {}", magazinAllList.size());

		} catch (Exception e) {
			log.error("BoardDao getMagazinAllList Exception : {}", e.getMessage());
		}

		return magazinAllList;
	}

	@Override
	public List<Board> getFreeAllList(Board board) {

		List<Board> freeAllList = null;

		try {
			freeAllList = session.selectList("freeAllList", board);
			log.info("BoardDao getFreeAllList size : {}", freeAllList.size());

		} catch (Exception e) {
			log.error("BoardDao getFreeAllList Exception : {}", e.getMessage());
		}

		return freeAllList;
	}

	@Override
	public List<Board> getPhotoAllList(Board board) {

		List<Board> photoAllList = null;

		try {
			photoAllList = session.selectList("photoAllList", board);
		} catch (Exception e) {
			log.error("BoardDao getPhotoAllList Exception : {}", e.getMessage());
		} finally {
			log.info("BoardDao getPhotoAllList End");
		}

		return photoAllList;
	}

	@Override
	public Board boardDetail(int boardId) {

		Board boards = null;

		try {
			boards = session.selectOne("boardDetail", boardId);
			log.info("BoardDao boardDetail getTitle : {}", boards.getTitle());

			readCountUp(boardId);

		} catch (Exception e) {
			log.error("BoardDao boardDetail Exception : {}", e.getMessage());
		}

		return boards;
	}

	@Override
	public int boardUpdate(Board board) {

		int updateBoard = 0;

		try {
			updateBoard = session.update("boardUpdate", board);
		} catch (Exception e) {
			log.error("BoardDao boardUpdate Exception : {}", e.getMessage());
		}

		return updateBoard;
	}
}
