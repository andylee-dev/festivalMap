<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function closeWindow() {
    window.close();
}

</script>
</head>
<body><h1>대충 만든 리포트 폼</h1>	
		<c:if test="${userId == 0}">
			<tr>
				<td>로그인 후 신고 가능합니다 </td>
			</tr>
			<tr>
				<td><button class="btn btn-secondary" onclick="closeWindow()">취소</button></td>
			</tr>
		</c:if>
		<c:if test="${userId != 0 }">
		<form action="boardReportUpdate">
			<table class="table">
			<tr>
				<th scope="col">제목</th>
				<td>${board.title }</td>
			<tr><th>Board_id</th><td>
			<input type="hidden" name="board_id" value="${board.id }">${board.id }</td></tr>
			<tr><th>작성자</th><td>
			<input type="hidden" name="user_id" value="${board.user_id }">${board.name }</td></tr>
			<tr><th>신고인</th><td>
			<input type="hidden" name="id" value="${userId }">${userId }</td></tr>	
			<tr><th>내용</th><td>${board.content }</td><tr>
			<tr><th>신고내용</th><td>
			<input type="text" name="content" placeholder="신고내용을 입력하세요"></td></tr>
			<tr><td>
			<button type="submit" class="btn btn-outline-secondary" >신고</button>
			<button class="btn btn-secondary" onclick="closeWindow()">취소</button>
			</td><tr>
		</table>
		</form>
		</c:if>
</body>
</html>