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

	@Override
	public int boardCount2(Board board) {
		int countBoard = boardDao.boardCount2(board);
		return countBoard;
	}

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

		List<Board> freeAllList = boardDao.getFreeAllList(board);

		log.info("boardService freeAllList size : {}", freeAllList.size());

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

		List<Board> reviewAllList = boardDao.getReviewAllList(board);

		log.info("boardService reviewBoardList board.getContentId : {} ", board.getContent_id());

		return reviewAllList;
	}

	// 통합게시판 상세정보
	@Override
	public Board boardDetail(int boardId) {

		log.info("service boardId : {}", boardId);

		Board boards = boardDao.boardDetail(boardId);

		return boards;
	}

	// 통합게시판 생성
	@Override
	public int boardInsert(Board board) {

		int insertBoard = boardDao.boardInsert(board);

		return insertBoard;
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

	// 통합게시판 첨부파일 삭제
	@Override
	public Board boardRead(int id) {

		Board board = boardDao.boardRead(id);

		return board;
	}
	
	// 댓글 기능
	@Override
	public void commentInsert(Board board) {
		
		boardDao.commentInsert(board);
		
	}
	
	@Override
	public List<Board> commentDetail(int id) {
		List<Board> comments = boardDao.commentDetail(id);
		return comments; 
	}

}
