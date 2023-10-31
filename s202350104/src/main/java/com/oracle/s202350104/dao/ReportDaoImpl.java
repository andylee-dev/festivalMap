package com.oracle.s202350104.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.oracle.s202350104.model.Report;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ReportDaoImpl implements ReportDao {

	private final SqlSession session;
	
	@Override
	public List<Report> listReport() {
		List<Report> listReport = null;
		try {
			listReport = session.selectList("shReportListAll");
		} catch (Exception e) {
			// TODO: handle exception
		}
		return listReport;
	}

	@Override
	public Report detailBoard(int board_id) {
		Report detailBoard = new Report();
		try {
			detailBoard = session.selectOne("shBoardDetail",board_id);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return detailBoard;
	}

	@Override
	public List<Report> reportDetail(int board_id) {
		List<Report> reportDetail = null;
		try {
			reportDetail = session.selectList("shReportDetail", board_id);
		} catch (Exception e) {
			
		}
		
		
		return reportDetail;
	}

}
