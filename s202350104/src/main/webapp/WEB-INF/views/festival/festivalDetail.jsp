<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalDetail</title>

<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function showPopUp(userId, bigCode, smallCode, currentPage, contentId, commonCode) {
	    console.log("showPopUp 함수가 호출되었습니다.");		
		//창 크기 지정
		var width = 550;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
	    //윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
	    //연결하고싶은url
	    const url = "../reviewBoardInsertForm?userId="+ userId + "&commonCode=" + commonCode + "&bigCode=" + bigCode + "&smallCode=" + smallCode + "&currentPage=" + currentPage + "&contentId=" + contentId;
	
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "hello popup", windowStatus);
	}
	
	function report(boardId) {
	    window.open("../reportBoardFoam?boardId=" + boardId, "_blank", "width=600, height=400, top=100, left=100");
	}
</script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>

	<h1>Festival Detail</h1>
	<div class="container border p-5">
		<img alt="${festival.title}이미지1" src="${festival.img1}">
	</div>
	<div class="container border p-5">
		<img alt="${festival.title}이미지2" src="${festival.img2}">
	</div>
	<div class="container border p-5">
		<ul>
			<li>축제명 : ${festival.title}
			<li>개요 : ${festival.content}
			<li>축제기간 : ${festival.start_date} ~ ${festival.end_date}
			<li>축제시간 : ${festival.hours}
			<li>요금 : ${festival.cost}
			<li>장소 : ${festival.eventplace}
			<li>우편번호 : ${festival.postcode}
			<li>주소 : ${festival.address}
			<li>주최자 : ${festival.sponsor}
			<li>문의전화 : ${festival.phone}
			<li>홈페이지 : <a href="${festival.homepage}">${festival.homepage}</a>
			<li>행사내용 : ${festival.overview}
			<li>주차시설 : 
				<c:choose>
					<c:when test="${festival.is_parking == 0}">N</c:when>
					<c:when test="${festival.is_parking == 1}">Y</c:when>
				</c:choose>
			<li>유모차대여 : 
				<c:choose>
					<c:when test="${festival.is_stroller == 0}">N</c:when>
					<c:when test="${festival.is_stroller == 1}">Y</c:when>
				</c:choose>
			<li>휠체어대여 : 
				<c:choose>
					<c:when test="${festival.is_wheelchair == 0}">N</c:when>
					<c:when test="${festival.is_wheelchair == 1}">Y</c:when>
				</c:choose>
			<li>장애인화장실 : 
				<c:choose>
					<c:when test="${festival.is_restroom == 0}">N</c:when>
					<c:when test="${festival.is_restroom == 1}">Y</c:when>
				</c:choose>
		</ul>
	</div>

	<!-- review test -->
	<c:set var="num" value="${page.total-page.start+1 }" />
	<div class="container border p-5">
		<div class="d-flex justify-content-end">
		    <button class="btn btn-primary" onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${festival.content_id},${festival.big_code})">리뷰쓰기</button>		
		</div><br>
		<table class="table">
			<tr class="table-primary text-center">
				<th scope="col">구분</th>
				<th scope="col">한줄평</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">평점</th>
				<th scope="col">신고</th>				
			</tr>
			<c:forEach var="review" items="${reviewBoard }">
				<tr>
					<td class="text-center">${num }</td>
					<td class="text-center">
						<a href="../boardDetail?id=${review.id }&userId=${userId}">${review.content }</a></td>
					<td class="text-center">${review.name }</td>
					
					<td class="text-center">
						<fmt:formatDate value="${review.created_at }" type="date" 
										pattern="YYYY/MM/dd" /></td>
					
					<td class="text-center">
						<c:forEach begin="1" end="${review.score }">★</c:forEach>
					</td>
					
					<td class="text-center">
						<button class="btn btn-danger" onclick="report(${review.id})">신고</button>
					</td>
				</tr>
				<c:set var="num" value="${num - 1 }" />
			</c:forEach>
		</table>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center"
				style="display: flex; list-style: none; padding: 0;">
				<c:choose>
					<c:when test="${smallCode eq 6}">
						<li class="page-item">
						<c:if test="${page.startPage > page.pageBlock }">
								<a class="page-link" href="reviewBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
							</c:if>
						</li>
						
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a class="page-link" href="reviewBoardList?currentPage=${i}">${i}</a>
							</li>
						</c:forEach>
						
						<li class="page-item">
							<c:if test="${page.endPage < page.totalPage }">
								<a class="page-link" href="reviewBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
							</c:if>
						</li>
					</c:when>
				</c:choose>
			</ul>
		</nav>
	</div>
	<div align="center">
		<button onclick="location.href='../festival'">목록</button>
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>