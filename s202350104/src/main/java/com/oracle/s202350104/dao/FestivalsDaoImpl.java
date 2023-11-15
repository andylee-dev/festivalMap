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

	@Override
	public List<FestivalsContent> listFestivals(FestivalsContent festival) {
		List<FestivalsContent> listFestivals = null;
		try {
			listFestivals = session.selectList("nhFestivalsListAll", festival);
			log.info("FestivalsDaoImpl listFestivals() => " + listFestivals.size());
		} catch(Exception e) {
			log.info("FestivalsDaoImpl listFestivals() => " + e.getMessage());
		}
		return listFestivals;
	}

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
	
	@Override
	public int insertFestival(FestivalsContent festival) {
		int result = 0;
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			result = session.insert("nhContentsInsert", festival);
			log.info("insertFestival nhContentsInsert result => " + result);
			result = session.insert("nhFestivalsInsert", festival);
			// xml에서 useGeneratedKeys="true" keyColumn="content_id" keyProperty="content_id" 설정해주면 insert 하면서 생성된 key값을 반환해줌
			log.info("insertFestival nhFestivalsInsert result => " + result);
			
			// result한 결과값(key값)을 직접 festival에 set하지 않아도 바로 사용할 수 있음(set하면 오류 남)
			if(festival.getFinalTags() != null) {
				String[] stringArr = festival.getFinalTags();
				for(int i = 0; i < stringArr.length; i++) {
					int tagId = Integer.parseInt(stringArr[i]);
					festival.setTag_id(tagId);
					result = session.insert("nhFestivalTagInsert", festival);
					log.info("insertFestival nhFestivalTagInsert result => "+result);
				}
			}
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			transactionManager.rollback(txStatus);
			log.info("FestivalsDaoImpl insertFestival Exception => " + e.getMessage());
			result = -1;
		}
		// 원래 insert 결과값이지만 ContentTags 입력하기 위해서 festival 시퀀스 값을 돌려줌
		return result;
	}

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

	@Override
	public int updateFestival(FestivalsContent festival) {
		int result = 0;
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			result = session.update("nhContentsUpdate", festival);
			log.info("updateFestival nhContentsUpdate result => " + result);
			result = session.update("nhFestivalsUpdate", festival);
			log.info("updateFestival nhFestivalsUpdate result => " + result);
			
			int festivalKey = festival.getContent_id();
			List<Tags> oldTags = session.selectList("nhFestivalTagOne", festivalKey);
			String[] stringArr = festival.getFinalTags();
			int[] finalTags = new int[stringArr.length];
			for(int i = 0; i < stringArr.length; i++) {
				finalTags[i] = Integer.parseInt(stringArr[i]);
			}
			
			if(oldTags != null && finalTags != null) {
				boolean isHere = false;
				// oldTags에는 존재하지만 finalTags에는 존재하지 않는 tag를 delete
				for(Tags tag : oldTags) {
					for(int i = 0; i < finalTags.length; i++) {
						if(tag.getId() == finalTags[i]) {
							isHere = true;
						}
					}
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
					if(!isHere) {
						Tags newTag = new Tags();
						newTag.setContent_id(festivalKey);
						newTag.setTag_id(tagId);
						result = session.delete("nhFestivalTagInsert", newTag);
						log.info(newTag.getTag_id()+"result=>"+result);
					}
					isHere = false;
				} 
				
			} else if(oldTags != null && finalTags == null) {
				for(Tags tag : oldTags) {
					Tags newTag = new Tags();
					newTag.setContent_id(festivalKey);
					newTag.setTag_id(tag.getId());
					result = session.delete("nhFestivalTagDelete", newTag);
					log.info(newTag.getTag_id()+"result=>"+result);
				}
			} else if(oldTags == null && finalTags != null) {
				for(int i = 0; i < finalTags.length; i++) {
					Tags newTag = new Tags();
					newTag.setContent_id(festivalKey);
					newTag.setTag_id(finalTags[i]);
					result = session.delete("nhFestivalTagInsert", newTag);
					log.info(newTag.getTag_id()+"result=>"+result);
				}
			} else result = 0;
			
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			transactionManager.rollback(txStatus);
			log.info("FestivalsDaoImpl updateFestival Exception => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}

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
	
}
