package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Report;

public interface ReportDao {

	List<Report> listReport();

	Report detailBoard(int boardId);

	List<Report> reportDetail(int boardId);

	int updateBoard(int id);

	int reportUpdate(int id);

	int boardReportUpdate(Report report);

}
