package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Tags;

public interface TagsService {
	int totalTags();
	List<Tags> listTags(Tags tags);
	int totalUserTags();
	List<Tags> listUserTags(Tags tags);
	int totalBoardTags();
	List<Tags> listBoardTags(Tags tags);
	int totalContentTags();
	List<Tags> listContentTags(Tags tags);
	List<Tags> listTagsAll();
}
