<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>숙박 상세</title>
	</head>
<body>
	 <%@ include file="/WEB-INF/components/TobBar.jsp" %>
	 
	 <h1>숙박 상세</h1>
	 <div class="container border p-5">
	 <img alt="${accomodations.title}이미지1" src="${accomodations.img1}">
	 </div>
	 <div class="container border p-5">
			<img alt="${accomodations.title}이미지2" src="${accomodations.img2}">
	 </div>
	 <div class="container border p-5">
		
	 	 <ul>
	 	 		<li>상호명 : ${accomodations.title}
	 	 		<li>개요 : ${accomodations.content}
	 	 		<li>주소 : ${accomodations.address}
	 	 		<li>우편번호 : ${accomodations.postcode}
	 	 		<li>전화번호 : ${accomodations.phone}
	 	 		<li>홈페이지 : <a href="${accomodations.homepage}">${Accomodations.homepage }</a>
				<li>객실수 : ${accomodations.room_count}
				<li>예약처 : ${accomodations.reservation_url}
				<li>환불규정 : ${accomodations.refund}
				<li>입실시간 : ${accomodations.check_in}
				<li>퇴실시간 : ${accomodations.check_out}
				<li>픽업가능 : ${accomodations.is_pickup}
				<li>조리가능 : 
					<c:choose>
						<c:when test="${accomodations.is_cook == 0}">N</c:when>
						<c:when test="${accomodations.is_cook == 1}">Y</c:when>
					</c:choose>
				<li>주차시설 :
					<c:choose>
						<c:when test="${accomodations.is_parking == 0}">N</c:when>
						<c:when test="${accomodations.is_parking == 1}">Y</c:when>
					</c:choose>
	 	 </ul>
		</div>
		
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>