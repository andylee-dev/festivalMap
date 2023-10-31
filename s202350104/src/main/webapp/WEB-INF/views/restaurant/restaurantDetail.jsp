<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ include file="/WEB-INF/components/header.jsp" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>RestaurantDetail</title>
	</head>
	<body>
		 <!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		
		<h1>Restaurant Detail</h1>
		<div class="container border p-5">
			<img alt="${restaurant.title}이미지1" src="${restaurant.img1}">
		</div>
		<div class="container border p-5">
			<img alt="${restaurant.title}이미지2" src="${restaurant.img2}">
		</div>
		<div class="container border p-5">
			<img alt="${restaurant.title}이미지3" src="${restaurant.img3}">
		</div>
		<div class="container border p-5">	
			<ul>
				<li>음식점명: ${restaurant.title}
				<li>내용: ${restaurant.content}
				<li>주소: ${restaurant.address}
				<li>메뉴: ${restaurant.menu}
				<li>운영시간: ${restaurant.open_time}
				<li>휴무일: ${restaurant.rest_date}
				<li>흡연:
					<c:choose>
						<c:when test="${restaurant.is_smoking == 0}">N</c:when>
						<c:when test="${restaurant.is_smoking == 1}">Y</c:when>
					</c:choose>
				<li>포장:
					<c:choose>
						<c:when test="${restaurant.is_packing == 0}">N</c:when>
						<c:when test="${restaurant.is_packing == 1}">Y</c:when>
					</c:choose>
				<li>주차:
					<c:choose>
						<c:when test="${restaurant.is_parking == 0}">N</c:when>
						<c:when test="${restaurant.is_parking == 1}">Y</c:when>
						</c:choose>
			 </ul>
		 </div>	
		
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
	</body>
</html>