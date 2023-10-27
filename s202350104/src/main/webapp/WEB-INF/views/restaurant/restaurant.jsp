<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>		
	<table>
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
	 	<c:forEach var="rs" items="${listRestaurant}">
	 		<tr>
	 			<td>${num}</td>
	 			<td>${rs.content_id}</td>
	 			<td>${rs.first_menu}</td>
	 			<td>${rs.menu}</td>
	 			<td>${rs.open_time}</td>
	 			<td>${rs.rest_date}</td>
	 			<td>${rs.is_smoking}</td>
	 			<td>${rs.is_packing}</td>
	 			<td>${rs.is_parking}</td>
	 		</tr>
	 	<c:set var="num" value="${num - 1 }"></c:set>	
	 	</c:forEach>	
	 </table>
	 <c:if test="${page.startPage > page.pageBlock }">
		<a href="listRestaurant?currentPage=${page.startPage-page.pageBlock }">[이전]</a>
	 </c:if>
	 <c:forEach var="i" begin="${page.startPage }" end="${page.endPage }">
		<a href="listRestaurant?currentPage=${i}">[${i}]</a>
	 </c:forEach>	
	 <c:if test="${page.endPage > page.totalPage }">
		<a href="listRestaurant?currentPage=${page.startPage+page.pageBlock }">[다음]</a>
	</c:if>
	
</body>
</html>