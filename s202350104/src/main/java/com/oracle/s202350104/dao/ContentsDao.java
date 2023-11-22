package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Contents;

public interface ContentsDao {
	int contentCount();
	
	List<Contents> listContent(Contents content);

	List<Contents> getSearchContentsList(Contents contents);

	int	getTotalSearchCount(Contents contents);

	

	

	
}
