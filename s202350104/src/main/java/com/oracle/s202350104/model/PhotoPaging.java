package com.oracle.s202350104.model;

import lombok.Data;

@Data
public class PhotoPaging {
	private int currentPage = 1;
	private int rowPage = 5;
	private int pageBlock = 5;
	private int start;
	private int end;
	private int startPage;
	private int endPage;
	private int total;
	private int totalPage;

	public PhotoPaging(String currentPage1, int total) {
		this.total = total; 

		if (currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1); // 2
		}

		// 1 10
		start = (currentPage - 1) * rowPage + 1; // 시작 시 1, 6
		end = start + rowPage; // 시작 시 6, 12

		// 25 / 10
		totalPage = (int) Math.ceil((double) total / rowPage);

		// 2 2
		startPage = currentPage - (currentPage - 1) % currentPage;
		endPage = startPage + pageBlock - 1; // 10

		// 10 / 14
		if (endPage > totalPage) {
			endPage = totalPage;
		}

	}

}