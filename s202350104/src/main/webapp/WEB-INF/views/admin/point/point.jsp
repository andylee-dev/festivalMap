<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트정보</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<h1>포인트정보</h1>
	<div class="container border p-5">
	<table>
		<tr><th>포인트ID</th><th>포인트작성일</th><th>포인트이름</th><th>포인트내용</th><th>포인트점수</th></tr>
		<c:forEach var="point" items="${listPoint}">
		<tr>
		<td>${point.id }</td>
		<td>${point.create_at }</td>
		<td>${point.title }</td>
		<td>${point.content }</td>
		<td>${point.point }</td>
		</tr>
		</c:forEach>
	</table>
	</div>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>

</body>
</html>