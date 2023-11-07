package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.s202350104.controller.SpotController;
import com.oracle.s202350104.model.Spot;
import com.oracle.s202350104.model.SpotContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class SpotDaoImpl implements SpotDao {

	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	@Override
	public int totalSpot() {
		int totSpotCount = 0;
		
		try {
			totSpotCount = session.selectOne("spotTotal");
		} catch (Exception e) {
			log.info("SpotDaoImpl totalSpot Exception => " + e.getMessage());
		}
		return totSpotCount;
	}
	
	@Override
	public List<SpotContent> listSpot(SpotContent spotContent) {
		List<SpotContent> spotList = null;
			
			try {
				spotList = session.selectList("dhSpotListAll", spotContent);
				log.info("SpotDaoImpl listSpot spotList.size()->"+spotList.size());
			} catch (Exception e) {
				log.info("SpotDaoImpl listSpot e.getMessage()->"+e.getMessage());
			}
		return spotList;
	}

	@Override
	public SpotContent detailSpot(int contentId) {
		SpotContent spot = new SpotContent();
		try {
			spot = session.selectOne("dhSpotDetail", contentId);
			log.info("SpotDaoImpl detailSpot() spot.getTitle => " + spot.getTitle());
		}catch (Exception e) {
			log.info("SpotDaoImpl detailSpot() => " + e.getMessage());
		}
		
		return spot;
	}

	@Override
	public int insertSpot(SpotContent spotContent) {
		int result = 0;
		TransactionStatus txStatus =
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			result = session.insert("dhContentInsert", spotContent);
			log.info("insertFestival dhContentsInsert result => " + result);
			result = session.insert("dhSpotInsert", spotContent);
			log.info("insertFestival dhSpotInsert result => " + result);
			transactionManager.commit(txStatus);
		} catch (Exception e) {
			transactionManager.rollback(txStatus);
			log.info("QnaListDaoImpl insertspot Exception => " + e.getMessage());
			result = -1;
		}
		return result;
	}
}

