<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>SpotDetail</title>
	</head>
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		
		<h1>Spot Detail</h1>
		<div class="container border p-5">
		<img alt="${spot.title}이미지1" src="${spot.img1}">
		</div>
		<div class="container border p-5">
			<img alt="${soit.title}이미지2" src="${spot.img2}">
		</div>
		<div class="container border p-5">
			
			<ul>
				<li>명소명 : ${spot.title}
				<li>개요 : ${spot.content}
				<li>영업시간 : ${spot.hours}
				<li>입장료 : ${spot.entrance_fee}
				<li>휴무일: ${spot.rest_date}
				<li>우편번호 : ${spot.postcode}
				<li>주소 : ${spot.address}
				<li>문의전화 : ${spot.phone}
				<li>홈페이지 : <a href="${spot.homepage}">${spot.homepage}</a>
				<li>주차시설 : 
					<c:choose>
						<c:when test="${spot.is_parking == 0}">N</c:when>
						<c:when test="${spot.is_parking == 1}">Y</c:when>
					</c:choose>
				<li>유모차대여 : 
					<c:choose>
						<c:when test="${spot.is_stroller == 0}">N</c:when>
						<c:when test="${spot.is_stroller == 1}">Y</c:when>
					</c:choose>
				<li>휠체어대여 : 
					<c:choose>
						<c:when test="${spot.is_wheelchair == 0}">N</c:when>
						<c:when test="${spot.is_wheelchair == 1}">Y</c:when>
					</c:choose>
				<li>장애인화장실 : 
					<c:choose>
						<c:when test="${spot.is_restroom == 0}">N</c:when>
						<c:when test="${spot.is_restroom == 1}">Y</c:when>
					</c:choose>
				<li>반려동물동반 : 
					<c:choose>
						<c:when test="${spot.is_pet == 0}">N</c:when>
						<c:when test="${spot.is_pet == 1}">Y</c:when>
					</c:choose>
				<li>엘리베이터 : 
					<c:choose>
						<c:when test="${spot.is_elevator == 0}">N</c:when>
						<c:when test="${spot.is_elevator == 1}">Y</c:when>
					</c:choose>	
			</ul>
		</div>
		
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
	</body>
</html>