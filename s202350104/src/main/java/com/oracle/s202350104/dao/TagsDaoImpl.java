package com.oracle.s202350104.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.s202350104.model.Tags;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class TagsDaoImpl implements TagsDao {
	
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	@Override
	public int totalTags(Tags tags) {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhTagsTotal", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl totalTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}
	
	// tags의 모든 데이터 list를 출력하는 dao(keyword / 페이징 작업을 위한 start-end를 설정하면 조건에 맞춰서 출력)
	@Override
	public List<Tags> listTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhTagsListAll", tags);
			log.info("TagsDaoImpl listTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public int totalUserTags(Tags tags) {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhUserTagsTotal", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl totalUserTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	} 

	@Override
	public int totalBoardTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhBoardTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalBoardTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	@Override
	public int totalContentTags() {
		int totalTagsCnt = 0;
		try {
			totalTagsCnt = session.selectOne("nhContentTagsTotal");
		} catch(Exception e) {
			log.info("TagsDaoImpl totalContentTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	@Override
	public int insertTags(Tags tags) {
		int result = 0;
		try {
			result = session.insert("nhTagsInsert", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl insertTags() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public Tags selectTags(int id) {
		Tags tags = null;
		try {
			tags = session.selectOne("nhTagsSelect", id);
			log.info("TagsDaoImpl selectTags() => " + tags.getName());
		} catch(Exception e) {
			log.info("TagsDaoImpl selectTags() => " + e.getMessage());
		}
		return tags;
	}

	@Override
	public int updateTags(Tags tags) {
		int result = 0;
		try {
			result = session.update("nhTagsUpdate", tags);
		} catch(Exception e) {
			log.info("TagsDaoImpl insertTags() => " + e.getMessage());
		}
		return result;
	}

	@Override
	public int deleteTags(int id) {
		int result = 0;
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			// 자식 테이블 데이터부터 삭제할 수 있도록 
			result = session.delete("nhUserTagsDelete", id);
			log.info("TagsDaoImpl deleteTags userTags => " + result);
			result = session.delete("nhContentTagsDelete", id);
			log.info("TagsDaoImpl deleteTags contentTags => " + result);
			result = session.delete("nhBoardTagsDelete", id);
			log.info("TagsDaoImpl deleteTags boardTags => " + result);
			result = session.delete("nhTagsDelete", id);
			log.info("TagsDaoImpl deleteTags tags => " + result);
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			transactionManager.rollback(txStatus);
			log.info("TagsDaoImpl deleteTags() => " + e.getMessage());
			result = -1;
		}
		return result;
	}

	@Override
	public List<Tags> listBoardTags(int smallCode) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhBoardTagsAll", smallCode);
			log.info("TagsDaoImpl listBoardTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listBoardTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> searchContentTags(int contentId) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhContentTagOne", contentId);
			log.info("TagsDaoImpl searchContentTags() => " + listTags.size());
		} catch (Exception e) {
			log.info("TagsDaoImpl searchContentTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> listUserTags(Tags tags) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhUserTagsAll", tags);
			log.info("TagsDaoImpl listUserTags() => " + listTags.size());
		} catch (Exception e) {
			log.info("TagsDaoImpl listUserTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> listContentTags(int bigCode) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhContentTagsAll", bigCode);
			log.info("TagsDaoImpl listContentTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listContentTags() => " + e.getMessage());
		}
		return listTags;
	}

	@Override
	public List<Tags> searchBoardTagsOne(int boardId) {
		List<Tags> listTags = null;
		try {
			listTags = session.selectList("nhBoardTagOne", boardId);
			log.info("TagsDaoImpl listContentTags() => " + listTags.size());
		} catch(Exception e) {
			log.info("TagsDaoImpl listContentTags() => " + e.getMessage());
		}
		return listTags;
	}
	
	@Override
	public int updateBoardTags(int boardId, int[] finalTags) {
		int result = 0;
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			List<Tags> listMyTags = session.selectList("nhBoardTagOne", boardId);
			// DB에 저장된 원래 tag list와 finalTags를 비교하여 finalTags에 존재하지 않는 tag는 delete
			if(listMyTags != null) {
				boolean isHere = false;
				for(Tags tag : listMyTags) {
					for(int i = 0; i < finalTags.length; i++) {
						if(tag.getId() == finalTags[i]) {
							isHere = true;
						}
					}
					if(!isHere) {
						Tags newTag = new Tags();
						newTag.setBoard_id(boardId);
						newTag.setTag_id(tag.getId());
						result = session.delete("nhBoardTagsDelete", newTag);
						log.info(newTag.getTag_id()+"result=>"+result);
					}
				}
			}
			
			// DB에 저장된 원래 tag list와 finalTags를 비교하여 finalTags에만 존재하는 tag는 insert
			if(finalTags != null) {
				boolean isHere = false;
				for(int tagId : finalTags) {
					for(int i = 0; i < listMyTags.size(); i++) {
						if(tagId == listMyTags.get(i).getTag_id()) {
							isHere = true; // finalTags에 기존의 tag가 존재하면  true
						}
					}
					if(!isHere) { // finalTags에만 존재하는 tag
						Tags newTag = new Tags();
						newTag.setBoard_id(boardId);
						newTag.setTag_id(tagId);
						result = session.insert("myinsertBoardTags", newTag);
						log.info(newTag.getTag_id()+"result=>"+result);
					}
				}
			}
			
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			transactionManager.rollback(txStatus);
			log.info("TagsDaoImpl updateBoardTags updateBoardTags => " + e.getMessage());
			result = -1;
		}	
		return result;
	}
	
	/*
	 * if(!isHere) {
						Tags newTag = new Tags();
						newTag.setBoard_id(boardId);
						newTag.setTag_id(tag.getId());
						result = session.insert("myinsertBoardTags", tag);
					}
	 */
	
	/*
	 * 통합게시물 생성 Logic 
	 * by. 엄민용
	 * >> boardTagsInsert, boardTagDetail, boardTagDelete
	 * */	
	@Override
	public void boardTagsInsert(Tags tags) {
		log.info("service getTag_id : {}", tags.getTag_id());
		log.info("service getBoard_id : {}", tags.getBoard_id());
		
		session.insert("myinsertBoardTags", tags);
	}
	
	@Override
	public List<Tags> boardTagDetail(int id) {
		List<Tags> hashTags = session.selectList("myBoardTag", id);
		return hashTags;
	}
	
	@Override
	public int boardTagDelete(int id) {
		int deleteResult = session.delete("mydeleteBoardTags", id);
		
		return deleteResult;
	}

}
