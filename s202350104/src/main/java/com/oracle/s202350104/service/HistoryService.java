package com.oracle.s202350104.service;

import com.oracle.s202350104.model.History;

public interface HistoryService {
	int insertHistory(History history);
	History getLatestHistory(History history);
}
