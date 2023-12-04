<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>	
		<div class="d-flex">
		<%@ include file="/WEB-INF/components/MyPageSideBar.jsp" %>
			<div class="container border p-5">
				<div class="container my-5">	
			
				<!-- Section1: Title -->
				<h1>1:1 문의 등록</h1>
				<hr class="hr" />
					<c:if test="${msg != null}">${msg}</c:if>
						<form action="insertQnaResult" method="post">
						<div class="mb-3 ">
							<label for="content_id" class="form-label">제목:</label>
							<input type="text" class="form-control" name="question_title" required >
							
						</div>	
						<div class="mb-3 ">
							 <label for="content_id" class="form-label">내용:</label>
						 	<textarea class="form-control" name="question_content" rows="5" required></textarea>
						</div>
						<div class="text-center">
							<input class="btn btn-primary" type="submit" value="등록">
							<input class="btn btn-primary" type="button" value="목록" onclick="location.href='qnaList'">
						</div>
					</form>
				</div>
			</div>
		</div>
	</main>
	</body>
</html>