<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트등록</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
    <h1>포인트 등록</h1>
    <div class="border p-3 m-3">
       <form action="writePoint" method="post">
  		<label for="title">포인트 제목:</label><br>
  	    	<input type="text" id="title" name="title"><br>
 		 <label for="content">포인트 내용:</label><br>
  			<textarea id="content" name="content"></textarea><br>
 		 <label for="point">포인트 점수:</label><br>
  			<input type="text" id="point" name="point"><br><br>
  		<input type="submit" value="등록">
		</form>
    </div>
</body>
</html>
