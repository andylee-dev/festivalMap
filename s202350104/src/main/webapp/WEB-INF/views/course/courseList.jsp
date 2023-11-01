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
			.card-text {
				overflow: hidden;
				text-overflow: ellipsis; /* 말줄임표 */
				display: -webkit-box;
				-webkit-line-clamp: 10;  /* 박스 안 텍스트가 10줄 넘어가면 말줄임표 */
				-webkit-box-orient: vertical;
			}	
		</style>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
		<div
			class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<h1>여행을 떠나볼까요?</h1>
		</div>
		
		<div class="album py-5 bg-body-tertiary">
			<div class="container">
				<div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 g-3">
					<c:forEach var="course" items="${courseList }">
						<div>
							<div class="card" style="width: 20em;">
								<img src="${course.img1 }" class="card-img-top" alt="${course.course_title }" style="height: 190px;" /> 
								<div class="card-text" style="height: 240px;">
									<h5 class="card-title">코스이름 : ${course.course_title }</h5>
									<p class="card-text">코스 제목 : ${course.course_info }</p>
									<a href="#" class="btn btn-primary">상세보기</a>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
		<c:if test="${page.startPage > page.pageBlock}">
			<a href="course?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<a href="course?currentPage=${i}" class="pageblock">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<a href="course?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
		</c:if>
	</main>	
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>