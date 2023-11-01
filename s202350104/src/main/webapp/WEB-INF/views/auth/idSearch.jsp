<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID search</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<div align="center">
		<h1>아 이 디  찾 기</h1>
		<div class="container border p-5">
			<p>입력하신 내용이 회원정보와 일치하면 해당하는 아이디를 확인하실 수 있습니다.</p>
			<form action="idSearchResult">
				아이디<p><input type="text" name="name" required="required"><p>
				이메일<p><input type="text" name="email" required="required"><p>
				<input type="submit" value="다음" class="btn btn-primary">
			</form>
		</div>
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>