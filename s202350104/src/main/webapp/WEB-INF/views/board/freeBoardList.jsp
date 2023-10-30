<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>FreeBoardList Test</h1>
	<table border="1">
		<tr>
			<th>ID</th>
			<th>제목</th>
			<th>작성일</th>
			<th>조회수2</th>
		</tr>
		<c:forEach var="board" items="${freeBoard }">
			<td>${board.id }</td>
			<td>${board.title }</td>
			<td>${board.created_at }</td>
			<td>${board.read_count }</td>
		</c:forEach>

	</table>
</body>
</html>