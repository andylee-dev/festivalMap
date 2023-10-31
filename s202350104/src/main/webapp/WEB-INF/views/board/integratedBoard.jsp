<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board</title>
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
	
	<div id="content_title" class="container border p-5 mb-4">
		<h1>게시판 목록</h1>
	</div>
	
	<c:set var="num" value="${page.total-page.start+1 }"/>
	
	<div class="container border p-5">
		<table class="table">
			<tr class="table-primary">
				<th scope="col">구분</th>
				<th scope="col">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">조회수</th>
			</tr>
			<c:forEach var="boards" items="${board }">
				<tr>
					<td>${num }</td>
					<td><a href="boardDetail?id=${boards.id }">${boards.title }</a></td>
					<td>${boards.name }</td>
					<td><fmt:formatDate value="${boards.created_at }" type="date"
										pattern="YYYY/MM/dd"/></td>
					<td>${boards.read_count }</td>
				</tr>
				<c:set var="num" value="${num - 1 }"/>
			</c:forEach>
		</table>
	</div>

</body>
</html>