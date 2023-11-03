<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>course UpdateForm</title>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<div>
		<c:forEach var="courseContent" items="${courseContent }">
			<c:if test="${courseContent.order_num == 1}">
				<h1>${courseContent.course_title }</h1>
				<div class="container border p-5">
					<img alt="${courseContent.course_title }" src="${courseContent.img1 }">
				</div>
				<div class="container border p-5">
					<ul>
						<li>코스 이름 : ${courseContent.course_title }
						<li>코스 내용 : ${courseContent.course_info }
						<li>코스 거리 : ${courseContent.distance }
						<li>주 소 :	${courseContent.address }
						<li>전화번호 :	${courseContent.phone }
					</ul>
				</div>
			</c:if>
		</c:forEach>
	</div>
	
	<div>
		<c:forEach var="courseContent" items="${courseContent }">
		<div class="container border p-5">
			<a href='../${courseContent.cd_content.toLowerCase() }/detail?contentId=${courseContent.content_id}'>
				<img alt="${courseContent.course_title }" src="${courseContent.img1 }">
			</a>
			<ul>
				<li>코스이름 : <input type="text" id="title" name="title" value="${courseContent.title }"> 
				<li>개요 : <input type="text" id="content" name="content" value="${courseContent.content }">
				<li>홈페이지 : <input type="text" id="homepage" name="homepage" value="${courseContent.homepage }">
			</ul>
		</div>
		</c:forEach>
	</div>
	<!-- review test -->
	<div>
		<h3>review 구역</h3>
	</div>
</body>
</html>