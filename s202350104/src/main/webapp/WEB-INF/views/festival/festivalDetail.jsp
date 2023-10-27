<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>FestivalDetail</title>
	</head>
	<body>
		<h1>Festival Detail</h1>
		
		<table>
			<tr><th>아이디</th><th>축제시간</th><th>축제기간</th><th>주최자</th><th>행사장소</th></tr>
			<c:forEach var="festival" items="${listFestivals}">
				<tr>
					<td>${festival.content_id}</td>
					<td>${festival.hours}</td>
					<td>${festival.start_date} ~ ${festival.end_date}</td>
					<td>${festival.sponsor}</td>
					<td>${festival.eventplace}</td>
				</tr>
			</c:forEach>
		</table>
	</body>
</html>