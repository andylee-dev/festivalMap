package com.oracle.s202350104.service;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class Paging {
	private int currentPage = 1;	// 현재 페이지 번호	
	private int rowPage = 9;		// 한 페이지 당 나오는 컨텐츠 개수
	private int pageBlock = 10;		// 페이지 번호 블록 개수
	private int start;				// 페이지 시작 컨텐츠 번호(rownum)		
	private int end;				// 페이지 마지막 컨텐츠 번호(rownum)
	private int startPage;			// 현재 화면의 페이지 번호 블록의 처음 페이지 번호	
	private int endPage;			// 현재 화면의 페이지 번호 블록의 마지막 페이지 번호
	private int total;				// 총 컨텐츠 개수				
	private int totalPage;			// 총 페이지 수
	
	public Paging(int total, String currentPage1) {
		this.total = total;
		// currentPage1 파라미터 값이 있을 경우, currentPage는 해당 번호값을 가진다
		if(currentPage1 != null) {
			this.currentPage = Integer.parseInt(currentPage1);
		}
		
		start = (currentPage - 1) * rowPage + 1;	// 페이지 시작 컨텐츠 번호(rownum)
		end	  = start + rowPage -1;					// 페이지 마지막 컨텐츠 번호(rownum)
		
		totalPage = (int) Math.ceil((double)total / rowPage); // 총 페이지 수
		
		startPage = currentPage - (currentPage - 1) % pageBlock;	// 현재 화면에서 페이지 번호 블록의 처음 번호
		endPage   = startPage + pageBlock - 1;						// 현재 화면에서 페이지 번호 블록의 마지막 번호
		
		// endPage가 총 페이지 보다 클 경우 빈 페이지가 생기는 것을 방지하기 위해서 endPage = totalPage로 설정
		if(endPage > totalPage) {
			endPage = totalPage;
		}
	
	}
}
