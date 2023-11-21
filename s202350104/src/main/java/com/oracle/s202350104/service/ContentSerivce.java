package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Contents;


public interface ContentSerivce {
	List<Contents> 		listContents();
	int 				contentCount();
	List<Contents> 		getSearchContentsList(Contents contents);
	int 				getTotalSearchCount(Contents contents);
	
}  
