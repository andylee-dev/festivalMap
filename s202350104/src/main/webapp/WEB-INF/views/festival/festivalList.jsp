<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalList</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>Festival List</h1>
	<table>
		<tr><th>아이디</th><th>축제명</th><th>축제기간</th><th>주최자</th><th>행사장소</th></tr>
		<c:forEach var="festival" items="${listFestivals}">
			<tr>
				<td>${festival.content_id}</td>
				<td>${festival.title}</td>
				<td>${festival.start_date} ~ ${festival.end_date}</td>
				<td>${festival.sponsor}</td>
				<td>${festival.eventplace}</td>
			</tr>
		</c:forEach>
	</table>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>