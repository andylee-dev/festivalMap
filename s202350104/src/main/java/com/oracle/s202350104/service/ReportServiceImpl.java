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

}
