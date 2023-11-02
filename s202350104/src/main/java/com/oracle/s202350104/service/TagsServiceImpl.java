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
	public int totalTags() {
		int totalTagsCnt = td.totalTags();
		return totalTagsCnt;
	}
	
	@Override
	public List<Tags> listTags(Tags tags) {
		List<Tags> listTags = td.listTags(tags);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

	@Override
	public int totalUserTags() {
		int totalTagsCnt = td.totalUserTags();
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listUserTags(Tags tags) {
		List<Tags> listTags = td.listUserTags(tags);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

	@Override
	public int totalBoardTags() {
		int totalTagsCnt = td.totalBoardTags();
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listBoardTags(Tags tags) {
		List<Tags> listTags = td.listBoardTags(tags);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "게시판 태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

	@Override
	public int totalContentTags() {
		int totalTagsCnt = td.totalContentTags();
		return totalTagsCnt;
	}

	@Override
	public List<Tags> listContentTags(Tags tags) {
		List<Tags> listTags = td.listContentTags(tags);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "콘텐츠 태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

	@Override
	public List<Tags> listTagsAll() {
		List<Tags> listTags = td.listTagsAll();
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

	@Override
	public int insertTags(Tags tags) {
		int result = td.insertTags(tags);
		
		return result;
	}

}
