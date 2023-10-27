<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalList</title>
<style type="text/css">
	.card-text {
		overflow : hidden;
		/* text-overflow: ellipsis; */
	}
</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>Festival List</h1>
		<c:forEach var="festival" items="${listFestivals}">
			<div class="card" style="width: 18rem;">
  				<img src="${festival.img1}" class="card-img-top" alt="${festival.title}이미지" style="height: 190px;">
  				<div class="card-body">
    				<p class="card-text" style="height: 240px;">
    					축제명 : ${festival.title} <br>
    					축제기간 : ${festival.start_date} ~ ${festival.end_date} <br>
    					${festival.content}
    				</p>
    				<a href="festival/detail?content_id=${festival.content_id}" class="btn btn-primary">더보기</a>
 				 </div>	
			</div>
		</c:forEach>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>