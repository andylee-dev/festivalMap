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
	<h1>회원 포인트 내역</h1>
		<div class="border p-3 m-3">
					<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">회원ID</th>
							<th scope="col">포인트번호</th>
							<th scope="col">포인트생성일</th>
							<th scope="col">포인트삭제</th>
						</tr>	
					</thead>
		<c:forEach var="pointhistory" items="${listPointHistory}">
		<tr>
		<td>${pointhistory.user_id }</td>
		<td>${pointhistory.point_id }</td>
		<td>${pointhistory.created_at }</td>
		<td><button onclick="pointhistorydelete">삭제</button></td>
						
		</tr>
		</c:forEach>
	</table>
	</div>


</body>
</html>