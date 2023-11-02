package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.oracle.s202350104.dao.BoardDao;
import com.oracle.s202350104.model.Board;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@Transactional
@RequiredArgsConstructor
@Slf4j
public class BoardServiceImpl implements BoardService {

	private final BoardDao boardDao;
	
	// paging 처리용
	@Override
	public int boardCount(int smallCode) {
		int countBoard = boardDao.boardCount(smallCode);
		return countBoard;
	}

	// 공지사항
	@Override
	public List<Board> getNoticAllList(Board board) {
		List<Board> noticAllList = boardDao.getNoticAllList(board);

		log.info("service noticAllList size : {}", noticAllList.size());

		return noticAllList;
	}

	// 이달의 소식
	@Override
	public List<Board> getMagazinAllList(Board board) {

		List<Board> magazinAllList = boardDao.getMagazinAllList(board);

		log.info("service magazinAllList size : {}", magazinAllList.size());

		return magazinAllList;
	}

	// 자유게시판
	@Override
	public List<Board> getFreeAllList(Board board) {
		log.info("boardService getFreeAllList start!!");

		List<Board> freeAllList = null;

		try {
			freeAllList = boardDao.getFreeAllList(board);
			log.info("boardService freeAllList size : {}", freeAllList.size());

		} catch (Exception e) {
			log.error("boardService getFreeAllList Exception : {}", e.getMessage());
		} finally {
			log.info("boardService getFreeAllList End..");
		}

		return freeAllList;
	}
	
	// 포토게시판
	@Override
	public List<Board> getPhotoAllList(Board board) {
		
		List<Board> phothAllList = boardDao.getPhotoAllList(board);
		
		return phothAllList;
	}
	
	// 이벤트게시판
	@Override
	public List<Board> getEventAllList(Board board) {
		
		List<Board> eventAllList = boardDao.getEventAllList(board);
		
		return eventAllList;
	}
	
	// review
	@Override
	public List<Board> getReviewAllList(Board board) {

		log.info("boardService getReviewAllList start!!");

		List<Board> reviewAllList = null;

		try {
			reviewAllList = boardDao.getReviewAllList(board);  
			log.info("boardService reviewBoardList board.getContentId : {} ", board.getContent_id());
		} catch (Exception e) {
			log.error("boardService getReviewAllList Exception : {}", e.getMessage());
		} finally {
			log.info("boardService getReviewAllList End..");
		}

		return reviewAllList;
	}

	// 통합게시판 상세정보
	@Override
	public Board boardDetail(int boardId) {

		log.info("service boardId : {}", boardId);

		Board boards = boardDao.boardDetail(boardId);

		return boards;
	}
	
	// 통합게시판 수정
	@Override
	public int boardUpdate(Board board) {

		int updateBoard = boardDao.boardUpdate(board);

		return updateBoard;
	}
	
	// 통합게시판 삭제
	@Override
	public int boardDelete(int boardId) {
		
		int deleteBoard = boardDao.boardDelete(boardId);
		
		return deleteBoard;
	}
	
	// 통합게시판 생성
	@Override
	public int boardInsert(Board board) {

		int insertBoard = boardDao.boardInsert(board);
		
		return insertBoard;
	}

}
