package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Repository;

import com.oracle.s202350104.dao.ContentsDao;
import com.oracle.s202350104.model.Contents;

import lombok.RequiredArgsConstructor;


@Repository
@RequiredArgsConstructor
public class ContentServiceImpl implements ContentSerivce {
	
	private final ContentsDao cd;
	
	@Override
	public List<Contents> listContents() {
		List<Contents> listContents = cd.listContent();
		return listContents;
	}

}
