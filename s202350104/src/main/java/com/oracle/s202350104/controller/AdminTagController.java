package com.oracle.s202350104.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.print.attribute.HashAttributeSet;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.oracle.s202350104.model.Areas;
import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.CommonCodes;
import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Course;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.Tags;
import com.oracle.s202350104.model.Users;
import com.oracle.s202350104.service.AccomodationService;
import com.oracle.s202350104.service.BoardService;
import com.oracle.s202350104.service.CommonCodeService;
import com.oracle.s202350104.service.ContentSerivce;
import com.oracle.s202350104.service.CourseService;
import com.oracle.s202350104.service.ExperienceService;
import com.oracle.s202350104.service.FestivalsService;
import com.oracle.s202350104.service.Paging;
import com.oracle.s202350104.service.PagingList;
import com.oracle.s202350104.service.RestaurantService;
import com.oracle.s202350104.service.SpotService;
import com.oracle.s202350104.service.TagsService;
import com.oracle.s202350104.service.user.UserService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping(value = "/admin/tag")
public class AdminTagController {

	private final TagsService ts;
	private final CommonCodeService ccs;
	private final ContentSerivce cs;
	private final BoardService bs;
	private final UserService us;
	private final FestivalsService fs;
	private final CourseService crs;
	
	// 전체 tag list 페이지로 이동
	@RequestMapping(value = "list")
	public String tagList(Tags tags, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "tagList", "start");
			// 검색 조건에 맞는 전체 tags의 데이터수를 저장
			int totalTags = ts.totalTags(tags);
			
			// 페이징 처리
			PagingList page = new PagingList(totalTags, currentPage);
			tags.setStart(page.getStart());
			tags.setEnd(page.getEnd());
			
			// 검색 조건에 맞는 전체 tags의 리스트를 가져와서 저장
			List<Tags> listTags = ts.listTags(tags);
			
			for(Tags tag : listTags) {
				int tagId = tag.getId();
				tag.setUserCnt(ts.selectUserTagsCnt(tagId));
				tag.setBoardCnt(ts.selectBoardTagsCnt(tagId));
				tag.setContentCnt(ts.selectContentTagsCnt(tagId));
				tag.setCourseCnt(ts.selectCourseTagsCnt(tagId));
			}
			
