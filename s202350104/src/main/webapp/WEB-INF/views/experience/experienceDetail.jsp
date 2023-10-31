<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험정보 상세</title>
    
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>체험정보 상세</h1>
	<div class="container border p-5">
	<table>
		<tr><th>체험이름</th><td>${experience.title}</td></tr>
		<tr><th>개요</th><td>${experience.content}</td></tr>
		<tr><th>주소</th><td>${experience.address}</td></tr>
		<tr><th>email</th><td>${experience.email}</td></tr>
		<tr><th>전화번호</th><td>${experience.phone}</td></tr>
		<tr><th>홈페이지</th><td>${experience.homepage}</td></tr>
		<tr><th>작성일</th><td>${experience.created_at}</td></tr>
		<tr><th>수용인원</th><td>${experience.capacity}</td></tr>
		<tr><th>체험연령</th><td>${experience.age}</td></tr>
		<tr><th>체험안내</th><td>${experience.inform}</td></tr>
		<tr><th>개장시간</th><td>${experience.open_time}</td></tr>
		<tr><th>휴무일</th><td>${experience.rest_time}</td></tr>
		<tr><th>비용안내</th><td>${experience.cost}</td></tr>
	</table>	
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
	
	 
</body>
</html>