package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Report;

public interface ReportService {

	List<Report> listReport();

	Report boardDetail(int board_id);

	List<Report> reportDetail(int board_id);

	int reportBoardUpdate(int id);

	int reportUpdate(int id);

}
