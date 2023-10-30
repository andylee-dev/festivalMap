<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Spot</title>
</head>
<body>
<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		<h1>주변명소</h1>
	<table>
		 	<c:forEach var="spot" items="${listSpot}">
		<tr><td><img src="${spot.img1}"></td>
			<td><a href="detailSpot?=${spot.content_id}">${spot.title}</a></td>
			<td>${spot.rest_date}</td>
			</c:forEach>
	</table>

<%@ include file="/WEB-INF/components/Footer.jsp" %>	
</body>
</html>