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
	
	<h1>배너조회</h1>
	${originalFileName} 파일을 업로드 하였습니다.<br>
	<div class="container border p-5">
		<table class="table">
			<tr class="table-primary text-center">
				<th scope="col">구분</th>
				<th scope="col">제목</th>
				<th scope="col">내용</th>
				<th scope="col">URL</th> 
				<th scope="col">image</th>
				<th scope="col">생성일</th>
			</tr>
			
			<c:forEach var="banners" items="${banner }">
				<tr>
					<td class="text-center">${banners.id }</td>
					<td class="text-center">
						<a href="boardDetail?id=${banners.id }">${banners.title }</a>
					</td>
					<td class="text-center">${banners.content }</td>
					<td class="text-center">${banners.url }</td>
					<td class="text-center">${banners.image }</td>
					<td class="text-center">
						<fmt:formatDate value="${banners.created_at }" type="date"
										pattern="YYYY/MM/dd"/></td>
				</tr>
				<c:set var="num" value="${num - 1 }"/>
			</c:forEach>
		</table>
	</div>
</body>
</html>