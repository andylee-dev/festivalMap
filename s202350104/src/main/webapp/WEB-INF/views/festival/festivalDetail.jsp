<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalDetail</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>Festival Detail</h1>
	<div class="container border p-5">
		<tr><th>축제명</th><td>${festival.title}</td></tr>
		<tr><th>개요</th><td>${festival.content}</td></tr>
		<tr><th>장소</th><td>${festival.eventplace}</td></tr>
		<tr><th>주소</th><td>${festival.address}</td></tr>
		<tr><th>행사내용</th><td>${festival.overview}</td></tr>
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>