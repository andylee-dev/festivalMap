<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Restaurant Index</title>
    <link
      href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
      rel="stylesheet"
      integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
      crossorigin="anonymous"
    />
    <script
      src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
      integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
      crossorigin="anonymous"
    ></script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>

	<div id="content_title" class="container border p-5">
		<h1>Restaurant List</h1>
	</div>
		
	<div class="container border p-5">			
		<table border="1">
	 		<tr>
		 		<th>콘텐츠_id</th>
		 		<th>추천메뉴</th>
		 		<th>메뉴</th>
		 		<th>영업시간</th>
		 		<th>휴무일</th>
		 		<th>금연가능유무</th>
		 		<th>포장가능유무</th>
		 		<th>주차가능유무</th>
		 	</tr>
		 	<c:forEach var="restaurant" items="${listRestaurant}">
		 		<tr>
		 			<td>${restaurant.content_id}</td>
		 			<td>${restaurant.first_menu}</td>
		 			<td>${restaurant.menu}</td>
		 			<td>${restaurant.open_time}</td>
		 			<td>${restaurant.rest_date}</td>
		 			<td>${restaurant.is_smoking}</td>
		 			<td>${restaurant.is_packing}</td>
		 			<td>${restaurant.is_parking}</td>
		 		</tr>
	 	 	</c:forEach>
	 	 </table>			
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>	
		
</body>
</html>