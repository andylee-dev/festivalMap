<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>password Search Result</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<div align="center">
		<h1>비 밀 번 호  찾 기</h1>
		<div class="container border p-5">
			<p>입력하신 이메일로 임시 비밀번호가 발급되었습니다.<br>로그인 후 비밀번호를 재설정해주세요.</p>
			<button onclick="location.href='login'" class="btn btn-primary">로그인</button>
		</div>
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>