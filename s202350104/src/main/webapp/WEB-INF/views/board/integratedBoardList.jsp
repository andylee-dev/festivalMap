<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>integratedBoard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
	
</script>
<style>
	a {
		text-decoration: none;
	}
</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	
	<div id="content_title" class="container p-5 mb-4 d-flex justify-content-between align-items-center">
		<c:choose>
			<c:when test="${smallCode == 2}">
				<h1>이달의 소식</h1>
			</c:when>
			<c:when test="${smallCode == 3}">
				<h1>자유게시판</h1>
			</c:when>
	    	<c:otherwise>
	        	<h1>공지사항</h1>
	    	</c:otherwise>
		</c:choose>
		<button class="btn btn-primary" onclick="location.href='boardInsertForm?userId=1&bigCode=${bigCode }&smallCode=${smallCode }'">글쓰기</button>
	</div>
	
	<c:set var="num" value="${page.total-page.start+1 }"/>
	
	<div class="container border p-5">
		<table class="table">
			<tr class="table-primary text-center">
				<th scope="col">구분</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">조회수</th>
			</tr>
			<c:forEach var="boards" items="${board }">
				<tr>
					<td class="text-center">${num }</td>
					<td class="text-center">
						<a href="boardDetail?id=${boards.id }">${boards.title }</a></td>
					<td class="text-center">${boards.name }</td>
					<td class="text-center">
						<fmt:formatDate value="${boards.created_at }" type="date"
										pattern="YYYY/MM/dd"/></td>
					<td class="text-center">${boards.read_count }</td>
				</tr>
				<c:set var="num" value="${num - 1 }"/>
			</c:forEach>
		</table>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center">
				<li class="page-item">
					<a class="page-link" href="freeBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
				</li>				
				
				<li class="page-item">
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage }">
						<a class="page-link" href="freeBoardList?currentPage=${i }">${i }</a>
					</c:forEach>
				</li>
				
				<li class="page-item">
					<a class="page-link" href="freeBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
				</li>
			</ul>
		</nav>
	</div>
</body>
</html>