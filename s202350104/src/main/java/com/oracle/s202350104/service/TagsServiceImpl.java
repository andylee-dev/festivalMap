package com.oracle.s202350104.service;

import java.util.List;
import java.util.Map;

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
	public int totalTags(Tags tags) {
		int totalTagsCnt = td.totalTags(tags);
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
	public int insertTags(Tags tags) {
		Tags tag = new Tags();
		List<Tags> listTags = td.listTags(tag);
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
		Tags tag = new Tags();
		List<Tags> listTags = td.listTags(tag);
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
	public List<Tags> listUserTags(Tags tags) {
		List<Tags> listTags = td.listUserTags(tags);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}


	@Override
	public List<Tags> listContentTags(int bigCode) {
		List<Tags> listTags = td.listContentTags(bigCode);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "콘텐츠 태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}

	@Override
	public List<Tags> searchBoardTagsOne(int boardId) {
		List<Tags> listTags = td.searchBoardTagsOne(boardId);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "게시판 태그가 존재하지 않습니다.");
		}
		
		return listTags;
		
	}
	
	@Override
	public int updateBoardTags(int boardId, int[] finalTags) {
		int result = td.updateBoardTags(boardId, finalTags);
		return result;
	}
	
	/*
	 * 통합게시물 생성 Logic >> boardTagsInsert
	 * by. 엄민용
	 * */		
	@Override
	public void boardTagsInsert(Tags tags) {
		log.info("service getTag_id : {}", tags.getTag_id());
		log.info("service getBoard_id : {}", tags.getBoard_id());
		
		td.boardTagsInsert(tags);

	}
	
	@Override
	public List<Tags> boardTagDetail(int id) {
		List<Tags> hashTags = td.boardTagDetail(id);
		return hashTags;
	}
	
	@Override
	public int boardTagDelete(int id) {
	 	int deleteResult = td.boardTagDelete(id);	
	 	
	 	return deleteResult;
	}

}
