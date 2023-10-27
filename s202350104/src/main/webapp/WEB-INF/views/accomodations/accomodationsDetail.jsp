<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	 	<table>
		<tr><th>컨텐츠아이디</th><th>객실수</th><th>예약처</th><th>환불규정</th><th>입실시간</th><th>퇴실시간</th><th>픽업가능</th><th>조리가능</th><th>주차시설</th></tr>
		<c:forEach var="Accomodations" items="${listAccomodations}">
			<tr><td>${accomodations.content_id }</td><td>${accmodaitons.room_count }</td>
				<td>${accomodations.reservation_url }</td><td>${accomodations.refund }</td>
				<td>${accomodations.check_in }</td><td>${accomodations.check_out }</td>
				<td>${accomodations.is_pickup }</td><td>${accomodations.is_cook }</td>
				<td>${accomodations.is_parking }</tr>
		</c:forEach>
	</table>
</body>
</html>