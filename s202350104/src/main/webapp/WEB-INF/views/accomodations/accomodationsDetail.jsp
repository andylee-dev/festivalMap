<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>숙박 상세</title>
	</head>
<body>
	 <%@ include file="/WEB-INF/components/TobBar.jsp" %>
	 
	 <h1>숙박 상세</h1>
	 <div class="container border p-5">
	 <img alt="${accomodations.title}이미지1" src="${accomodations.img1}">
	 </div>
	 <div class="container border p-5">
			<img alt="${accomodations.title}이미지2" src="${accomodations.img2}">
	 </div>
	 <div class="container border p-5">
		
	 	 <ul>
	 	 		<li>상호명 : ${accomodations.title}
	 	 		<li>개요 : ${accomodations.content}
	 	 		<li>주소 : ${accomodations.address}
	 	 		<li>우편번호 : ${accomodations.postcode}
	 	 		<li>전화번호 : ${accomodations.phone}
	 	 		<li>홈페이지 : <a href="${accomodations.homepage}">${accomodations.homepage}</a>
				<li>객실수 : ${accomodations.room_count}
				<li>예약처 : <a href="${accomodations.reservation_url}">${accomodations.reservation_url}</a>
				<li>환불규정 : ${accomodations.refund}
				<li>입실시간 : ${accomodations.check_in}
				<li>퇴실시간 : ${accomodations.check_out}
				<li>픽업가능 : ${accomodations.is_pickup}
				<li>조리가능 : 
					<c:choose>
						<c:when test="${accomodations.is_cook == 0}">Y</c:when>
						<c:when test="${accomodations.is_cook == 1}">N</c:when>
					</c:choose>
				<li>주차시설 :
					<c:choose>
						<c:when test="${accomodations.is_parking == 0}">Y</c:when>
						<c:when test="${accomodations.is_parking == 1}">N</c:when>
					</c:choose>
	 	 </ul>
		</div>
		
		<!-- review test -->
		<c:set var="num" value="${page.total-page.start+1 }"/>
		<div class="container border p-5">
		    <div class="text-right"> <!-- 버튼을 오른쪽 정렬하는 부분 -->
		        <button class="btn btn-primary" onclick="location.href='../boardInsertForm?userId=1&bigCode=${bigCode}&smallCode=${smallCode}'">글쓰기</button>
		    </div>
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
								<a href="../boardDetail?id=${review.id }">${review.content }</a>
							</td>
						<td class="text-center">${review.name }</td>
						<td class="text-center">
							<fmt:formatDate value="${review.created_at }" type="date"
											pattern="YYYY/MM/dd"/></td>
						<td class="text-center">${review.score }</td>
					</tr>
					<c:set var="num" value="${num - 1 }"/>
			</c:forEach>
			</table>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center" style="display: flex; list-style: none; padding: 0;">
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
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>