<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원포인트내역</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<h1>회원포인트내역</h1>
	<div class="container border p-5">
	<table>
		<tr><th>회원ID</th><th>포인트ID</th><th>생성일</th>
		<c:forEach var="pointhistory" items="${listPointHistory}">
		<tr>
		<td>${pointhistory.user_id }</td>
		<td>${pointhistory.point_id }</td>
		<td>${pointhistory.created_at }</td>
		</tr>
		</c:forEach>
	</table>
	</div>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>

</body>
</html>