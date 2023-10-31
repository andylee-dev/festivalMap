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
	public Report boardDetail(int board_id) {
		Report boardDetail = rd.detailBoard(board_id);
		return boardDetail;
	}

	@Override
	public List<Report> reportDetail(int board_id) {
		List<Report> reportDetail = rd.reportDetail(board_id);
		return reportDetail;
	}

}
