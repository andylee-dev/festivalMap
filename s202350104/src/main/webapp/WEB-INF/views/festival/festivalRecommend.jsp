<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalRecommed</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function getRecommendations() {
		console.log("getRecommendations() start!")
		$.ajax({
			url: "<%=request.getContextPath()%>/recommendations",
			method: "GET",
			dataType: "json",
			success: function(recommendations) {
				console.log("getRecommendations() success ->"+recommendations)
			},
			error: function() {
				console.log("getRecommendations() failed")
			}
		})	
	}
</script>
</head>
<body>
	<!-- top bar에 컨텐츠가 숨겨지는 것 방지 -->
	<div class="container" style="height: 90px;"></div>

	<h1>Festival Recommend</h1>
			
	<button type="button" class="btn btn-primary" onclick="getRecommendations()">추천</button>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>	
</body>
</html>