package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Board;

public interface BoardService {
	
	int boardCount(int smallCode);	
	
	List<Board> getFreeAllList(Board board);

	List<Board> getNoticAllList(Board board);

	List<Board> getMagazinAllList(Board board);
	
	List<Board> getPhotoAllList(Board board);
	
	List<Board> getEventAllList(Board board);
	
	List<Board> getReviewAllList(Board board);

	Board boardDetail(int boardId);

	int boardUpdate(Board board);

	int boardDelete(int boardId);

	int boardInsert(Board board);

	Board boardRead(int id);

}
