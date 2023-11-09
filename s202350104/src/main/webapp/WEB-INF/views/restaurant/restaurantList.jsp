<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>RestaurantList</title>
		<%@ include file="/WEB-INF/components/AdminUpdateAreas.jsp"%>
		<style type="text/css">
			.pageblock{
				text-align: center;
			}
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
			<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
				<!-- HeaderBanner by.엄민용 -->	
				<c:forEach var="headers" items="${bannerHeader }">
					<c:choose>
						<c:when test="${headers.title == '맛집' }">
							<img alt="맛집_headerBanner" src="${headers.image }">
						</c:when>
					</c:choose> 
				</c:forEach>
				<!-- HeaderBanner end -->
			</div>
			
			<!-- Section2: Search Form -->
				<div class="border p-3 m-3">
					<form action="restaurantSearch">
						<h1 class="border">검색폼</h1>
						<select name="area" id="area">
							<option value="">전체</option>
						</select> <select name="sigungu" id="sigungu">
							<option value="">---</option>
						</select>
						<button type="submit" class="btn btn-outline-secondary">검색</button>
						<button type="button" class="btn btn-outline-secondary">초기화</button>
					</form>
				</div>
									
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
				    					<a href="restaurant/detail?contentId=${restaurant.content_id}" class="btn btn-primary">더보기</a>
				 				 	</div>	
								</div>
							</div>				
						</c:forEach>
					</div>
				</div>		
			</div>
			
			<div align="center">
			<c:if test="${page.startPage > page.pageBlock}">
				<c:choose>
					<c:when test="${path==0}">
						<a href="restaurant?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
					</c:when>
					<c:when test="${path==1}">
						<a href="restaurantSearch?area=${area}?sigungu=${sigungu}?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>	
					</c:when>
				</c:choose>	
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<c:choose>
					<c:when test="${path==0}">
						<a href="restaurant?currentPage=${i}" class="pageblock">[${i}]</a>
					</c:when>
					<c:when test="${path==1}">
						<a href="restaurantSearch?area=${area}?sigungu=${sigungu}?currentPage=${i}" class="pageblock">[${i}]</a>
					</c:when>
				</c:choose>	
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<c:choose>
					<c:when test="${path==0}">
						<a href="restaurant?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
					</c:when>
					<c:when test="${path==1}">
						<a href="restaurantSearch?area=${area}?sigungu=${sigungu}?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
					</c:when>
				</c:choose>	
			</c:if>
			</div>
						
		</main>			
		
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
	</body>
</html>