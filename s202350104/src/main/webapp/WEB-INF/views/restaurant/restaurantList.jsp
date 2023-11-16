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
			
			.pink-background {
				margin: auto;
				margin-left: 390px;
				margin-bottom: 20px;
				width: 1250px;
				height: 80px;
				background-color: rgb(255, 67, 121);
				
			}
			.searchForm{
				margin: auto;
				margin-left: 390px;
				width: 1250px;
				height: 80px;
			}
			.a{
				display: flex;
			}
			.title-festival {
				width: 292px;
				height: 51px;
				flex-shrink: 0;
			}
			.straightLine{
				width: 1250px;
				height: 0px;
				border-top: 2px solid black;
				margin: 10px 0;
			}
			.search-keyword {
				margin-left: auto;
			}
			.search-keyword input{
				width: 380px;
				box-sizing: border-box;
				padding: 10px;
				font-size: 16px;
				line-height: 1;
				border: none;
				text-align: center;
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
			
			<div class="pink-background"></div>
			
		<form>		
			<div class="searchForm">
				<div class="a">
					<div class="title-festival">
						<img src="image/titleFestival.png" alt="festival">
					</div>
					<div class="search-keyword">
						<input type="text" placeholder="가고싶은 축제의 이름이나 키워드를 검색해보세요!">
						<i class="bi bi-search" style="font-size: 30px;"></i>
					</div>
				</div>
				<div class="straightLine"></div>
				<div class="b">
				</div>
			</div>
		</form>	
					
			<div class="y">	</div>
			<!-- Section2: Search Form -->
            <div class="border p-3 m-3">
               <form action="restaurantSearch">
                  <h1 class="border">검색폼</h1>
                  <select name="area" id="area">
                     <option value="">전체</option>
                  </select>
                  <select name="sigungu" id="sigungu">
                     <option value="">---</option>
                  </select>
                  <button type="submit"></button>
                  <input type="reset" class="btn btn-outline-secondary" value="초기화">
               </form>
            </div>
                           
	         <div class="album py-5 bg-body-tertiary">
	            <div class="container">
	               <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
	                  <c:forEach var="restaurant" items="${listRestaurant}">
	                     <div class="col">
	                        <div class="card app-card">
	                           <div class="app-tag-container" style="position: relative;">
	                                <div class="app-tag" style="position: absolute; left: 12px; top: 12px;">
	                               	<div class="app-tag-text" style="font-size: 14">#지역해시태그</div>
	                               </div>
	                               <a href="restaurant/detail?contentId=${restaurant.content_id}&currentPage=${page.currentPage}">
	                             <img src="${restaurant.img1}" class="app-card-img-top" alt="${restaurant.title}이미지"></a>
	                             </div>
	                             <div class="card-body app-card-body">
	                               <p class="app-card-text"">
	                         		     음식점명 : ${restaurant.title} <br>
	                                  <span style="color: #FF4379;">추천메뉴 : ${restaurant.first_menu}</span><br>
	                                  <span style="font-weight: normal;">소개  : ${restaurant.content}</span>
	                               </p>
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