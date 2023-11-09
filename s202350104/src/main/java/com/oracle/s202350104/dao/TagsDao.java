package com.oracle.s202350104.dao;

import java.util.List;
import java.util.Map;

import com.oracle.s202350104.model.Tags;

public interface TagsDao {
	int totalTags();
	List<Tags> listTags(Tags tag);
	int totalUserTags();
	int totalBoardTags();
	int totalContentTags();
	List<Tags> listTagsAll();
	int insertTags(Tags tags);
	Tags selectTags(int id);
	int updateTags(Tags tags);
	int deleteTags(int id);
	List<Tags> searchContentTags(int contentId);
	List<Tags> listBoardTags(int smallCode);
	List<Tags> listUserTags();

	List<Tags> listContentTags(int bigCode);
	List<Tags> searchBoardTagsOne(int boardId);

	void insertBoardTags(Map<String, Object> params);

}
