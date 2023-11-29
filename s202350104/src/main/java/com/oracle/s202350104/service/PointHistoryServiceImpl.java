package com.oracle.s202350104.service;
	
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.web.server.ResponseStatusException;

import com.oracle.s202350104.dao.PointDao;
import com.oracle.s202350104.dao.PointHistoryDao;
import com.oracle.s202350104.dao.UserDao;
import com.oracle.s202350104.model.PointHistory;
	
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
	
@Service
@RequiredArgsConstructor
@Slf4j
	public class PointHistoryServiceImpl implements PointHistoryService {
		
		private final PointHistoryDao phd;
	
		@Override
		public List<PointHistory> listPointHistory() {
	
			List<PointHistory> listPointHistory = phd.listPointHistory();
			
			if(listPointHistory==null) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "포인트 내역 리스트가 존재하지 않습니다");
			}
			
			return listPointHistory;
		}
	
		@Override
		public int deletePointHistory(Integer id) {
			int result = phd.deletePointHistory(id);
	        if(result == 0) {
	            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "삭제할 포인트 내역이 없습니다");
	        }
			return result;
		}
	
		@Override
		public void writePointHistory(PointHistory pointhistory) {
			
		
			phd.writePointHistory(pointhistory);
			
		}

		@Override
		public List<PointHistory> getPointHistoryByUserId(int user_id) {
			
			List<PointHistory> listPointHistory = phd.listPointHistory();
			
			return listPointHistory;
		}

		@Override
		public List<PointHistory> listPointHistorySortedByDateDesc(List<PointHistory> listPointHistory) {
			 Collections.sort(listPointHistory, new Comparator<PointHistory>() {
		            @Override
		            public int compare(PointHistory ph1, PointHistory ph2) {
		                return ph2.getCreated_at().compareTo(ph1.getCreated_at());
		            }
		        });

		        return listPointHistory;
		    }

		@Override
	    public List<PointHistory> searchPointHistorylist(PointHistory pointhistory) {
			
		    List<PointHistory> searchPointHistory = phd.searchPointHistorylist(pointhistory); // phd를 통해 데이터 조회

		    return searchPointHistory;
	}

		@Override
		public int totalpointHistory() {
			int totalpointHistory = phd.totalpointHistory();
			return totalpointHistory;
		}

		@Override
		public int conTotalPointHistory(PointHistory pointhistory) {
			int conTotalPointHistory = phd.conTotalPointHistory(pointhistory);
			return conTotalPointHistory;
		}

		/*
		 * @Override public List<PointHistory> indexlistSearchPointHistory(PointHistory
		 * pointhistory) { List<PointHistory> indexlistSearchPointHistory =
		 * phd.indexlistSearchPointHistory(pointhistory); return
		 * indexlistSearchPointHistory; }
		 */

		@Override
		public List<PointHistory> listPointHistory1(PointHistory pointhistory) {
			   
			   List<PointHistory> listPointHistory = phd.listPointHistory1(pointhistory);
			
			if(listPointHistory==null) {
				throw new ResponseStatusException(HttpStatus.NOT_FOUND, "포인트 내역 리스트가 존재하지 않습니다");
			}
			
			return listPointHistory;
		}
}