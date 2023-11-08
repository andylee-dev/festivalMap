package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionManager;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.oracle.s202350104.model.AccomodationContent;
import com.oracle.s202350104.model.FestivalsContent;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class AccomodationDaoImpl implements AccomodationDao {

	private final SqlSession session;
	private final PlatformTransactionManager transactionManager;

	@Override
	public List<AccomodationContent> listAccomodation(AccomodationContent accomodation) {
		
		List<AccomodationContent> listAccomodation = null;
		log.info("AccomodationImpl listAccomodations Start...");
		
		try {
			listAccomodation = session.selectList("accomodationAll", accomodation);
			log.info("AccomodationDaoImpl listRestaurant AccomodationsList.size()->" + listAccomodation.size());
		} catch (Exception e) {
			log.info("AccomodationDaoImpl listAccomodation e.getMessage()->" + e.getMessage());
		}
		
		return listAccomodation;
	}

	@Override
	public AccomodationContent detailAccomodation(int contentId) {
	AccomodationContent accomodation = new AccomodationContent();
		
		try {
			accomodation = session.selectOne("AccomodationDetail", contentId);
			log.info("accomodationContent detailaccomodation() accomodation.getTitle ->" + accomodation.getTitle());
					
		} catch (Exception e) {
			log.info("accomodationsContent detailaccomodation() ->" + e.getMessage());
		}
		return accomodation;
	}

	@Override
	public int totalAccomodation() {
		int totAccomodationCount = 0;
		
		try {
			totAccomodationCount = session.selectOne("AccomodationTotal");
		} catch (Exception e) {
			log.info("AccomodationDaoImpl totalAccomodations Exception => " + e.getMessage());
		}
		return totAccomodationCount;
	}

	@Override
	public int accomodationDelete(int contentId) {
		int accomodationDelete = 0;
		try {
			accomodationDelete = session.delete("accomodationDelete",contentId);
		} catch (Exception e) {
		}
		
		return accomodationDelete;
	}
	
	@Override
	public int insertContent(AccomodationContent accomodation) {
		int result = 0;
		try {
			result = session.insert("ContentsInsert", accomodation);
		} catch(Exception e) {
			log.info("AccomodationDaoImpl insertContent Exception => " + e.getMessage());
		}
		
		return result;
	}
	
	@Override
	public int insertAccomodation(AccomodationContent accomodation) {
		int result = 0;
		try {
			result = session.insert("AccomodationInsert", accomodation);
		} catch(Exception e) {
			log.info("AccomodationDaoImpl insertAccomodation Exception => " + e.getMessage());
		}
		
		return result;
	}

	@Override
	public int updateAccomodation(AccomodationContent accomodation) {
		int result = 0;
		TransactionStatus txStatus = 
				transactionManager.getTransaction(new DefaultTransactionDefinition());
		try {
			result = session.update("ContentsUpdate", accomodation);
			log.info("updateAccomodation nhContentsUpdate result => " + result);
			result = session.update("AccomodationUpdate", accomodation);
			log.info("updateAccomodation AccomodationUpdate result => " + result);
			transactionManager.commit(txStatus);
		} catch(Exception e) {
			transactionManager.rollback(txStatus);
			log.info("FestivalsDaoImpl updateFestival Exception => " + e.getMessage());
			result = -1;
		}
		
		return result;
	}

	@Override
	public int approveAccomodation(int contentId) {
		int result = 0;
		try {
			result = session.update("AccomodationApprove", contentId);
		} catch(Exception e) {
			log.info("AccomodationDaoImpl approveFestival Exception => " + e.getMessage());
		}
		
		return result;
	}
}