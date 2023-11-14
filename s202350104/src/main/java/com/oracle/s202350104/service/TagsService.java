package com.oracle.s202350104.service;

import java.util.List;
import java.util.Map;

import com.oracle.s202350104.model.Tags;

public interface TagsService {
	int totalTags(Tags tags);
	List<Tags> listTags(Tags tags);
	int insertTags(Tags tags);
	Tags selectTags(int id);
	int updateTags(Tags tags);
	int deleteTags(int id);
	List<Tags> searchContentTags(int contentId);
	List<Tags> listBoardTags(int smallCode);
	List<Tags> listUserTags(Tags tags);
	List<Tags> listContentTags(int bigCode);
	List<Tags> searchBoardTagsOne(int boardId);
	void boardTagsInsert(Tags tags);
	List<Tags> boardTagDetail(int id);
	int boardTagDelete(int id);
	int updateBoardTags(int boardId, int[] finalTags);
	
}
