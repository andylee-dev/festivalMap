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
			.form-select {
				width: 200px;
				border: 2px black solid;
				border-radius: 23.50px;
				margin-bottom: 5px;
				border: 2px black solid;
			}
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
		  
		  <!-- 아이콘 클릭 이벤트 리스너 -->
		  <script type="text/javascript">
			  $(document).ready(function () {
			        $(".bi.bi-search").on("click", function () {
			            $("#restaurantSearch").submit();
			        });
			    });
		   </script>
	 
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
			<div class="pink-background"></div>
			<form id="restaurantSearch" action="restaurantSearch">		
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
					
					<!-- 경계선 표현 -->
					<hr class="container p-0" style="border-color: black; border-width: 4px;">
					<!-- 셀렉터 영역 -->
					<div class="container p-0" style="height: 50px;">
						<div class="row g-2 text-center">
							<div class="col d-flex justify-content-center">
								<select name="area" id="area" class="form-select text-center border-3" aria-label="Default select example"
										style="font-size:20px; font-weight: bolder;">
									<option selected>시,도 선택</option>
								</select>
							</div>
							<div class="col d-flex justify-content-center">
								<select name="sigungu" id="sigungu" class="form-select text-center border-3" aria-label="Default select example"
										style="font-size:20px; font-weight: bolder;">
									<option selected>시,군,구 선택</option>
								</select>
							</div>
							<div class="col d-flex justify-content-center">
								<select name="small_code" id="small_code" class="form-select text-center border-3" aria-label="Default select example"
										style="font-size:20px; font-weight: bolder;">
									<option selected>테마 선택</option>
									<option value="1">한식</option>
									<option value="2">양식</option>
									<option value="3">일식</option>
									<option value="4">중식</option>
									<option value="5">이색음식점</option>
									<option value="6">카페</option>
									<option value="7">클럽</option>
								</select>
							</div>
						</div>		
					</div>
					<!-- 경계선 표현 -->
					<hr class="container p-0" style="border-color: black; border-width: 4px;">		
				</div>
			</form> 
			
			
				<!-- Section2: Search Form -->
				<div class="border p-3 m-3"></div>
	                           
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