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

	// 검색 조건에 해당하는 tags의 총 개수를 반환
	@Override
	public int totalTags(Tags tags) {
		int totalTagsCnt = 0;
		
		try {
			
			totalTagsCnt = session.selectOne("nhTagsTotal", tags);
			log.info("TagsDaoImpl totalTags() => " + totalTagsCnt);
			
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

	// 검색 조건에 해당하는 user tags의 총 개수를 반환
	@Override
	public int totalUserTags(Tags tags) {
		int totalTagsCnt = 0;
		
		try {
			
			totalTagsCnt = session.selectOne("nhUserTagsTotal", tags);
			log.info("TagsDaoImpl totalUserTags() => " + totalTagsCnt);
			
		} catch(Exception e) {
			log.info("TagsDaoImpl totalUserTags() => " + e.getMessage());
		}
		
		return totalTagsCnt;
	} 

	// 검색 조건에 해당하는 board tags의 총 개수를 반환
	@Override
	public int totalBoardTags() {
		int totalTagsCnt = 0;
		
		try {
			
			totalTagsCnt = session.selectOne("nhBoardTagsTotal");
			log.info("TagsDaoImpl totalBoardTags() => " + totalTagsCnt);
			
		} catch(Exception e) {
			log.info("TagsDaoImpl totalBoardTags() => " + e.getMessage());
		}
		
		return totalTagsCnt;
	}

	// 검색 조건에 해당하는 content tags의 총 개수를 반환
	@Override
	public int totalContentTags() {
		int totalTagsCnt = 0;
		
		try {
			
			totalTagsCnt = session.selectOne("nhContentTagsTotal");
			log.info("TagsDaoImpl totalContentTags() => " + totalTagsCnt);
			
		} catch(Exception e) {
			log.info("TagsDaoImpl totalContentTags() => " + e.getMessage());
		}
		return totalTagsCnt;
	}

	// tags 테이블에 태그 정보를 insert
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

	// tag의 id에 해당하는 태그의 정보를 가져옴
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

	// tags의 태그 정보를 update
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

	// tags 테이블에서 태그의 정보를 delete
	@Override
	public int deleteTags(int id) {
		int result = 0;
		// 하나의 dao로 여러 개의 테이블에서 데이터를 삭제해야하므로 transaction 처리를 해줌
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			// 자식 테이블 데이터부터 삭제할 수 있도록 
			// userTags 테이블에서 해당 태그 정보 삭제
			result = session.delete("nhUserTagsDelete", id);
			log.info("TagsDaoImpl deleteTags userTags => " + result);
			// contentTags 테이블에서 해당 태그 정보 삭제
			result = session.delete("nhContentTagsDelete", id);
			log.info("TagsDaoImpl deleteTags contentTags => " + result);
			// boardTags 테이블에서 해당 태그 정보 삭제
			result = session.delete("nhBoardTagsDelete", id);
			log.info("TagsDaoImpl deleteTags boardTags => " + result);
			// Tags 테이블에서 해당 태그 정보 삭제
			result = session.delete("nhTagsDelete", id);
			log.info("TagsDaoImpl deleteTags tags => " + result);
			// 모두 delete 성공하면 commit
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			// 하나라도 delete 실패하면 rollback
			transactionManager.rollback(txStatus);
			log.info("TagsDaoImpl deleteTags() => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}

	// boardTags 테이블의 데이터를 전부 가져옴
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

	// 파라미터로 들어온 contentId의 tags 정보들을 모두 가져와서 list에 저장, 반환
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

	// userTags테이블의 정보를 모두 가져와서 list에 저장, 반환
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

	// 파라미터로 들어온 대분류에 해당하는 content의 tags 정보들을 모두 가져옴
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
	
	// course의 tags 정보들을 모두 가져옴
	@Override
	public List<Tags> listCourseTags() {
		List<Tags> listTags = null;
		
		try {
			
			listTags = session.selectList("nhCourseTagsAll");
			log.info("TagsDaoImpl listCourseTags() => " + listTags.size());
			
		} catch(Exception e) {
			log.info("TagsDaoImpl listCourseTags() => " + e.getMessage());
		}
		
		return listTags;
	}

	// 파라미터로 들어온 boardId의 tags 정보들을 모두 가져와 list에 저장, 반환
	@Override
	public List<Tags> searchBoardTagsOne(int boardId) {
		List<Tags> listTags = null;
		
		try {
			
			listTags = session.selectList("nhBoardTagOne", boardId);
			log.info("TagsDaoImpl listBoardTags() => " + listTags.size());
			
		} catch(Exception e) {
			log.info("TagsDaoImpl listBoardTags() => " + e.getMessage());
		}
		
		return listTags;
	}
	
	// 폼을 통해 넘어온 tag 정보를 새롭게 boardTags 테이블에 insert, delete
	@Override
	public int updateBoardTags(int boardId, int[] finalTags) {
		int result = 0;
		// insert/delete를 여러 번 시행해야 할 수 있으므로 transaction 처리를 해줌 
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			// 해당 게시글이 이미 가지고 있던(기존에 DB에 저장되어 있던) tag 정보들을 가져와 list에 저장
			List<Tags> oldTags = session.selectList("nhBoardTagOne", boardId);
			
			// 기존에 태그 정보 존재, 폼으로 넘어온 태그 정보 존재할 때
			if(oldTags != null && finalTags != null) {
				// 폼으로 넘어온 태그가 기존 DB에 이미 존재하는 정보인지 아닌지 확인하는 작업
				boolean isHere = false;
			
				for(Tags tag : oldTags) {
					for(int i = 0; i < finalTags.length; i++) {
						if(tag.getId() == finalTags[i]) {
							isHere = true; // 폼으로 넘어온 태그 정보가 DB에 이미 있던 태그일 때 true로 값 바꿈
						}
					}
					// oldTags에는 존재하지만 finalTags에는 존재하지 않는 tag를 delete
					if(!isHere) {
						Tags delTag = new Tags();
						delTag.setBoard_id(boardId);
						delTag.setTag_id(tag.getId());
						result = session.delete("nhBoardTagsDelete", delTag);
						log.info(delTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				}
				
				// finalTags에만 존재하는 tag를 insert
				for(int tagId : finalTags) {
					for(int i = 0; i < oldTags.size(); i++) {
						if(tagId == oldTags.get(i).getTag_id()) {
							isHere = true; // 폼으로 넘어온 태그가 DB에 없던 새로운 태그일 때 true로 값 변경
						}
					}
					// oldTags에는 존재하지 않지만 finalTags에는 존재하는 tag를 insert
					if(!isHere) {
						Tags newTag = new Tags();
						newTag.setBoard_id(boardId);
						newTag.setTag_id(tagId);
						result = session.delete("myinsertBoardTags", newTag);
						log.info(newTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				} 
				
			  // 기존에 태그 정보는 존재하지만 폼으로 넘어온 태그 정보는 null일 때, 즉 태그를 전부 삭제했을 때
			} else if(oldTags != null && finalTags == null) {
				for(Tags tag : oldTags) {
					Tags delTag = new Tags();
					delTag.setBoard_id(boardId);
					delTag.setTag_id(tag.getId());
					result = session.delete("nhBoardTagsDelete", delTag);
					log.info(delTag.getTag_id()+"result=>"+result);
				}
			  
			  // 기존에 태그 정보는 null이지만 폼으로 넘어온 태그 정보는 존재할 때, 즉 해당 게시글에 태그를 새롭게 입력했을 때
			} else if(oldTags == null && finalTags != null) {
				for(int i = 0; i < finalTags.length; i++) {
					Tags newTag = new Tags();
					newTag.setBoard_id(boardId);
					newTag.setTag_id(finalTags[i]);
					result = session.delete("myinsertBoardTags", newTag);
					log.info(newTag.getTag_id()+"result=>"+result);
				}
				
			  // DB에 저장되어있던 태그 정보도 없고, 새로 폼으로 들어온 태그 정보도 없을 때	
			} else result = 0;
			// 모든 작업 하나하나가 정상적으로 실행되면 commit
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			// 하나의 작업이라도 실패하면 rollback
			transactionManager.rollback(txStatus);
			log.info("TagsDaoImpl updateBoardTags => " + e.getMessage());
			result = -1;
		}	
		
		return result;
	}
	
	// 폼을 통해 넘어온 tag 정보를 새롭게 contentTags 테이블에 insert, delete
	@Override
	public int updateContentTags(int contentId, int[] finalTags) {
		int result = 0;
		// insert/delete를 여러 번 시행해야 할 수 있으므로 transaction 처리를 해줌 
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			// 해당 컨텐츠가 이미 가지고 있던(기존에 DB에 저장되어 있던) tag 정보들을 가져와 list에 저장
			List<Tags> oldTags = session.selectList("nhContentTagOne", contentId);
			
			// 기존에 태그 정보 존재, 폼으로 넘어온 태그 정보 존재할 때
			if(oldTags != null && finalTags != null) {
				// 폼으로 넘어온 태그가 기존 DB에 이미 존재하는 정보인지 아닌지 확인하는 작업
				boolean isHere = false;
				
				for(Tags tag : oldTags) {
					for(int i = 0; i < finalTags.length; i++) {
						if(tag.getId() == finalTags[i]) {
							isHere = true;	// 폼으로 넘어온 태그 정보가 DB에 이미 있던 태그일 때 true로 값 바꿈
						}
					}
					// oldTags에는 존재하지만 finalTags에는 존재하지 않는 tag를 delete
					if(!isHere) {
						Tags delTag = new Tags();
						delTag.setContent_id(contentId);
						delTag.setTag_id(tag.getId());
						result = session.delete("nhContentTagsDelete", delTag);
						log.info(delTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				}
				
				// finalTags에만 존재하는 tag를 insert
				for(int tagId : finalTags) {
					for(int i = 0; i < oldTags.size(); i++) {
						if(tagId == oldTags.get(i).getTag_id()) {
							isHere = true;	// 폼으로 넘어온 태그가 DB에 없던 새로운 태그일 때 true로 값 변경
						}
					}
					// oldTags에는 존재하지 않지만 finalTags에는 존재하는 tag를 insert
					if(!isHere) {
						Tags newTag = new Tags();
						newTag.setContent_id(contentId);
						newTag.setTag_id(tagId);
						result = session.delete("nhContentTagsInsert", newTag);
						log.info(newTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				} 
				
			  // 기존에 태그 정보는 존재하지만 폼으로 넘어온 태그 정보는 null일 때, 즉 태그를 전부 삭제했을 때
			} else if(oldTags != null && finalTags == null) {
				for(Tags tag : oldTags) {
					Tags delTag = new Tags();
					delTag.setContent_id(contentId);
					delTag.setTag_id(tag.getId());
					result = session.delete("nhContentTagsDelete", delTag);
					log.info(delTag.getTag_id()+"result=>"+result);
				}
				
			  // 기존에 태그 정보는 null이지만 폼으로 넘어온 태그 정보는 존재할 때, 즉 해당 컨텐츠에 태그를 새롭게 입력했을 때	
			} else if(oldTags == null && finalTags != null) {
				for(int i = 0; i < finalTags.length; i++) {
					Tags newTag = new Tags();
					newTag.setContent_id(contentId);
					newTag.setTag_id(finalTags[i]);
					result = session.delete("nhContentTagsInsert", newTag);
					log.info(newTag.getTag_id()+"result=>"+result);
				}
			  // DB에 저장되어있던 태그 정보도 없고, 새로 폼으로 들어온 태그 정보도 없을 때	
			} else result = 0;
			// 모든 작업 하나하나가 정상적으로 실행되면 commit
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			// 하나의 작업이라도 실패하면 rollback
			transactionManager.rollback(txStatus);
			log.info("TagsDaoImpl updateContentTags => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}
	
	// 파라미터인 courseId에 해당하는 Tags들을 모두 list에 저장, 반환
	@Override
	public List<Tags> searchCourseTags(int courseId) {
		List<Tags> listTags = null;
		
		try {
			
			listTags = session.selectList("nhCourseTagOne", courseId);
			log.info("TagsDaoImpl listCourseTags() => " + listTags.size());
			
		} catch(Exception e) {
			log.info("TagsDaoImpl listCourseTags() => " + e.getMessage());
		}
		
		return listTags;
	}
	
	// 폼을 통해 넘어온 tag 정보를 새롭게 courseTags 테이블에 insert, delete
	@Override
	public int updateCourseTags(int courseId, int[] finalTags) {
		int result = 0;
		// insert/delete를 여러 번 시행해야 할 수 있으므로 transaction 처리를 해줌 
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			// 해당 코스가 이미 가지고 있던(기존에 DB에 저장되어 있던) tag 정보들을 가져와 list에 저장
			List<Tags> oldTags = session.selectList("nhCourseTagOne", courseId);
			
			// 기존에 태그 정보 존재, 폼으로 넘어온 태그 정보 존재할 때
			if(oldTags != null && finalTags != null) {
				// 폼으로 넘어온 태그가 기존 DB에 이미 존재하는 정보인지 아닌지 확인하는 작업
				boolean isHere = false;
				
				for(Tags tag : oldTags) {
					for(int i = 0; i < finalTags.length; i++) {
						if(tag.getId() == finalTags[i]) {
							isHere = true;	// 폼으로 넘어온 태그 정보가 DB에 이미 있던 태그일 때 true로 값 바꿈
						}
					}
					// oldTags에는 존재하지만 finalTags에는 존재하지 않는 tag를 delete
					if(!isHere) {
						Tags delTag = new Tags();
						delTag.setCourse_id(courseId);
						delTag.setTag_id(tag.getId());
						result = session.delete("nhCourseTagsDelete", delTag);
						log.info(delTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				}
				
				// finalTags에만 존재하는 tag를 insert
				for(int tagId : finalTags) {
					for(int i = 0; i < oldTags.size(); i++) {
						if(tagId == oldTags.get(i).getTag_id()) {
							isHere = true;	// 폼으로 넘어온 태그가 DB에 없던 새로운 태그일 때 true로 값 변경
						}
					}
					// oldTags에는 존재하지 않지만 finalTags에는 존재하는 tag를 insert
					if(!isHere) {
						Tags newTag = new Tags();
						newTag.setCourse_id(courseId);
						newTag.setTag_id(tagId);
						result = session.delete("nhCourseTagsInsert", newTag);
						log.info(newTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				} 
				
			  // 기존에 태그 정보는 존재하지만 폼으로 넘어온 태그 정보는 null일 때, 즉 태그를 전부 삭제했을 때
			} else if(oldTags != null && finalTags == null) {
				for(Tags tag : oldTags) {
					Tags delTag = new Tags();
					delTag.setCourse_id(courseId);
					delTag.setTag_id(tag.getId());
					result = session.delete("nhCourseTagsDelete", delTag);
					log.info(delTag.getTag_id()+"result=>"+result);
				}
				
			  // 기존에 태그 정보는 null이지만 폼으로 넘어온 태그 정보는 존재할 때, 즉 해당 코스에 태그를 새롭게 입력했을 때	
			} else if(oldTags == null && finalTags != null) {
				for(int i = 0; i < finalTags.length; i++) {
					Tags newTag = new Tags();
					newTag.setCourse_id(courseId);
					newTag.setTag_id(finalTags[i]);
					result = session.delete("nhCourseTagsInsert", newTag);
					log.info(newTag.getTag_id()+"result=>"+result);
				}
			  // DB에 저장되어있던 태그 정보도 없고, 새로 폼으로 들어온 태그 정보도 없을 때	
			} else result = 0;
			// 모든 작업 하나하나가 정상적으로 실행되면 commit
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			// 하나의 작업이라도 실패하면 rollback
			transactionManager.rollback(txStatus);
			log.info("TagsDaoImpl updateCourseTags => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}
	
	
	
	
	
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
