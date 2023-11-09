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
	public int totalBoardTags() {
		int totalTagsCnt = td.totalBoardTags();
		return totalTagsCnt;
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
		List<Tags> listTags = td.listTagsAll();
		int result = 0;
		int searchResult = 0;
		// 이미 존재하는 tag인 경우 insert되지 않도록
		for(Tags searchTag : listTags) {
			if(tags.getName().equals(searchTag.getName())) {
				searchResult = 1;
			}
		}
		
		if(searchResult != 1) {
			result = td.insertTags(tags);
		} else {
			result = -1;
		}
		
		return result;
	}

	@Override
	public Tags selectTags(int id) {
		Tags tags = td.selectTags(id);
		return tags;
	}

	@Override
	public int updateTags(Tags tags) {
		List<Tags> listTags = td.listTagsAll();
		int result = 0;
		int searchResult = 0;
		// 이미 존재하는 tag인 경우 update되지 않도록
		for(Tags searchTag : listTags) {
			if(tags.getName().equals(searchTag.getName())) {
				searchResult = 1;
			}
		}
		
		if(searchResult != 1) {
			result = td.updateTags(tags);
		} else {
			result = -1;
		}
		
		return result;
	}

	@Override
	public int deleteTags(int id) {
		int result = td.deleteTags(id);
		return result;
	}

	@Override
	public List<Tags> searchContentTags(int contentId) {
		List<Tags> listTags = td.searchContentTags(contentId);
		return listTags;
	}

	@Override
	public List<Tags> listBoardTags(int smallCode) {
		List<Tags> listTags = td.listBoardTags(smallCode);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "게시판 태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

	@Override
	public List<Tags> listUserTags() {
		List<Tags> listTags = td.listUserTags();
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

}
