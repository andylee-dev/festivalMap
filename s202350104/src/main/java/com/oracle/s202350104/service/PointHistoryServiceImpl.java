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
		public int deletePointHistory(int point_id) {
			int result = phd.deletePointHistory(point_id);
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
	    public List<PointHistory> searchPointHistory(String search, String keyword) {
			
		    List<PointHistory> listPointHistory = phd.listPointHistory(); // phd를 통해 데이터 조회

		    // 검색 로직 추가
		    List<PointHistory> searchResult = listPointHistory.stream()
		            .filter(ph -> {
		                switch (search) {
		                    case "s_id":
		                        return String.valueOf(ph.getUser_id()).contains(keyword);
		                    case "s_name":
		                        return ph.getUser_name().contains(keyword);
		                    case "s_point":
		                        return String.valueOf(ph.getPoint_id()).contains(keyword);
		                    default:
		                        return false;
		                }
		            })
		            .collect(Collectors.toList());

		    return searchResult;
	}
}