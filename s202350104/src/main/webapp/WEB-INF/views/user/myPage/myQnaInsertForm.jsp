<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		<div class="d-flex">
			<%@ include file="/WEB-INF/components/MyPageSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">1:1문의 상세내역</h1>
				</div>
				<div class="container border p-4 mb-4">
					<c:if test="${msg != null}">${msg}</c:if>
						<form action="insertQnaResult" method="post">
							제목 <input type="text" name="question_title"><br>
							내용 <input type="text" name="question_content"><br>
						   	   <input type="submit" value="등록">
						</form>
				</div>
				<div class="text-center">
					<input type="button" value="목록" onclick="location.href='qnaList'">
				</div>
			</main>
		</div>
		</div>
		</div>
	</body>
</html>