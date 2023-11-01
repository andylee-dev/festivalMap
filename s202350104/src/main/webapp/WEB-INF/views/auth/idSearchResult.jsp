<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID Search Result</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<div align="center">
		<h1>아 이 디  찾 기</h1>
		<div class="container border p-5">
			<p>입력하신 내용과 일치하는 회원의 아이디는 다음과 같습니다.</p>
			<p><!-- 일치하는 아이디가 표시될 자리 --></p>
			<button onclick="location.href='login'" class="btn btn-primary">로그인</button>
		</div>
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>