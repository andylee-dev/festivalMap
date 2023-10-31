<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<h1>report page</h1>
	<div class="container border p-5">
	<table>
		<tr><th>게시판ID</th><th>글내용</th><th>작성자</th><th>신고횟수</th></tr>
		<c:forEach var="report" items="${listReport}">
		<tr>
		<td>${report.board_id }</td>
		<td>${report.content }</td>
		<td>${report.user_id }</td>
		<td>${report.count }</td>
		<td colspan="2"><input type="button" value="상세보기"></td>
		</tr>
		</c:forEach>
	</table>
	</div>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>

</body>
</html>