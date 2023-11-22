package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Contents;


public interface ContentSerivce {
	List<Contents> 		listContents(Contents content);
	int 				contentCount(Contents content);
	List<Contents> 		getSearchContentsList(Contents contents);
	int 				getTotalSearchCount(Contents contents);
}  
