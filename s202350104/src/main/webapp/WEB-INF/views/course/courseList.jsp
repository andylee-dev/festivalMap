<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course List</title>
	<style type="text/css">
			.pageblock {
				text-align: center;
			}
	</style>
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