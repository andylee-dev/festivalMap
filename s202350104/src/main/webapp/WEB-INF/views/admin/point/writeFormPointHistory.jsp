<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트내역등록</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
    <h1>포인트 등록</h1>
    <div class="border p-3 m-3">
       <form action="writePointHistory" method="post">
        <label for="user_id">회원 ID</label><br>
  	    	<input type="text" id="user_id" name="user_id"><br>
  		<label for="point_id">포인트 번호</label><br>
  	    	<input type="text" id="point_id" name="point_id"><br>
 		<input type="submit" value="등록">
		</form>
    </div>
</body>
</html>