			model.addAttribute("totalTags", totalTags);
			model.addAttribute("listTags", listTags);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "tagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "tagList", "end");
		}		
		
		return "admin/tag/tagList";
	}
	
	// 새 태그를 등록하는 폼으로 이동
	@RequestMapping(value = "insertTagsForm")
	public String insertTagsForm(Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "insertTagsForm", "start");
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "insertTagsForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "insertTagsForm", "end");
		}		
		
		return "admin/tag/insertTagsForm";
	}
	
	// 폼에서 입력한 tag 정보를 insert
	@RequestMapping(value = "insertTagsResult")
	public String insertTagsResult(Tags tags, Model model) {
		UUID transactionId = UUID.randomUUID();
		int result = 0;
		
		try {
			log.info("[{}]{}:{}", transactionId, "insertTagsResult", "start");
			// tag를 insert한 결과를 반환(1이면 성공적으로 insert한 것)
			result = ts.insertTags(tags);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "insertTagsResult", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "insertTagsResult", "end");
		}	
		
		// result 값에 따라 넘어가는 페이지가 다름
		if(result > 0) {			// 성공적으로 insert했을 경우 list페이지로 돌아감
			return "redirect:list"; 
		} else if(result == -1) {	// 기존 태그와 이름이 같을 경우 입력 폼으로 다시 돌아감
			model.addAttribute("msg", "이미 존재하는 태그입니다.");
			return "forward:insertTagsForm";
		} else {					// 등록에 실패했을 경우 입력 폼으로 다시 돌아감
			model.addAttribute("msg", "등록에 실패하였습니다.");
			return "forward:insertTagsForm";
		}
	}
	
	// 태그 정보를 수정하는 폼으로 이동
	@RequestMapping(value = "updateTagsForm")
	public String updateTagsForm(int id, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "updateTagsForm", "start");
			// id에 해당하는 태그 정보를 찾아 저장
			Tags tags = ts.selectTags(id);
			model.addAttribute("tags", tags);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "updateTagsForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "updateTagsForm", "end");
		}		
		
		return "admin/tag/updateTagsForm";
	}
	
	// 폼에서 입력받은 tag 정보를 update
	@PostMapping(value = "updateTagsResult") 
	public String updateTagsResult(Tags tags, Model model) { 
		 UUID transactionId = UUID.randomUUID(); 
		 int result = 0;
		 
		 try { 
			 log.info("[{}]{}:{}", transactionId, "updateTagsResult", "start");
			 // tag 정보를 update한 결과값을 저장(1이면 성공적으로 update된 것)
			 result = ts.updateTags(tags); 
		 } catch (Exception e) {
			 log.error("[{}]{}:{}", transactionId, "updateTagsResult", e.getMessage()); 
		 } finally { 
			 log.info("[{}]{}:{}", transactionId, "updateTagsResult", "end"); 
		 }
	  
		 // result값에 따라 다른 페이지로 이동
		 if(result > 0) { 				// 정상적으로 수정되었을 경우 list 페이지로 이동
			 return "redirect:list"; 
		 } else if(result == -1) {		// 기존 태그와 이름이 같을 경우 다시 수정폼으로 이동
			 model.addAttribute("msg", "이미 존재하는 태그입니다."); 
			 return "forward:updateTagsForm"; 	
		 } else { 						// 등록에 실패했을 경우 다시 수정폼으로 이동
			 model.addAttribute("msg", "등록에 실패하였습니다."); 
			 return "forward:updateTagsForm"; 
		 } 
	}
	  
	// 태그 정보를 삭제
	@RequestMapping(value = "deleteTags")
	public String deleteTags(int tagId) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "deleteTags", "start");
			// tagId에 해당하는 태그 정보를 찾아 삭제
			int result = ts.deleteTags(tagId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "deleteTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "deleteTags", "end");
		}		
		
		return "redirect:list";
	}
	
	// 회원 태그 관리 페이지로 이동
	@RequestMapping(value = "userTag")
	public String userTagList(Users user, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		
		try {
			log.info("[{}]{}:{}", transactionId, "userTagList", "start");
			user.setSmall_code(2);				  // 일반회원 small code 지정
			int totalUsers = us.totalUsers(user); // 일반회원수만 반환
			log.info("totalUsers => " + totalUsers);
			
			// 페이징 처리
			PagingList page = new PagingList(totalUsers, currentPage);
			user.setStart(page.getStart());
			user.setEnd(page.getEnd());
			
			List<Users> listUsers = us.getSearchUserList(user); // 일반회원 리스트만 반환
			log.info("listUsers => " + listUsers.size());
			
			model.addAttribute("totalUsers", totalUsers);
			model.addAttribute("listUsers", listUsers);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "userTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "userTagList", "end");
		}	
		
		return "admin/tag/userTag";
	}
	
	// 회원 태그 리스트를 전부 view로 보내줌
	@ResponseBody
	@RequestMapping(value = "getUserTags")
	public List<Tags> getUserTags(Model model) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> listTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getUserTags", "start");
			Tags tags = new Tags();
			listTags = ts.listUserTags(tags);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getUserTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getUserTags", "end");
		}	
		
		return listTags;
	}
	
	// 게시판 태그 관리 페이지로 이동
	@RequestMapping(value = "boardTag")
	public String boardTagList(Board board, String smallCodeStr, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		// String으로 받은 smallCode값을 int형으로 변환
		int smallCode = 0;
		if(smallCodeStr == null || smallCodeStr == "") {
			smallCode = 2;	// code값이 null일 경우 2로 강제 지정(매거진)
		} else {
			smallCode = Integer.parseInt(smallCodeStr);
		}
		log.info("controller smallCode => " +smallCode);
		
		try {
			log.info("[{}]{}:{}", transactionId, "boardTagList", "start");
			
			// smallCode에 해당하는 Board의 총 데이터 수를 저장
			int totalBoard = bs.boardCount(smallCode);
			log.info("controller totalBoard => " +totalBoard);
			
			// 페이징 처리
			PagingList page = new PagingList(totalBoard, currentPage);
			board.setStart(page.getStart());
			board.setEnd(page.getEnd());
			
			// smallCode에 따라 해당하는 Board의 list를 저장
			List<Board> listBoard = null;
			switch(smallCode) {
				case 2: listBoard = bs.getMagazinAllList(board); break;
				case 3: listBoard = bs.getFreeAllList(board); break;
				case 4: listBoard = bs.getPhotoAllList(board); break;
				case 5: listBoard = bs.getEventAllList(board); break;
				case 6: listBoard = bs.getReviewAllList(board);
			}
			log.info("controller listBoard => " +listBoard.size());
			
			model.addAttribute("totalBoard", totalBoard);
			model.addAttribute("listBoard", listBoard);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "boardTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "boardTagList", "end");
		}		
		
		return "admin/tag/boardTag";
	}
	
	// 게시판 태그 리스트를 전부 view로 보내줌
	@ResponseBody
	@RequestMapping(value = "getBoardTags")
	public List<Tags> getBoardTags(String smallCodeStr, Model model) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> listTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getBoardTags", "start");
			int smallCode = Integer.parseInt(smallCodeStr);
			log.info("smallCode=>" + smallCode);
			listTags = ts.listBoardTags(smallCode);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getBoardTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getBoardTags", "end");
		}	
		
		return listTags;
	}
	
	// 게시글 태그를 수정하는 폼으로 이동
	@RequestMapping(value = "boardTagsUpdateForm")
	public String boardTagsUpdate(String boardIdStr, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		// String으로 받은 boardId를 int형으로 변환
		int boardId = 0;
		if(boardIdStr == null) {
			boardId = 0;	// boardId가 null일 경우 0으로 지정
		} else {
			boardId = Integer.parseInt(boardIdStr);
		}
		
		try {
			log.info("[{}]{}:{}", transactionId, "boardTagsUpdateForm", "start");
			Board board = bs.boardDetail(boardId);
			List<Tags> listMyTags = ts.searchBoardTagsOne(boardId);
			
			Tags tags = new Tags();
			List<Tags> listAllTags = ts.listTags(tags);
			
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("board", board);
			model.addAttribute("listMyTags", listMyTags);
			model.addAttribute("listAllTags", listAllTags);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "boardTagsUpdateForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "boardTagsUpdateForm", "end");
		}	
		
		return "admin/tag/boardTagsUpdateForm";
	}
	
	// tag를 수정하고 그 결과에 따라 메세지를 반환(AJAX 연결)
	@ResponseBody
	@RequestMapping(value = "boardTagsUpdate")
	public String boardTagsUpdate(@RequestParam(value = "tagId[]", required = false) int[] finalTags, int boardId, Model model) {
		UUID transactionId = UUID.randomUUID();
		String str = "";
		
		try {
			log.info("[{}]{}:{}", transactionId, "boardTagsUpdate", "start");
			int result = ts.updateBoardTags(boardId, finalTags); 
			// update결과에 따라 다른 메세지 반환
			if(result == 1) { 
				str = "태그 수정이 성공적으로 완료되었습니다."; 
			} else { 
				str = "태그 수정에 실패하였습니다."; 
			}
			log.info("finalTags"+finalTags.toString());
			log.info("boardId"+boardId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "boardTagsUpdate", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "boardTagsUpdate", "end");
		}	
		
		return str;
	}
	
	// 컨텐츠 태그 관리 페이지로 이동
	@RequestMapping(value = "contentTag")
	public String contentTagList(Contents content, String bigCodeStr, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		// String으로 받은 bigCode값을 int형으로 변환
		int bigCode = 0;
		if(bigCodeStr == null) {
			bigCode = 2;
		} else {
			bigCode = Integer.parseInt(bigCodeStr);
		}
		log.info("controller bigCode => " +bigCode);
		content.setBig_code(bigCode);
		
		try {
			log.info("[{}]{}:{}", transactionId, "contentTagList", "start");
			
			// bigCode에 따라 컨텐츠의 totalContents 조회
			int totalContents = cs.getTotalSearchCount(content);
			
			// 페이징 처리
			PagingList page = new PagingList(totalContents, currentPage);
			content.setStart(page.getStart());
			content.setEnd(page.getEnd());
			
			// bigCode에 따라 listContent 조회
			List<Contents> listContent = cs.getSearchContentsList(content); 

			log.info("controller listContent => " +listContent.size());
			log.info("totalContents => " +totalContents);
			
			model.addAttribute("bigCode", bigCode);
			model.addAttribute("totalContents", totalContents);
			model.addAttribute("listContent", listContent);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "contentTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "contentTagList", "end");
		}	
		
		return "admin/tag/contentTag";
	}
	
	// 컨텐츠 태그 수정폼으로 이동
	@RequestMapping(value = "contentTagsUpdateForm")
	public String contentTagsUpdate(String contentIdStr, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		// String으로 받은 contentId를 int형으로 변환
		int contentId = 0;
		if(contentIdStr == null || contentIdStr == "") {
			contentId = 0;
		} else {
			contentId = Integer.parseInt(contentIdStr);
		}
		
		try {
			 log.info("[{}]{}:{}", transactionId, "contentTagsUpdateForm", "start");
			
			 // 수정할 컨텐츠의 상세정보 저장
			 Contents contents = fs.detailContents(contentId);
			 List<Tags> listMyTags = ts.searchContentTags(contentId); 
			 
			 // 전체 태그 리스트 저장
			 Tags tags = new Tags(); 
			 List<Tags> listAllTags = ts.listTags(tags);
			  
			 model.addAttribute("currentPage", currentPage); 
			 model.addAttribute("contents", contents); 
			 model.addAttribute("listMyTags", listMyTags);
			 model.addAttribute("listAllTags", listAllTags);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "contentTagsUpdateForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "contentTagsUpdateForm", "end");
		}	
		
		return "admin/tag/contentTagsUpdateForm";
	}
	
	// 컨텐츠 태그를 수정하고 결과 메세지를 반환(AJAX 연결)
	@ResponseBody
	@RequestMapping(value = "contentTagsUpdate")
	public String contentTagsUpdate(@RequestParam(value = "tagId[]", required = false) int[] finalTags, int contentId, Model model) {
		UUID transactionId = UUID.randomUUID();
		String str = "";
		
		try {
			log.info("[{}]{}:{}", transactionId, "contentTagsUpdate", "start");
			int result = ts.updateContentTags(contentId, finalTags); 
			// 결과값에 따라 다른 메세지 반환
			if(result == 1) { 
				str = "태그 수정이 성공적으로 완료되었습니다."; 
			} else { 
				str = "태그 수정에 실패하였습니다."; 
			}
			log.info("finalTags"+finalTags);
			log.info("contentId"+contentId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "contentTagsUpdate", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "contentTagsUpdate", "end");
		}	
		
		return str;
	}
	
	// bigCode에 해당하는 컨텐츠 태그 리스트 전부 가져오기(AJAX 연결)
	@ResponseBody
	@RequestMapping(value = "getContentTags")
	public List<Tags> getContentTags(String bigCodeStr, Model model) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> listTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getContentTags", "start");
			int bigCode = Integer.parseInt(bigCodeStr);
			log.info("bigCode=>" + bigCode);
			listTags = ts.listContentTags(bigCode);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getContentTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getContentTags", "end");
		}
		
		return listTags;
	}
	
	// 코스 태그 관리 페이지로 이동
	@RequestMapping(value = "courseTag")
	public String courseTagList(Course course, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
			
		try {
			log.info("[{}]{}:{}", transactionId, "contentTagList", "start");
				
			// 전체 코스 수 조회 => 추후 검색 조건 설정
			int totalCourses = crs.courseCount();
				
			// 페이징 처리
			PagingList page = new PagingList(totalCourses, currentPage);
			course.setStart(page.getStart());
			course.setEnd(page.getEnd());
				
			// 전체 코스 리스트 조회 => 추후 검색 조건 설정
			List<Course> listCourse = crs.courseList(course);

			log.info("controller listCourse => " +listCourse.size());
			log.info("totalCourses => " +totalCourses);
				
			model.addAttribute("totalCourses", totalCourses);
			model.addAttribute("listCourse", listCourse);
			model.addAttribute("page", page);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "contentTagList", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "contentTagList", "end");
		}	
			
		return "admin/tag/courseTag";
	}
	
	// 코스 태그 리스트를 전부 가져오기(AJAX 연결) => 추후 small_code에 맞게 가져올 수 있도록 수정 예정
	@ResponseBody
	@RequestMapping(value = "getCourseTags")
	public List<Tags> getCourseTags(Model model) {
		UUID transactionId = UUID.randomUUID();
		List<Tags> listTags = null;
		
		try {
			log.info("[{}]{}:{}", transactionId, "getCourseTags", "start");
			listTags = ts.listCourseTags();
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "getCourseTags", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "getCourseTags", "end");
		}
		
		return listTags;
	}
	
	// 코스 태그 수정폼으로 이동
	@RequestMapping(value = "courseTagsUpdateForm")
	public String courseTagsUpdate(String courseIdStr, String currentPage, Model model) {
		UUID transactionId = UUID.randomUUID();
		// String으로 받은 contentId를 int형으로 변환
		int courseId = 0;
		if(courseIdStr == null || courseIdStr == "") {
			courseId = 0;
		} else {
			courseId = Integer.parseInt(courseIdStr);
		}
			
		try {
			 log.info("[{}]{}:{}", transactionId, "courseTagsUpdateForm", "start");
			
			 // 수정할 코스의 상세정보 저장
			 // Course course = crs.courseDetail(courseId);
			 List<Tags> listMyTags = ts.searchCourseTags(courseId); 
				 
			 // 전체 태그 리스트 저장
			 Tags tags = new Tags(); 
			 List<Tags> listAllTags = ts.listTags(tags);
				  
			 model.addAttribute("courseId", courseId);
			 model.addAttribute("currentPage", currentPage); 
			 // model.addAttribute("course", course); 
			 model.addAttribute("listMyTags", listMyTags);
			 model.addAttribute("listAllTags", listAllTags);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "courseTagsUpdateForm", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "courseTagsUpdateForm", "end");
		}	
			
		return "admin/tag/courseTagsUpdateForm";
	}
		
	// 코스 태그를 수정하고 결과 메세지를 반환(AJAX 연결)
	@ResponseBody
	@RequestMapping(value = "courseTagsUpdate")
	public String courseTagsUpdate(@RequestParam(value = "tagId[]", required = false) int[] finalTags, int courseId, Model model) {
		UUID transactionId = UUID.randomUUID();
		String str = "";
			
		try {
			log.info("[{}]{}:{}", transactionId, "courseTagsUpdate", "start");
			int result = ts.updateCourseTags(courseId, finalTags); 
			// 결과값에 따라 다른 메세지 반환
			if(result == 1) { 
				str = "태그 수정이 성공적으로 완료되었습니다."; 
			} else { 
				str = "태그 수정에 실패하였습니다."; 
			}
			log.info("finalTags"+finalTags);
			log.info("courseId"+courseId);
		} catch (Exception e) {
			log.error("[{}]{}:{}", transactionId, "courseTagsUpdate", e.getMessage());
		} finally {
			log.info("[{}]{}:{}", transactionId, "courseTagsUpdate", "end");
		}	
			
		return str;
	}
	
}
