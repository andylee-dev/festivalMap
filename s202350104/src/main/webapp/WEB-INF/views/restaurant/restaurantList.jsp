<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>RestaurantList</title>
		<style type="text/css">
		.card-text {
			overflow: 			hidden;
			text-overflow: 		ellipsis; /* 말줄임표 */
			diplay: 		    -webkit-box; /* 박스 안 텍스트가 10줄 넘어가면 말줄임표 */
			-webkit-line-clamp: 10;
			-webkit-box-orient: vertical;
		}
		</style>
	</head>
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		<main>
			<div
				class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
				<h1>어느 식당으로 찾아갈까요?</h1>
			</div>
			<!-- select box 만들기 	
			<div class="container border p-5">
				<form action="festival"></form>
			</div> -->
			<div class="album py-5 bg-body-tertiary">
				<div class="container">
					<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
						<c:forEach var="restaurant" items="${listRestaurant}">
							<div class="col">
								<div class="card" style="width: 20rem;">
				  					<img src="${restaurant.img1}" class="card-img-top" alt="${restaurant.title}이미지" style="height: 190px;">
				  					<div class="card-body">
				    					<p class="card-text" style="height: 240px;">
				    						음식점명 : ${restaurant.title} <br>
				    						추천메뉴 : ${restaurant.first_menu}<br>
				    						소개       : ${restaurant.content}
				    					</p>
				    					<a href="restaurant/detail?content_id=${restaurant.content_id}" class="btn btn-primary">더보기</a>
				 				 	</div>	
								</div>
							</div>				
						</c:forEach>
					</div>
				</div>		
			</div>
			<div align="center">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="restaurant?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="restaurant?currentPage=${i}" class="pageblock">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="restaurant?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
			</c:if>
			</div>
		</main>			
		
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
	</body>
</html>