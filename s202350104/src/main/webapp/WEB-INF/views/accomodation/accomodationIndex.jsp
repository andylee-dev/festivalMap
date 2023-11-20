<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>숙박 리스트</title>
		<%@ include file="/WEB-INF/components/AdminUpdateAreas.jsp"%>
	<style type="text/css">
		.pageblock {
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
				<c:when test="${headers.title == '숙박' }">
					<img alt="숙박_headerBanner" src="${headers.image }">
				</c:when>
			</c:choose> 
		</c:forEach>
		<!-- HeaderBanner end -->
	</div>
	
	
	<!-- 상단 분홍색 영역 -->
	<div class="container p-0 top_custom"></div>
	
	<!-- keyword, title 영역 -->	
	<div class="container p-0 keyword_title_custom border">
		<div class="co1 title_div">
					F E S T I V A L!</div>
		<div class="co1 text_div">
			<h4><strong>어느 숙소에서 지내볼까요~♫</strong></h4>
		</div>
		<input class="form-control keyword_input" type="text" name="keyword" placeholder="가고 싶은 숙소의 이름이나 키워드를 검색해보세요.">
		<img class="keyword_img" src="../image/icon_search1.png" alt="icon_search1.png"/>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container p-0">	
	
	<!-- select 영역 -->
	<div class="container p-0 select_custom">
		<div class="row g-2 text-center">
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom area-dropdown" 
						aria-label="Default select example" name="area">
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom sigungu-dropdown" 
						aria-label="Default select example" name="sigungu">
					<option selected>시,군,구 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom" aria-label="Default select example">
					<option selected>진행 기간 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom" aria-label="Default select example">
					<option selected>진행 여부 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
		</div>		
	</div>	
	
	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">	
	
	
	<div class="border p-3 m-3">
		<form action="indexaccomodationSearch">
						<h1 class="border">검색폼</h1>
						<select name="area" id="area">
							<option value="">전체</option>
						</select> <select name="sigungu" id="sigungu">
							<option value="">---</option>
						</select>
						<button type="submit" class="btn btn-outline-secondary">검색</button>
						<input type="reset" class="btn btn-outline-secondary" value="초기화">
					</form>
				</div>
	<div class="album py-5 bg-body-tertiary">
		</div>
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="accomodation" items="${listAccomodation}">
						<div class="col">
							<div class="card app-card">
								<div class="app-tag-container" style="position: relative;">
              					<div class="app-tag" style="position: absolute; left: 12px; top: 12px;">
                				<div class="app-tag-text" style="font-size: 14">#지역해시태그</div>
             					</div>
             					<a href="accomodation/detail?contentId=${accomodation.content_id}&currentPage=${page.currentPage}">
  								<img src="${accomodation.img1}" class="app-card-img-top" alt="${accomodation.title}이미지"></a>
	  							</div>
	  							<div class="card-body app-card-body">
	    							<p class="app-card-text">
	    								숙소명 : ${accomodation.title} <br>
	    								<span style="color: #FF4379;">숙소위치 : ${accomodation.address}</span><br>
	    								<span style="font-weight: normal;">숙소소개  : ${accomodation.content}</span>
	    							</p>
	    							
								</div>	
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<div align="center">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="accomodation?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="accomodation?currentPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="accomodation?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
			</c:if>
		</div>		
	</main>	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>