package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.TagsDao;
import com.oracle.s202350104.model.Tags;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class TagsServiceImpl implements TagsService {

	private final TagsDao td;
	
	@Override
	public List<Tags> listTags(Tags tags) {
		List<Tags> listTags = td.listTags(tags);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

	@Override
	public int totalTags() {
		int totalTagsCnt = td.totalTags();
		return totalTagsCnt;
	}

}
