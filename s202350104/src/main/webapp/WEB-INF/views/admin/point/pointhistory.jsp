<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원포인트내역</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<div style="overflow-y: auto; max-height: 80vh;">
	<h1>회원 포인트 내역</h1>
		<div class="border p-3 m-3">
				<button type="button" class="btn btn-outline-secondary" 
				onclick="location.href='writeFormPointHistory'">등록</button>
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
		<td><a href="/admin/point/deletePointHistory?point_id=${pointhistory.point_id}">삭제</a></td>
						
		</tr>
		</c:forEach>
	</table>
	</div>
	</div>
	</main>
	</div>
	</div>
	


</body>
</html>