<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>

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
       		$("#course").submit();
    	});
	});
	
</script>
<!-- 지역 코드 넣는 코드  End-->
	
</head>
<body>
	<!-- 임시, 여백용-->
	<div id="content_title" class="container"></div>
	
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
	<div class="container homeList-top-custom"></div>
	
	<!-- keyword, title 영역 -->	
	<form id="course" action="course" method="get">
	<div class="container homeCommon-keyword-title-custom">
		<div class="co1 title-div"">
					C O U R S E!</div>
		<div class="co1 text-div">
			<h4><strong>어떤 여행코스를 가볼까요~♫</strong></h4>
		</div>
		<input class="form-control keyword-input" type="text" name="keyword" placeholder="가고 싶은 코스의 이름이나 키워드를 검색해보세요.">
		<img class="keyword-img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon" onclick="submitForm()"/>
	</div>

	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">

	<!-- select 영역 -->
	<div class="container homeCommon-select-custom">
		<div class="row g-2 text-center">
			<div class="col d-flex justify-content-center">
				<select class="form-select area-dropdown" 
						aria-label="Default select example" name="area">
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select sigungu-dropdown" 
						aria-label="Default select example" name="sigungu">
				</select>
			</div>
		</div>		
	</div>
	</form>

	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 목록 영역 -->
	<div class="container homeList-menu-custom">
		<c:if test="${courseList.size() == 0}">해당하는 코스 정보가 없습니다.</c:if>
		<div class="row row-cols-3 g-6 homeList-mdMenu-custom">
			<c:forEach var="course" items="${courseList}">
			
				<div class="col d-flex justify-content-center">
					<div class="card homeList-card-custom">
					
						<div class="homeList-tag-custom">
							<div class="homeList-tag-custom2">
								<p class="tag-p">#지역태그</p>
							</div>
							<a href="course/detail?course_id=${course.course_id}&currentPage=${page.currentPage}">
								<img src="${course.img1}" class="card-img-top" alt="${course.course_title}">
							</a>
						</div>
						
						<div class="card-body">
							<p class="card-text title-p">${course.course_title}</p>
							<p class="card-text period-p">${course.area_content}</p>
							<p class="card-text contet-p">${course.course_info}</p>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	
	
	<%-- <div class="album py-5 bg-body-tertiary">
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
	</div> --%>
	
	<!-- 페이징 처리 -->
	<nav aria-label="Page navigation example">
		<ul class="pagination">

			<c:if test="${page.startPage > page.pageBlock}">
				<li class="page-item">
					<a href="course?currentPage=${page.startPage-page.pageBlock}"
					   class="pageblock page-link">[이전]</a></li>
			</c:if>
			<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
				<li class="page-item">
					<a href="course?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
				</li>
			</c:forEach>
			<c:if test="${page.endPage < page.totalPage}">
				<li class="page-item">
					<a href="course?currentPage=${page.startPage+page.pageBlock}"
					   class="pageblock page-link">[다음]</a></li>
			</c:if>

		</ul>
	</nav>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>