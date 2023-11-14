<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>

	<h1>회원가입</h1>
	<div class="container border justify-content-center p-5">
		<table>
			<tr>
				<td><a href="/signUp/user">
				<img src="/asset/registerUser.svg" alt="일반회원이미지">
				</a><p>
					일반회원<p>만 14세 이상의 내국인<p></td>
				<td><a href="/signUp/biz">
				<img src="/asset/registerBizUser.svg" alt="비즈회원이미지">
					
					</a><p>
					비즈니스회원<p>개인/단체 비즈니스 회원<p></td>
			</tr>
		</table>
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>