<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CourseList</title>

<style type="text/css">
	.pageblock {
		text-align: center;
	}
	.card-text {
		overflow: hidden;
		text-overflow: ellipsis; /* 말줄임표 */
		display: -webkit-box;
		-webkit-line-clamp: 10;  /* 박스 안 텍스트가 10줄 넘어가면 말줄임표 */
		-webkit-box-orient: vertical;
	}
	.type {
		    	display: flex;
          	justify-content: center;
         	 	align-items: center;
	}
	.theme_type {
			height: 100px;
			width: 100px;
		border-radius: 100px;
		margin: 20px;
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
	
	 	
	// 서치이미지를 클릭할 때 폼을 제출하는 함수
	$(document).ready(function () {
    	$("#searchIcon").click(function () {
       		$("#").submit();
    	});
	});
	
</script>
<!-- 지역 코드 넣는 코드  End-->
	
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
		<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<!-- HeaderBanner by.엄민용 -->				
			<c:forEach var="headers" items="${bannerHeader }">
				<c:choose>
					<c:when test="${headers.title == '코스' }">
						<img alt="코스_headerBanner" src="${headers.image }">
					</c:when>
				</c:choose> 
			</c:forEach>
			<!-- HeaderBanner end -->
		</div>
		
		<!-- 상단 분홍색 영역 -->
		<div class="container p-0 top_custom"></div>
		
		<!-- keyword, title 영역 -->	
		<form id="restaurantSearch" action="restaurantSearch">
		<div class="container p-0 keyword_title_custom">
		<div class="co1 title_div">
					C O U R S E!</div>
		<div class="co1 text_div">
			<h4><strong>어떤 여행코스를 가볼까요~♫</strong></h4>
		</div>
		<input class="form-control keyword_input" type="text" name="keyword" placeholder="가고 싶은 코스의 이름이나 키워드를 검색해보세요." style="margin-right: 15px;">
		<img class="keyword_img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon"/>
		</div>

		<!-- 경계선 표현 -->
		<hr class="container p-0 hr_custom">	
	
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
					</select>
				</div>
			</div>		
		</div>	

		<!-- 경계선 표현 -->
		<hr class="container p-0 hr_custom">
		
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="course" items="${courseList }">
						<div class="col">
							<div class="card app-card">
								<div class="app-tag-container" style="position: relative;">
								<a href="course/detail?course_id=${course.course_id }"> 
								<img src="${course.img1 }" class="app-card-img-top" alt="${course.course_title }" /></a>
								</div> 
								<div class="card-body app-card-body">
									<div class="app-card-text">
										코스명 : ${course.course_title }<br>
										<span style="color: #FF4379;">코스 시간 : ${course.time }</span><br>
										<span style="font-weight: normal;">지역 : ${course.area_content }</span><br>
										<span style="font-weight: normal;">코스 거리 : ${course.distance }</span><br>
										<span style="font-weight: normal;">코스 정보 :${course.course_info }</span>
									</div>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<div align="center">
			<c:if test="${page.startPage > page.pageBlock}">
				<a href="course?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<a href="course?currentPage=${i}" class="pageblock">[${i}]</a>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<a href="course?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
			</c:if>
		</div>
	</main>	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>