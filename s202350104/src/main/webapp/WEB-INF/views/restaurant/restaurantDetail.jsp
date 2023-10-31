<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Detail</title>
</head>
<body>
	 <!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>Restaurant Detail</h1>
	<div class="container border p-5">
	<table>
		<tr><th>음식점명</th><td>${restaurant.title}</td></tr>
		<tr><th>내용</th><td>${restaurant.content}</td></tr>
		<tr><th>주소</th><td>${restaurant.address}</td></tr>
		<tr><th>메뉴</th><td>${restaurant.menu}</td></tr>
		<tr><th>운영시간</th><td>${restaurant.open_time}</td></tr>
		<tr><th>휴무일</th><td>${restaurant.rest_date}</td></tr>
	</table>
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>