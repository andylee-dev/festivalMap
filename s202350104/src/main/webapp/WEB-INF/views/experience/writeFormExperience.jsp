<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>체험 등록 page</h1>
	<form action="writeExperience" method="post" name="frm" >
	<table>
		<tr><th>체험이름</th><td><input type="text" name="title" required="required"></td></tr>
		<tr><th>개요</th><td><input type="text" name="content" required="required"></td></tr>
		<tr><th>주소</th><td><input type="text" name="address" required="required"></td></tr>
		<tr><th>우편번호</th><td><input type="number" name="postcode"></td></tr>
		<tr><th>email</th><td><input type="email" name="email"></td></tr>
		<tr><th>전화번호</th><td><input type="number" name="phone" required="required"></td></tr>
		<tr><th>홈페이지</th><td><input type="text" name="homepage"></td></tr>
		
		
	
	
	
	</table>
	
	
	
	
	</form>

</body>
</html>