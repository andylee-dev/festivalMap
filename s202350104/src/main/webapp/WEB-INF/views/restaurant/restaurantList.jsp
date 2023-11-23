<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>RestaurantList</title>
		
		<style type="text/css">
			.pageblock {
				text-align: center;
			}
		</style>
		
		<!-- 지역 코드 넣는 코드  Start-->
		<script src="/js/updateArea.js"></script>
		
		<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function() {
				updateAreaOptions();
				$(".area-dropdown").change(
						function() {
							const selectedArea = $(this).val();
							if (selectedArea) {
								updateSigunguOptions(selectedArea);
							} else {
								$(".sigungu-dropdown").empty().append(
										"<option value='0'>전체</option>");
							}
					});
			});
	
	    	// 이미지를 클릭할 때 폼을 제출하는 함수
	    	$(document).ready(function () {
	       		$("#searchIcon").click(function () {
	           		$("#restaurantSearch").submit();
	       		});
	   		});
	   		
		</script>
		<!-- 지역 코드 넣는 코드  End-->
		
	</head>	 	
	 	
	<body>
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
					
		<!-- 상단 분홍색 영역 -->
		<div class="container homeList-top-custom"></div>
		
		<div>
			<form id="restaurantSearch" action="restaurantSearch">
			<input type="hidden" name="big_code" value="12">
			
			<!-- keyword, title 영역 -->	
			<div class="container homeCommon-keyword-title-custom">
			<div class="co1 title-div">
						RESTAURANT!</div>
			<div class="co1 text-div">
				<h4><strong>어느 맛집에서 먹어볼까요~♫</strong></h4>
			</div>
			<input class="form-control keyword-input" type="text" name="keyword" placeholder="가고 싶은 맛집의 이름이나 키워드를 검색해보세요." style="margin-right: 15px;">
			<img class="keyword-img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon"/>
			</div>
		
			<!-- 경계선 표현 -->
			<hr class="container homeCommon-top-custom">		
			
			
			<!-- select 영역 -->
			<div class="container homeCommon-select-custom">
				<div class="row g-2 text-center">
					<div class="col d-flex justify-content-center">
						<select class="form-select area-dropdown" 
							aria-label="Default select example" name="area" >
						</select>
					</div>
					<div class="col d-flex justify-content-center">
					<select class="form-select sigungu-dropdown" 
							aria-label="Default select example" name="sigungu">
					</select>
					</div>
					<div class="col d-flex justify-content-center">
						<select name="small_code" id="small_code" class="form-select text-center border-3 select_text_custom" 
								aria-label="Default select example">
								<option value="999">테마 선택</option>
								<c:forEach var="smallCode" items="${listSmallCode}">
									<option value="${smallCode.small_code}">${smallCode.content}</option>
								</c:forEach>	 	
						</select>
					</div>
					<input type="hidden" name="currentPage" value="${page.currentPage}">
				</div>		
			</div>	
			</form>
			
			
		<!-- 경계선 표현 -->
		<hr class="container homeCommon-top-custom">	

		<!-- 목록 영역 -->	                           
        <div class="container homeList-menu-custom">
        	<c:if test="${listRestaurant.size() == 0}">해당하는 식당 정보가 없습니다.</c:if>
            <div class="row row-cols-3 g-6 homeList-mdMenu-custom">
                  <c:forEach var="restaurant" items="${listRestaurant}">
                  	<div class="col d-flex justify-content-center">
                        <div class="card homeList-card-custom">
							<div class="homeList-tag-custom">
								<div class="homeList-tag-custom2">
									<p class="tag-p">#지역태그</p>
								</div>
                          	<a href="restaurant/detail?contentId=${restaurant.id}&currentPage=${page.currentPage}">
                            	<img src="${restaurant.img1}" class="card-img-top" alt="${restaurant.title}이미지">
                         	</a>
                         </div>
                         <div class="card-body">
	                          <p class="card-text title-p">${restaurant.title}</p>   
	                          <p class="card-text period-p">${restaurant.first_menu}</p>
	                          <p class="card-text contet-p">${restaurant.content}</p>
                          </div>   
                        </div>
                     </div>            
                  </c:forEach>
               </div>
            </div>      
               
         <!-- 페이징 처리 -->
         <nav aria-label="Page navigation example">
			<ul class="pagination">
         	<c:if test="${page.startPage > page.pageBlock}">
	            <c:choose>
	               <c:when test="${path==0}">
	 	            <li class="page-item">
	                  <a href="restaurant?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
		            </li>   
	               </c:when>
	               <c:when test="${path==1}">
					<li class="page-item">
	                  <a href="restaurantSearch?big_code=${big_code}&keyword=${keyword}&area=${area}&sigungu=${sigungu}&small_code=${small_code}&currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>   
	               </li> 
	               </c:when>
	            </c:choose>
	         </c:if>
	         <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
	            <c:choose>
	               <c:when test="${path==0}">
	               <li class="page-item">
	                  <a href="restaurant?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':''}">${i}</a>
	               </li>
	               </c:when>
	               <c:when test="${path==1}">
	               <li class="page-item">
	                  <a href="restaurantSearch?big_code=${big_code}&keyword=${keyword}&area=${area}&sigungu=${sigungu}&small_code=${small_code}&currentPage=${i}" class="pageblock page-link  ${page.currentPage == i ? 'active':''}">${i}</a>
	               </li>
	               </c:when>
 	            </c:choose> 
	         </c:forEach>
	         <c:if test="${page.endPage < page.totalPage}">
	            <c:choose>
 	          	   <c:when test="${path==0}">
 	          	   <li class="page-item">
	                  <a href="restaurant?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
	               </li>
	               </c:when>
	               <c:when test="${path==1}">
	               <li class="page-item">
	                  <a href="restaurantSearch?big_code=${big_code}&keyword=${keyword}&area=${area}&sigungu=${sigungu}&small_code=${small_code}&currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
	               </li>
	               </c:when>
	         	</c:choose>
	         </c:if>
	         </ul>
		 </nav>
         
     
      <!-- Footer -->
      <%@ include file="/WEB-INF/components/Footer.jsp" %>
   </body>
</html>