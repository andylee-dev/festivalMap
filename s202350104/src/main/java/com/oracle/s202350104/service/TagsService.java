package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Tags;

public interface TagsService {
	int totalTags();
	List<Tags> listTags(Tags tags);
	int totalUserTags();
	List<Tags> listUserTags(Tags tags);
	int totalBoardTags();
	int totalContentTags();
	List<Tags> listContentTags(Tags tags);
	List<Tags> listTagsAll();
	int insertTags(Tags tags);
	Tags selectTags(int id);
	int updateTags(Tags tags);
	int deleteTags(int id);
	List<Tags> searchContentTags(int contentId);
	List<Tags> listBoardTags(int smallCode);
}
