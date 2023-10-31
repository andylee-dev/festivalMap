<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>숙박상세</title>
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
	 <%@ include file="/WEB-INF/components/TobBar.jsp" %>
	 <h1>숙박상세</h1>
	 <div class="container border p-5">
	 	 <table>
				<tr><th>객실수</th><td>${Accomodations.room_count }</td>
				<th>예약처</th><td>${Accomodations.reservation_url }</td>
				<th>환불규정</th><td>${Accomodations.refund }</td>
				<th>입실시간</th><td>${Accomodations.check_in }</td>
				<th>퇴실시간</th><td>${Accomodations.check_out }</td>
				<th>픽업가능</th><td>${Accomodations.is_pickup }</td>
				<th>조리가능</th><td>${Accomodations.is_cook }</td>
				<th>주차시설</th><td>${Accomodations.is_parking }</td></tr>
		
	</table>
	</div>
</body>
</html>