package com.oracle.s202350104.dao;

import java.util.List;

import com.oracle.s202350104.model.Report;

public interface ReportDao {

	List<Report> listReport();

	Report detailBoard(int board_id);

	List<Report> reportDetail(int board_id);

}
