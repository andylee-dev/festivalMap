package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Tags;

public interface TagsDao {
	int totalTags();
	List<Tags> listTags(Tags tag);
	int totalUserTags();
	List<Tags> listUserTags(Tags tags);
	int totalBoardTags();
	List<Tags> listBoardTags(Tags tags);
	int totalContentTags();
	List<Tags> listContentTags(Tags tags);
	List<Tags> listTagsAll();
	int insertTags(Tags tags);
}
