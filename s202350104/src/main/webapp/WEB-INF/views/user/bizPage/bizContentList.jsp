<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main>
	<div class="d-flex">
		<%@ include file="/WEB-INF/components/BizPageSideBar.jsp" %>
		
		<div id="content_title" class="container border p-5">
			<h1>제목입니다.</h1>
			<div class="container border p-5">
				<h2>부제목입니다.</h2>
				<a href="/user/bizPage/addContent" >등록하기</a>
			</div>
		</div>
	</div>
	</main>
</body>
</html>