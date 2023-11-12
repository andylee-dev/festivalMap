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
			log.info("insertFestival nhFestivalsInsert result => " + result);
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			transactionManager.rollback(txStatus);
			log.info("FestivalsDaoImpl insertFestival Exception => " + e.getMessage());
			result = -1;
		}
		
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
