package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Board;
import com.oracle.s202350104.model.FestivalsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class BoardDaoImpl implements BoardDao {

	private final SqlSession session;

	// 조회수 증가 logic
	public void readCountUp(int boardId) {

		log.info("BoardDao readCountUp boardId : {}", boardId);

		try {
			session.selectOne("readCountUp", boardId);
		} catch (Exception e) {
			log.error("BoardDao readCountUp Exception : {}", e.getMessage());
		}
	}
	
	@Override
	public int boardCount2(Board board) {
		
		int countBoardResult = session.selectOne("reviewBoardCount", board);
		
		log.info("BoardDao boardCount2 countBoardResult : {}", countBoardResult);
		
		return countBoardResult;
	}

	// Paging 처리용
	@Override
	public int boardCount(Board board) {

		int countBoard = 0;

		try {
			countBoard = session.selectOne("boardCount", board);
		} catch (Exception e) {
			log.error("BoardDao boardCount Exception : {}", e.getMessage());
		}

		return countBoard;
	}

	// 공지사항, DB연동
	@Override
	public List<Board> getNoticAllList(Board board) {

		List<Board> noticAllList = null;

		try {
			noticAllList = session.selectList("noticAllList", board);
			log.info("BoardDao getNoticAllList size : {}", noticAllList.size());

		} catch (Exception e) {
			log.error("BoardDao getNoticAllList Exception : {}", e.getMessage());
		}

		return noticAllList;
	}

	// 이달의 소식, DB연동
	@Override
	public List<Board> getMagazinAllList(Board board) {

		List<Board> magazinAllList = null;

		try {
			magazinAllList = session.selectList("magazinAllList", board);
			log.info("BoardDao getMagazinAllList size : {}", magazinAllList.size());

		} catch (Exception e) {
			log.error("BoardDao getMagazinAllList Exception : {}", e.getMessage());
		}

		return magazinAllList;
	}

	// 자유게시판, DB연동
	@Override
	public List<Board> getFreeAllList(Board board) {

		List<Board> freeAllList = session.selectList("freeAllList", board);

		log.info("BoardDao getFreeAllList size : {}", freeAllList.size());

		return freeAllList;
	}

	// 포토게시판, DB연동
	@Override
	public List<Board> getPhotoAllList(Board board) {

		List<Board> photoAllList = null;

		try {
			photoAllList = session.selectList("photoAllList", board);
		} catch (Exception e) {
			log.error("BoardDao getPhotoAllList Exception : {}", e.getMessage());
		} finally {
			log.info("BoardDao getPhotoAllList End");
		}

		return photoAllList;
	}

	// 이벤트게시판, DB연동
	@Override
	public List<Board> getEventAllList(Board board) {

		List<Board> eventAllList = null;

		try {
			eventAllList = session.selectList("eventAllList", board);
		} catch (Exception e) {
			log.error("BoardDao getPhotoAllList Exception : {}", e.getMessage());
		} finally {
			log.info("BoardDao getPhotoAllList End");
		}

		return eventAllList;
	}

	// review, DB연동
	@Override
	public List<Board> getReviewAllList(Board board) {
		log.info("BoardDao getReviewAllList Start!!");
		log.info("boardService reviewBoardList board.getContentId : {} ", board.getContent_id());
		log.info("boardService reviewBoardList board.getUser_id : {} ", board.getUser_id());

		int userId = board.getUser_id();
		int contentId = board.getContent_id();
		List<Board> reviewAllList = null;

		try {
			// contentId or userId로 출력 할 review handling
			if (contentId > 1 || userId > 1) {
				reviewAllList = session.selectList("reviewAllList", board);

				log.info("BoardDao reviewAllList size : {}", reviewAllList.size());
				log.info("BoardDao reviewAllList content : {}", reviewAllList.get(0).getContent());

			} else {
				reviewAllList = session.selectList("reviewAllList2", board);

				log.info("BoardDao reviewAllList2 size : {}", reviewAllList.size());
				log.info("BoardDao reviewAllList2 content : {}", reviewAllList.get(0).getContent());
			}

		} catch (Exception e) {
			log.error("BoardDao getReviewAllList Exception : {}", e.getMessage());
		}

		log.info("BoardDao getReviewAllList End..");

		return reviewAllList;
	}

	// 통합게시판 상세정보, DB연동
	@Override
	public Board boardDetail(int boardId) {

		Board boards = null;

		try {
			boards = session.selectOne("boardDetail", boardId);
			log.info("BoardDao boardDetail getTitle : {}", boards.getTitle());

			readCountUp(boardId);

		} catch (Exception e) {
			log.error("BoardDao boardDetail Exception : {}", e.getMessage());
		}

		return boards;
	}
	
	// 통합게시판 생성, DB연동
	@Override
	public int boardInsert(Board board) {

		int insertBoard = 0;
		int insertHandling = board.getContent_id();

		log.info("BoardDao boardInsert getContent_id : {}", insertHandling);
		try {
			// contentId 값이 있으면 review query 실행 
			if(insertHandling > 0) {
				insertBoard = session.insert("reviewBoardInsert", board);
			} else {
				insertBoard = session.insert("boardInsert", board);
			}

		} catch (Exception e) {
			log.error("BoardDao boardInsert Exception : {}", e.getMessage());
		}

		return insertBoard;

	}		

	// 통합게시판 수정, DB연동
	@Override
	public int boardUpdate(Board board) {

		int updateBoard = 0;
		log.info("BoardDao boardUpdate getFile_name : {}", board.getFile_name());
		
		try {
			if(board.getFile_name() == null) {
				log.info("BoardDao boardUpdate normal Start!!");				
				updateBoard = session.update("boardUpdate2", board);
			} else {
				log.info("BoardDao boardUpdate image Start!!");				
				updateBoard = session.update("boardUpdate", board);
			}	

		} catch (Exception e) {
			log.error("BoardDao boardUpdate Exception : {}", e.getMessage());
		}

		return updateBoard;
	}

	// 통합게시판 삭제, DB연동
	@Override
	public int boardDelete(int boardId) {

		int deleteBoard = 0;

		try {
			log.info("BoardDao boardDelete Start!!");
			
			//deleteBoard = session.delete("boardDelete", boardId);
			
			deleteBoard = session.update("boardDeleteNew", boardId);
		} catch (Exception e) {
			log.error("BoardDao boardDelete Exception : {}", e.getMessage());
		} finally {
			log.info("BoardDao boardDelete End..");			
		}

		return deleteBoard;
	}
	
	// 통합게시판 첨부파일 삭제, DB연동
	@Override
	public Board boardRead(int id) {
		
		Board board = null;
		
		try {
			log.info("BoardDao boardRead Start!!");
			
			board = session.selectOne("boardImageRead", id);
			log.info("BoardDao boardRead getTitle : {}", board.getTitle());
			
		} catch (Exception e) {
			log.error("BoardDao boardRead Exception : {}", e.getMessage());
		} finally {
			log.info("BoardDao boardRead End..");			
		}
		
		return board;
	}
	
	@Override
	public void commentInsert(Board board) {
		log.info("BoardDao commentInsert Start!!");
		
		int comment_group_id = 0;
		int comment_step = 0;
		int comment_indent = 0; 
		
		commentShape(board);
		
		board.setComment_group_id(board.getComment_group_id());
		board.setComment_step(board.getComment_step() + 1);
		board.setComment_indent(board.getComment_indent() + 1);
		

		comment_group_id = board.getComment_group_id();
		comment_step = board.getComment_step();
		comment_indent = board.getComment_indent();
		
		log.info("BoardDao commentInsert getId : {}", board.getId());
		log.info("BoardDao commentInsert getUser_id : {}", board.getUser_id());
		log.info("BoardDao commentInsert getBig_code : {}", board.getBig_code());
		log.info("BoardDao commentInsert getSmall_code : {}", board.getSmall_code());
		log.info("BoardDao commentInsert getComment_group_id : {}", comment_group_id);
		log.info("BoardDao commentInsert getComment_step : {}", comment_step);
		log.info("BoardDao commentInsert getComment_indent : {}", comment_indent);
		
		session.insert("commentInsert", board);

	}

	private void commentShape(Board board) {
		log.info("BoardDao commentShape Start!!");	
		
		int comment_group_id = 0;
		int comment_step = 0; 
		
		comment_group_id = board.getComment_group_id();
		comment_step = board.getComment_step();
		
		log.info("BoardDao commentInsert comment_group_id : {}", comment_group_id);
		log.info("BoardDao commentInsert comment_step : {}", comment_step);		
		
		session.update("commentInsertTest", board);
		
	}
	
	@Override
	public List<Board> commentDetail(int id) {
		
		List<Board> comments = session.selectList("commentDetail", id);
		log.info("BoardDao comments size : {}", comments.size());		
		return comments;
	}
	
	@Override
	public List<Board> getBoardOneList(Board board) {
		
		List<Board> boardOneList = session.selectList("getBoardOneList", board);
		log.info("BoardDao getBoardOneList size : {}", boardOneList.size());		
		
		return boardOneList;
	}
	
	@Override
	public List<Board> getReviewOneList(Board board) {
		List<Board> reviewOneList = session.selectList("getReviewOneList", board);
		log.info("BoardDao getReviewOneList size : {}", reviewOneList.size());		
		
		return reviewOneList;
	}
	 
	@Override
	public double getReviewCount(Board board) {
		double reviewCount = session.selectOne("test",board); 
		log.info("BoardDao reviewCount : {}", reviewCount);
		return reviewCount;
	}
	
	@Override
	public int boardDeleteNew(int id) {
		int newDeleteBoard = session.update("boardDeleteNew",id);
		return newDeleteBoard;
	}
	
	@Override
	public int boardRecycle(int id) {
		int recycleBoard = session.update("boardRecycle",id);
		return recycleBoard;
	}
}
