package com.oracle.s202350104.service;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.TagsDao;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;

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
		// 전체 tag 리스트를 listTags에 저장
		List<Tags> listTags = td.listTags(tag);
		
		int result = 0;
		int searchResult = 1;
		
		// 이미 존재하는 tag인 경우 insert되지 않도록 DB에 저장된 tag(searchTag)와 tags의 name을 비교
		for(Tags searchTag : listTags) {
			if(tags.getName().equals(searchTag.getName())) {
				searchResult = 0;
			}
		}
		
		// searchResult의 값에 따라 tag를 insert하고 그 결과값 반환
		if(searchResult == 1) {
			result = td.insertTags(tags);
		} else {
			result = -1;
		}
		
		return result;
	}

	// 파라미터로 들어간 tag의 id에 해당하는 tag 정보를 반환
	@Override
	public Tags selectTags(int id) {
		Tags tags = td.selectTags(id);
		
		return tags;
	}

	@Override
	public int updateTags(Tags tags) {
		Tags tag = new Tags();
		// 전체 tag리스트를 listTags에 저장
		List<Tags> listTags = td.listTags(tag);
		
		int result = 0;
		int searchResult = 1;
		
		// 이미 존재하는 tag name인 경우 update되지 않도록
		for(Tags searchTag : listTags) {
			if(tags.getName().equals(searchTag.getName())) {
				searchResult = 0;
			}
		}
		
		// searchResult에 따라 update하고 그 결과값 반환
		if(searchResult == 1) {
			result = td.updateTags(tags);
		} else {
			result = -1;
		}
		
		return result;
	}

	// tags 테이블에서 태그 정보 삭제
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
	public List<Tags> searchBoardTagsOne(int boardId) {
		List<Tags> listTags = td.searchBoardTagsOne(boardId);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "게시판 태그가 존재하지 않습니다.");
		}
		
		return listTags;
		
	}
	
	@Override
	public List<Tags> searchCourseTags(int courseId) {
		List<Tags> listTags = td.searchCourseTags(courseId);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "코스 태그가 존재하지 않습니다.");
		}
		
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
	public List<Tags> listCourseTags(int smallCode) {
		List<Tags> listTags = td.listCourseTags(smallCode);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "코스 태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}
	
	@Override
	public int updateBoardTags(int boardId, int[] finalTags) {
		int result = td.updateBoardTags(boardId, finalTags);
		
		return result;
	}
	
	@Override
	public int updateContentTags(int contentId, int[] finalTags) {
		int result = td.updateContentTags(contentId, finalTags);
		
		return result;
	}
	
	@Override
	public int updateCourseTags(int courseId, int[] finalTags) {
		int result = td.updateCourseTags(courseId, finalTags);
		
		return result;
	}
	

	@Override
	public int selectUserTagsCnt(int tagId) {
		int result = td.selectUserTagsCnt(tagId);
		
		return result;
	}

	@Override
	public int selectBoardTagsCnt(int tagId) {
		int result = td.selectBoardTagsCnt(tagId);
		
		return result;
	}

	@Override
	public int selectContentTagsCnt(int tagId) {
		int result = td.selectContentTagsCnt(tagId);
		
		return result;
	}

	@Override
	public int selectCourseTagsCnt(int tagId) {
		int result = td.selectCourseTagsCnt(tagId);
		
		return result;
	}
	

	@Override
	public int userTagsTotal(Tags tag) {
		int totalUsers = td.userTagsTotal(tag);
		
		return totalUsers;
	}

	@Override
	public List<Tags> searchUserTagsList(Tags tag) {
		List<Tags> listUsers = td.searchUserTagsList(tag);
		
		if(listUsers == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "회원 리스트가 존재하지 않습니다.");
		}
		
		return listUsers;
	}
	
	@Override
	public int boardTagsTotal(Tags tag) {
		int totalBoards = td.boardTagsTotal(tag);
		
		return totalBoards;
	}

	@Override
	public List<Tags> searchBoardTagsList(Tags tag) {
		List<Tags> listBoard = td.searchBoardTagsList(tag);
		
		if(listBoard == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "게시글 리스트가 존재하지 않습니다.");
		}
		
		return listBoard;
	}
	
	@Override
	public int contentTagsTotal(Tags tag) {
		int totalContents = td.contentTagsTotal(tag);
		
		return totalContents;
	}

	@Override
	public List<Tags> searchContentTagsList(Tags tag) {
		List<Tags> listContent = td.searchContentTagsList(tag);
		
		if(listContent == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "컨텐츠 리스트가 존재하지 않습니다.");
		}
		
		return listContent;
	}
	
	@Override
	public int courseTagsTotal(Tags tag) {
		int totalCourses = td.courseTagsTotal(tag);
		
		return totalCourses;
	}

	@Override
	public List<Tags> searchCourseTagsList(Tags tag) {
		List<Tags> listCourse = td.searchCourseTagsList(tag);
		
		if(listCourse == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "코스 리스트가 존재하지 않습니다.");
		}
		
		return listCourse;
	}
	
	@Override
	public List<Tags> searchUserTagsOne(int userId) {
		List<Tags> listTags = td.searchUserTagsOne(userId);
		
		if(listTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "태그 리스트가 존재하지 않습니다.");
		}
		
		return listTags;
	}
	
	@Override
	public int updateUserTags(int userId, int[] finalTags) {
		int result = td.updateUserTags(userId, finalTags);
		
		return result;
	}
	
	@Override
	public List<Tags> userPopularTags() {
		List<Tags> listPopularTags = td.userPopularTags();
		
		if(listPopularTags == null) {
			throw new ResponseStatusException(HttpStatus.NOT_FOUND, "태그 리스트가 존재하지 않습니다.");
		}
		
		return listPopularTags;
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
