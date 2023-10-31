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

}
