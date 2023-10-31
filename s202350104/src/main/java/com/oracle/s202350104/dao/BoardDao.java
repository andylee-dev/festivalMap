package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Board;

public interface BoardDao {
	
	int boardCount();

	List<Board> getNoticAllList(Board board);

	List<Board> getMagazinAllList(Board board);
	
	List<Board> getFreeAllList(Board board);
	
	List<Board> getPhotoAllList(Board board);

	Board boardDetail(int boardId);

	int boardUpdate(Board board);





}
