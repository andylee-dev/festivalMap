package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.s202350104.model.Contents;
import com.oracle.s202350104.model.Festivals;
import com.oracle.s202350104.model.FestivalsContent;
import com.oracle.s202350104.model.Tags;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class FestivalsDaoImpl implements FestivalsDao {
	
	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	// 검색 조건에 맞는 festival 정보를 모두 list로 반환
	@Override
	public List<FestivalsContent> listFestivals(FestivalsContent festival) {
		List<FestivalsContent> listFestivals = null;
		
		try {		
			listFestivals = session.selectList("nhFestivalsListAll", festival);
			// 각 festival의 tags 리스트를 저장
			for(FestivalsContent festi : listFestivals) {
				List<Tags> listTags = session.selectList("nhFestivalTagOne", festi.getContent_id());
				if(listTags != null) {
					festi.setMyTags(listTags);
				}
			}
			log.info("FestivalsDaoImpl listFestivals() => " + listFestivals.size());
		
		} catch(Exception e) {
			log.info("FestivalsDaoImpl listFestivals() => " + e.getMessage());
		}
		
		return listFestivals;
	}

	// contentId에 해당하는 festival의 상세 정보를 반환
	@Override
	public FestivalsContent detailFestivals(int contentId) {
		FestivalsContent festival = new FestivalsContent();
		
		try {
			
			festival = session.selectOne("nhFestivalsDetail", contentId);
			log.info("FestivalsDaoImpl detailFestivals() festival.getTitle => " + festival.getTitle());
		
		} catch(Exception e) {
			log.info("FestivalsDaoImpl detailFestivals() => " + e.getMessage());
		}
		
		return festival;
	}

	// 검색 조건에 맞는 festival의 총 데이터 수를 반환
	@Override
	public int totalFestivals(FestivalsContent festival) {
		int totalFestCnt = 0;
		
		try {
			
			totalFestCnt = session.selectOne("nhFestivalsTotal", festival);
		
		} catch(Exception e) {
			log.info("FestivalsDaoImpl totalFestivals Exception => " + e.getMessage());
		}
		
		return totalFestCnt;
	}
	
	// 폼에서 입력받은 festival의 정보를 테이블에 insert
	@Override
	public int insertFestival(FestivalsContent festival) {
		int result = 0;
		// 여러 개의 테이블에 insert해야 하므로 transaction을 걸어줌
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
	
		try {
			// 부모 테이블인 contents 테이블에 먼저 insert
			result = session.insert("nhContentsInsert", festival);
			log.info("insertFestival nhContentsInsert result => " + result);
			
			// 자식 테이블인 festivals 테이블에 insert
			result = session.insert("nhFestivalsInsert", festival);
			log.info("insertFestival nhFestivalsInsert result => " + result);
			
			// xml에서 useGeneratedKeys="true" keyColumn="content_id" keyProperty="content_id" 설정해주면 insert하면서 생성된 key값을 반환해줌
			// 위의 설정으로, 생성된 key값을 직접 festival에 set하지 않아도 바로 사용할 수 있음(set하면 오류 남)
			// 폼에서 입력 받은 tags 정보가 null이 아니라면, String형에서 int형의 원소로 형변환하여 ContentTags에 insert
			if(festival.getFinalTags() != null) {
				String[] stringArr = festival.getFinalTags();
				for(int i = 0; i < stringArr.length; i++) {
					int tagId = Integer.parseInt(stringArr[i]);
					festival.setTag_id(tagId);
					result = session.insert("nhFestivalTagInsert", festival);
					log.info("insertFestival nhFestivalTagInsert result => "+result);
				}
			}
			// 모든 작업 하나하나가 다 성공적으로 완료될 경우에만 commit
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			// 작업이 하나라도 실패하면 rollback
			transactionManager.rollback(txStatus);
			log.info("FestivalsDaoImpl insertFestival Exception => " + e.getMessage());
			result = -1;
		}

		return result;
	}

	// festival 정보를 삭제 => contents 테이블에서 해당 축제의 is_deleted 값을 1로 update
	@Override
	public int deleteFestivals(int contentId) {
		int result = 0;
		
		try {
			
			result = session.update("nhContentsDelete", contentId);
		
		} catch(Exception e) {
			log.info("FestivalsDaoImpl deleteFestivals Exception => " + e.getMessage());
		}
		
		return result;
	}

	// festival 등록 신청 승인 => contents 테이블에서 해당 축제의 status 값을 1로 update
	@Override
	public int approveFestival(int contentId) {
		int result = 0;
		
		try {
			
			result = session.update("nhFestivalsApprove", contentId);
		
		} catch(Exception e) {
			log.info("FestivalsDaoImpl approveFestival Exception => " + e.getMessage());
		}
		
		return result;
	}

	// 폼에서 수정한 festival의 정보로 update
	@Override
	public int updateFestival(FestivalsContent festival) {
		int result = 0;
		// 여러 개의 테이블에 update해야 하므로 transaction을 걸어줌
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		
		try {
			// contents 테이블 먼저 update
			result = session.update("nhContentsUpdate", festival);
			log.info("updateFestival nhContentsUpdate result => " + result);
			// festivals 테이블 update
			result = session.update("nhFestivalsUpdate", festival);
			log.info("updateFestival nhFestivalsUpdate result => " + result);
			
			// 해당 festival에 기존에 저장되어 있던 tags들의 정보를 가져옴
			int festivalKey = festival.getContent_id();
			List<Tags> oldTags = session.selectList("nhFestivalTagOne", festivalKey);
			
			// 폼에서 입력받은 수정된 tags 정보를 가져와 int형으로 변환
			String[] stringArr = festival.getFinalTags();
			int[] finalTags = new int[stringArr.length];
			for(int i = 0; i < stringArr.length; i++) {
				finalTags[i] = Integer.parseInt(stringArr[i]);
			}
			
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
						Tags newTag = new Tags();
						newTag.setContent_id(festivalKey);
						newTag.setTag_id(tag.getId());
						result = session.delete("nhFestivalTagDelete", newTag);
						log.info(newTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				}
				
				// finalTags에만 존재하는 tag를 insert
				for(int tagId : finalTags) {
					for(int i = 0; i < oldTags.size(); i++) {
						if(tagId == oldTags.get(i).getTag_id()) {
							isHere = true;
						}
					}
					// oldTags에는 존재하지 않지만 finalTags에는 존재하는 tag를 insert
					if(!isHere) {
						Tags newTag = new Tags();
						newTag.setContent_id(festivalKey);
						newTag.setTag_id(tagId);
						result = session.delete("nhFestivalTagInsert", newTag);
						log.info(newTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				} 
			
			  // 기존에 태그 정보는 존재하지만 폼으로 넘어온 태그 정보는 null일 때, 즉 태그를 전부 삭제했을 때
			} else if(oldTags != null && finalTags == null) {
				for(Tags tag : oldTags) {
					Tags newTag = new Tags();
					newTag.setContent_id(festivalKey);
					newTag.setTag_id(tag.getId());
					result = session.delete("nhFestivalTagDelete", newTag);
					log.info(newTag.getTag_id()+"result=>"+result);
				}
				
			  // 기존에 태그 정보는 null이지만 폼으로 넘어온 태그 정보는 존재할 때, 즉 해당 게시글에 태그를 새롭게 입력했을 때	
			} else if(oldTags == null && finalTags != null) {
				for(int i = 0; i < finalTags.length; i++) {
					Tags newTag = new Tags();
					newTag.setContent_id(festivalKey);
					newTag.setTag_id(finalTags[i]);
					result = session.delete("nhFestivalTagInsert", newTag);
					log.info(newTag.getTag_id()+"result=>"+result);
				}
				
			  // DB에 저장되어있던 태그 정보도 없고, 새로 폼으로 들어온 태그 정보도 없을 때		
			} else result = 0;
			// 모든 작업 하나하나가 정상적으로 실행되면 commit
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			// 하나의 작업이라도 실패하면 rollback
			transactionManager.rollback(txStatus);
			log.info("FestivalsDaoImpl updateFestival Exception => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}

	// 축제 상세 페이지를 클릭하면 조회수가 1씩 up
	@Override
	public int readcountUp(int contentId) {
		int result = 0;
		
		try {
			
			result = session.update("nhReadcountUp", contentId);
			log.info("nhReadcountUp result => " + result);
		
		} catch (Exception e) {
			log.info("FestivalDaoImpl readcountUp Exception => " + e.getMessage());
		}
		
		return result;
	}

	// contentId에 해당하는 festival의 contents 테이블에 저장된 정보를 가져옴
	@Override
	public Contents detailContents(int contentId) {
		Contents contents = new Contents();
		
		try {
			
			contents = session.selectOne("nhContentsDetail", contentId);
			log.info("FestivalsDaoImpl detailContents() contents.getTitle => " + contents.getTitle());
		
		} catch(Exception e) {
			log.info("FestivalsDaoImpl detailContents() => " + e.getMessage());
		}
		
		return contents;
	}

	// contentId에 해당하는 festival의 tags 리스트를 가져옴
	@Override
	public List<Tags> festivalsTagsOne(int contentId) {
		List<Tags> listTags = null;
		
		try {
			listTags = session.selectList("nhFestivalTagOne", contentId);
			log.info("FestivalsDaoImpl festivalsTagsOne => " + listTags.size());
		} catch(Exception e) {
			log.info("FestivalsDaoImpl festivalsTagsOne => " + e.getMessage());
		}
		
		return listTags;
	}

	// calendard용으로 startdate와 enddate를 string형으로 반환하는 메소드
	@Override
	public List<FestivalsContent> listFestivalsCal() {
		List<FestivalsContent> listFestivals = null;
		
		try {
			listFestivals = session.selectList("nhFestivalDateSelect");
			log.info("FestivalsDaoImpl listFestivalsCal => " + listFestivals.size());
		} catch(Exception e) {
			log.info("FestivalsDaoImpl listFestivalsCal => " + e.getMessage());
		}
		
		return listFestivals;
	}
	
}
