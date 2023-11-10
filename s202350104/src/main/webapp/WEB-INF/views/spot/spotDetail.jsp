<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SpotDetail</title>
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

	<h1>Spot Detail</h1>
	<div class="container border p-5">
		<img alt="${spot.title}이미지1" src="${spot.img1}">
	</div>
	<div class="container border p-5">
		<img alt="${soit.title}이미지2" src="${spot.img2}">
	</div>
	<div class="container border p-5">
		<ul>
			<li>명소명 : ${spot.title}
			<li>개요 : ${spot.content}
			<li>영업시간 : ${spot.opening_hours}
			<li>입장료 : ${spot.entrance_fee}
			<li>휴무일: ${spot.rest_date}
			<li>우편번호 : ${spot.postcode}
			<li>주소 : ${spot.address}
			<li>문의전화 : ${spot.phone}
			<li>홈페이지 : <a href="${spot.homepage}">${spot.homepage}</a>
			<li>주차시설 : 
				<c:choose>
					<c:when test="${spot.is_parking == 0}">N</c:when>
					<c:when test="${spot.is_parking == 1}">Y</c:when>
				</c:choose>
			<li>유모차대여 : 
				<c:choose>
					<c:when test="${spot.is_stroller == 0}">N</c:when>
					<c:when test="${spot.is_stroller == 1}">Y</c:when>
				</c:choose>
			<li>휠체어대여 : 
				<c:choose>
					<c:when test="${spot.is_wheelchair == 0}">N</c:when>
					<c:when test="${spot.is_wheelchair == 1}">Y</c:when>
				</c:choose>
			<li>장애인화장실 : 
				<c:choose>
					<c:when test="${spot.is_restroom == 0}">N</c:when>
					<c:when test="${spot.is_restroom == 1}">Y</c:when>
				</c:choose>
			<li>반려동물동반 : 
				<c:choose>
					<c:when test="${spot.is_pet == 0}">N</c:when>
					<c:when test="${spot.is_pet == 1}">Y</c:when>
				</c:choose>
			<li>엘리베이터 : 
				<c:choose>
					<c:when test="${spot.is_elevator == 0}">N</c:when>
					<c:when test="${spot.is_elevator == 1}">Y</c:when>
				</c:choose>
		</ul>
	</div>

	<!-- review test -->
	<c:set var="num" value="${page.total-page.start+1 }" />
	<div class="container border p-5">
		<div class="d-flex justify-content-end">
			<button class="btn btn-primary"
				onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${spot.content_id},${spot.big_code})">리뷰쓰기</button>
		</div>
		<br>
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
					<td class="text-center"><a
						href="../boardDetail?id=${review.id }">${review.content }</a></td>
					<td class="text-center">${review.name }</td>
					<td class="text-center"><fmt:formatDate
							value="${review.created_at }" type="date" pattern="YYYY/MM/dd" /></td>
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
						<li class="page-item"><c:if
								test="${page.startPage > page.pageBlock }">
								<a class="page-link"
									href="reviewBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
							</c:if></li>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item"><a class="page-link"
								href="reviewBoardList?currentPage=${i}">${i}</a></li>
						</c:forEach>
						<li class="page-item"><c:if
								test="${page.endPage < page.totalPage }">
								<a class="page-link"
									href="reviewBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
							</c:if></li>
					</c:when>
				</c:choose>
			</ul>
		</nav>
	</div>
	<div class="text-center">
		<input type="button" value="목록" onclick="location.href='../spot'">
	</div>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>