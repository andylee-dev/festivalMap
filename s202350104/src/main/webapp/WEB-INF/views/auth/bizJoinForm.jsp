<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>biz Join Form</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>biz회원 Join Form</h1>
	<div class="container border p-5">
		<form action="insertUser">
			<input type="hidden" name="status" value="3">
			아이디 <input type="text" name="id" placeholder="아이디를 입력하세요"><p>
			비밀번호 <input type="password" name="password" placeholder="비밀번호를 입력하세요"><p>
			비밀번호 확인 <input type="password" placeholder="비밀번호를 다시 한 번 입력하세요"><p>
			이름 <input type="text" name="name"><p>
			닉네임 <input type="text" name="nickname"><p>
			성별 <input type="radio" name="gender" value="0">남자
				<input type="radio" name="gender" value="1">여자<p>
			생년월일 <input type="date" name="birthday"><p>
			전화번호 <input type="tel" name="phone_num" placeholder="010 - 0000 - 0000"
					pattern="\d{3}-\d{4}-d{4}"><p>
			이메일 <input type="email" name="email"><p> <!-- 이메일 도메인 주소를 select할 수 있도록 바꾸기 -->
			주소 <!-- 우편번호 검색 api 및 기본주소 자동입력 -->
				<input type="text" name="address"><p>
			관심사 <select name="tags_id"> <!-- 컬럼 이름 바꿔야 함! -->
					<c:forEach var="tag" items="${listTags}"> <!-- UserService에서 TagsDaoImpl로 값 받아와야 함 -->
						<option value="${tag.id}">${tag.content}</option>
					</c:forEach>
				</select><p>
				<!-- 선택한 관심사를 박스 안에서 보여주고 삭제할 수 있는 기능 -->
			<button type="submit">회원가입</button>
			<button type="reset">초기화</button>
		</form>
	</div>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>