<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙박 리스트</title>
<style type="text/css">
	.card-text {
		overflow : hidden;
		/* text-overflow: ellipsis; */
	}
</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
	<h1>어디서 주무시겠어요?</h1>
	<div class="album py-5 bg-body-tertiary">
		</div>
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="accomodations" items="${listAccomodations}">
						<div class="col">
							<div class="card" style="width: 20rem;">
  							<img src="${accomodations.img1}" class="card-img-top" alt="${accomodations.title}이미지" style="height: 190px;">
  							<div class="card-body">
    							<p class="card-text" style="height: 240px;">
    								숙소명 : ${accomodations.title} <br>
    								숙소위치 : ${accomodations.address}<br>
    								숙소소개  : ${accomodations.content}
    							</p>
    				<a href="accomodations/detail?content_id=${accomodations.content_id}" class="btn btn-primary">더보기</a>
 						 </div>	
						</div>
					</div>
				</c:forEach>
				</div>
			</div>
			<div align="center">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="accomodations?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="accomodations?currentPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="accomodations?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
			</c:if>
		</div>
	</main>
	
	
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>