<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/components/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>RestaurantDetail</title>
<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function showPopUp(userId, bigCode, smallCode, currentPage, contentId) {
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
	    const url = "../reviewBoardInsertForm?userId="+ userId + "&bigCode=" + bigCode + "&smallCode=" + smallCode + "&currentPage=" + currentPage + "&contentId=" + contentId;
	
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "hello popup", windowStatus);
	}
</script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>

	<h1 style="text-align: center">Restaurant Detail</h1>
	<div class="container border p-5">
		<img alt="${restaurant.title}이미지1" src="${restaurant.img1}">
	</div>
	<div class="container border p-5">
		<img alt="${restaurant.title}이미지2" src="${restaurant.img2}"
			 width=150px height=84px> <img alt="${restaurant.title}이미지3"
			 src="${restaurant.img3}" width=150px height=84px>
	</div>
	<div class="container border p-5">
		<ul>
			<li>음식점명: ${restaurant.title}
			<li>주소: ${restaurant.address}
			<li>전화번호: ${restaurant.phone}
			<li>내용: ${restaurant.content}
			<li>메뉴: ${restaurant.menu}
			<li>운영시간: ${restaurant.open_time}
			<li>휴무일: ${restaurant.rest_date}
			<li>흡연: 
				<c:choose>
					<c:when test="${restaurant.is_smoking == 0}">N</c:when>
					<c:when test="${restaurant.is_smoking == 1}">Y</c:when>
				</c:choose>
			<li>포장: 
				<c:choose>
					<c:when test="${restaurant.is_packing == 0}">N</c:when>
					<c:when test="${restaurant.is_packing == 1}">Y</c:when>
				</c:choose>
			<li>주차: 
				<c:choose>
					<c:when test="${restaurant.is_parking == 0}">N</c:when>
					<c:when test="${restaurant.is_parking == 1}">Y</c:when>
				</c:choose>
		</ul>
	</div>
	<!-- review test -->
	<c:set var="num" value="${page.total-page.start+1 }" />
	<div class="container border p-5">
		<div class="d-flex justify-content-end">
		    <button class="btn btn-primary" onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${restaurant.content_id})">리뷰쓰기</button>		
		</div><br>
		<table class="table">
			<tr class="table-primary text-center">
				<th scope="col">구분</th>
				<th scope="col">한줄평</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">평점</th>
			</tr>
			<c:forEach var="review" items="${reviewBoard }">
				<tr>
					<td class="text-center">${num }</td>
					<td class="text-center">
						<a href="../boardDetail?id=${review.id }">${review.content }</a></td>
					<td class="text-center">${review.name }</td>
					<td class="text-center">
						<fmt:formatDate value="${review.created_at }" 
										type="date" pattern="YYYY/MM/dd" /></td>
					<td class="text-center">${review.score }</td>
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
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>