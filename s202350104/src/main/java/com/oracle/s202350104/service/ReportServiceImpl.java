package com.oracle.s202350104.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.oracle.s202350104.dao.ReportDao;
import com.oracle.s202350104.model.Report;

import lombok.RequiredArgsConstructor;
@Service
@RequiredArgsConstructor
public class ReportServiceImpl implements ReportService {
	
	private final ReportDao rd;

	@Override
	public List<Report> listReport() {
		List<Report> listReport = rd.listReport();
		return listReport;
	}

	@Override
	public Report boardDetail(int boardId) {
		Report boardDetail = rd.detailBoard(boardId);
		return boardDetail;
	}

	@Override
	public List<Report> reportDetail(int boardId) {
		List<Report> reportDetail = rd.reportDetail(boardId);
		return reportDetail;
	}

	@Override
	public int reportBoardUpdate(int id) {
		int updateBoard = 0;
		updateBoard = rd.updateBoard(id);
		return updateBoard;
	}

	@Override
	public int reportUpdate(int id) {
		int reportUpdate = 0;
		reportUpdate = rd.reportUpdate(id);
		return reportUpdate;
	}

	@Override
	public int boardReportUpdate(Report report) {
		int boardReportUpdate = 0;
		boardReportUpdate = rd.boardReportUpdate(report);
		return boardReportUpdate;
	}

}
