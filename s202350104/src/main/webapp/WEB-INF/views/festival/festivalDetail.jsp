<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FestivalDetail</title>
	</head>
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		
		<h1>Festival Detail</h1>
		<div class="container border p-5">
			<img alt="${festival.title}이미지1" src="${festival.img1}">
		</div>
		<div class="container border p-5">
			<img alt="${festival.title}이미지2" src="${festival.img2}">
		</div>
		<div class="container border p-5">
			<ul>
				<li>축제명 : ${festival.title}
				<li>개요 : ${festival.content}
				<li>축제기간 : ${festival.start_date} ~ ${festival.end_date}
				<li>축제시간 : ${festival.hours}
				<li>요금 : ${festival.cost}
				<li>장소 : ${festival.eventplace}
				<li>우편번호 : ${festival.postcode}
				<li>주소 : ${festival.address}
				<li>주최자 : ${festival.sponsor}
				<li>문의전화 : ${festival.phone}
				<li>홈페이지 : <a href="${festival.homepage}">${festival.homepage}</a>
				<li>행사내용 : ${festival.overview}
				<li>주차시설 : 
					<c:choose>
						<c:when test="${festival.is_parking == 0}">N</c:when>
						<c:when test="${festival.is_parking == 1}">Y</c:when>
					</c:choose>
				<li>유모차대여 : 
					<c:choose>
						<c:when test="${festival.is_stroller == 0}">N</c:when>
						<c:when test="${festival.is_stroller == 1}">Y</c:when>
					</c:choose>
				<li>휠체어대여 : 
					<c:choose>
						<c:when test="${festival.is_wheelchair == 0}">N</c:when>
						<c:when test="${festival.is_wheelchair == 1}">Y</c:when>
					</c:choose>
				<li>장애인화장실 : 
					<c:choose>
						<c:when test="${festival.is_restroom == 0}">N</c:when>
						<c:when test="${festival.is_restroom == 1}">Y</c:when>
					</c:choose>
			</ul>
		</div>
		
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
	</body>
</html>