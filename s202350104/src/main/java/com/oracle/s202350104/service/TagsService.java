package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Tags;

public interface TagsService {
	List<Tags> listTags(Tags tags);
	int totalTags();
}
