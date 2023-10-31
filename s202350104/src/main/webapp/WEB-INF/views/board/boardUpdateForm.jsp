<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>게시판 수정</h1>
	<form action="boardUpdate" method="post">
		<input type="hidden" name="id" value="${board.id }">
		<input type="hidden" name="name" value="${board.name }">
		<table>
			<tr>
				<th>번호</th>
				<td>${board.id }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${board.name }</td>
			</tr>
			<tr>
				<th>제목</th>
				<td><input type="text" name="title" required="required" value="${board.title }"></td>
			</tr>
			<tr>
				<th>내용</th>
				<td><input type="text" name="content" required="required" value="${board.content }"></td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="확인">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>