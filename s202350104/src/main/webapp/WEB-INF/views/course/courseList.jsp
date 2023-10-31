<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Course List</title>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<h1>여기는 코스 입니다.</h1>
	<h2>코스 수 : ${courseCount }</h2>
	
	<c:forEach var="course" items="${CourseList }">
		<div class="card" style="width: 18em;">
			<img src="" alt="" /> 
			<div class="card-body">
				<h5 class="card-title">코스이름 : ${course.course_title }</h5>
				<p class="card-text">코스 제목 : ${course.course_info }</p>
				<a href="#" class="btn btn-primary">상세보기</a>
			</div>
		</div>
	</c:forEach>
	
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>