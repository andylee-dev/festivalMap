package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Board;

public interface BoardService {
	
	int boardCount();	
	
	List<Board> getFreeAllList(Board board);

	List<Board> getNoticAllList(Board board);

	List<Board> getMagazinAllList(Board board);
	
	List<Board> getPhotoAllList(Board board);

	Board boardDetail(int boardId);

	int boardUpdate(Board board);


}
