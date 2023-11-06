<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course Content</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">코스정보</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<h1 class="border">검색폼</h1>
					<button type="button" class="btn btn-outline-secondary">검색</button>
					<button type="button" class="btn btn-outline-secondary">초기화</button>
				</div>
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button onclick="location.href='courseInsertForm'" type="button" class="btn btn-outline-secondary">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">코스ID</th>
								<th scope="col">코스이름</th>
								<th scope="col">총거리</th>
								<th scope="col">소요시간</th>
								<th scope="col">등록일</th>
								<th scope="col">지역</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="course" items="${courseList }">
								<tr>
									<td>${course.id }</td>
									<td>${course.course_title }</td>
									<td>${course.distance }</td>
									<td>${course.time }</td>
									<td><fmt:formatDate value="${course.created_at }" type="date" pattern="YY/MM/dd"/></td>
									<td>-</td>
									<td><input onclick="location.href='courseUpdateForm?course_id=${course.course_id}'" type="button" value="수정 "></td>
									<td><input type="button" value="삭제"></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="list?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="list?currentPage=${i}" class="pageblock">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="list?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
						</c:if>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>