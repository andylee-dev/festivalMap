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
	 <img alt="${accomodation.title}이미지1" src="${accomodation.img1}">
	 </div>
	 <div class="container border p-5">
			<img alt="${accomodation.title}이미지2" src="${accomodation.img2}">
	 </div>
	 <div class="container border p-5">
		
	 	 <ul>
	 	 		<li>상호명 : ${accomodation.title}
	 	 		<li>개요 : ${accomodation.content}
	 	 		<li>주소 : ${accomodation.address}
	 	 		<li>우편번호 : ${accomodation.postcode}
	 	 		<li>전화번호 : ${accomodation.phone}
	 	 		<li>홈페이지 : <a href="${accomodation.homepage}">${accomodation.homepage}</a>
				<li>객실수 : ${accomodation.room_count}
				<li>예약처 : <a href="${accomodation.reservation_url}">${accomodation.reservation_url}</a>
				<li>환불규정 : ${accomodation.refund}
				<li>입실시간 : ${accomodation.check_in}
				<li>퇴실시간 : ${accomodation.check_out}
				<li>픽업가능 : ${accomodation.is_pickup}
				<li>조리가능 : 
					<c:choose>
						<c:when test="${accomodation.is_cook == 0}">Y</c:when>
						<c:when test="${accomodation.is_cook == 1}">N</c:when>
					</c:choose>
				<li>주차시설 :
					<c:choose>
						<c:when test="${accomodation.is_parking == 0}">Y</c:when>
						<c:when test="${accomodation.is_parking == 1}">N</c:when>
					</c:choose>
	 	 </ul>
		</div>
		
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>