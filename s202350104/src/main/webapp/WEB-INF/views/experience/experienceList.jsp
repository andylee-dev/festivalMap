<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험정보2211</title>
</head>
<body>
	 <%@ include file="/WEB-INF/components/TobBar.jsp" %>
	 <h1>체험정보</h1>
	 <table>
	 	<tr><th>체험이름</th></tr>
	 	<c:forEach var="experience" items="${listExperience}">
	 		<tr><td>${experience.title }</td></tr>
	 	</c:forEach>
	 </table>
</body>
</html>