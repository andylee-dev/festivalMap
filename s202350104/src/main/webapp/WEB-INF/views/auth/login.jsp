<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login</title>
	</head>
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		
		<div align="center">
			<h1>로 그 인</h1>
			<div class="container border p-5">
				<form action="/auth" method="post">
					아이디 <input type="text" name="username"><p>
					비밀번호 <input type="password" name="password"><p>
					<a href="idSearch">아이디 찾기</a> / <a href="passwordSearch">비밀번호 찾기</a><p>
					아직 회원이 아니세요? <a href="join">회원가입 하기</a><p>
					<input type="submit" value="로그인" class="btn btn-primary">
				</form>
			</div>
		</div>
	
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
	</body>
</html>