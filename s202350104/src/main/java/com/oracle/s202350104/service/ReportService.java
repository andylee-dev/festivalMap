package com.oracle.s202350104.service;

import java.util.List;

import com.oracle.s202350104.model.Report;

public interface ReportService {

	List<Report> 	listReport();
	Report 			boardDetail(int boardId);
	List<Report>	reportDetail(int boardId);
	int 			reportBoardUpdate(int id);
	int 			reportUpdate(int id);
	int 			boardReportUpdate(Report report);

}
