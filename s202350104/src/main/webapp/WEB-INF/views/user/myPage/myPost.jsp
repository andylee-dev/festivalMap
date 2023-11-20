<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main>
		<div class="d-flex">
			<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			<div class="container border p-5">
				<div class="container my-5">
					<h1>내 게시글 관리</h1>
					<hr class="hr" />
				<c:forEach var="freeBoard" items="${freeAllList }">
					<p>${freeBoard.title }</p>
				
				</c:forEach>
				</div>
				</div>
				</div>
				</main>
</body>
</html>