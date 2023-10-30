<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>join</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>

	<h1>일반 join or biz join 선택</h1>
	<div class="container border p-5">
		<a href="joinForm"><img alt="일반회원이미지" 
			src="http://tong.visitkorea.or.kr/cms/resource/62/2987562_image3_1.png"></a>
		일반회원<p>만 14세 이상의 내국인<p>
	</div>
	<div class="container border p-5">
		<a href="bizJoinForm"><img alt="비즈니스회원이미지" 
			src="http://tong.visitkorea.or.kr/cms/resource/65/2952965_image3_1.jpg"></a>
		비즈니스회원<p>개인/단체 비즈니스 회원<p>
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>