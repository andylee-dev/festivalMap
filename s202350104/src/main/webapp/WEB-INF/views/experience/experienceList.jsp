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
	 		<c:forEach var="experience" items="${listExperience}">
			<div class="card" style="width: 18rem;">
  				<img src="${experience.img1}" class="card-img-top" alt="${experience.title}이미지" style="height: 190px;">
  				<div class="card-body">
    				<p class="card-text" style="height: 240px;">
    					축제명 : ${experience.title} <br>
    					${experience.content}
    				</p>
    				<a href="experience/detail?content_id=${experience.id}" class="btn btn-primary">더보기</a>
 				 </div>	
			</div>
		</c:forEach>

</body>
</html>