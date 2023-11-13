<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login</title>
		  <!-- 카카오 sdk 추가 -->
        <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
        <script>
            // 카카오 sdk 초기화
            Kakao.init('3d40db7fe264068aa3438b9a0b8b2274');

            function loginWithKakao() {
                // 로그인 창을 띄웁니다.
                Kakao.Auth.login({
                    success: function(authObj) {
                        alert(JSON.stringify(authObj));
                    },
                    fail: function(err) {
                        alert(JSON.stringify(err));
                    }
                });
            }
        </script>
	</head>
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		
		<div align="center">
			<h1>로 그 인</h1>
			<div class="container border p-5">
				<form action="/auth" method="post">
					아이디 <input type="text" name="username"><p>
					비밀번호 <input type="password" name="password"><p>
					<a href="idSearch">아이디 찾기</a> / <a href="passwordSearch">비밀번호 찾기</a><p>
					아직 회원이 아니세요? <a href="join">회원가입 하기</a><p>
					<input type="submit" value="로그인" class="btn btn-primary">
				</form>
				<!-- 카카오 로그인 버튼 추가 -->
                <button onclick="loginWithKakao()">카카오 로그인</button>
			</div>
		</div>
	
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
	</body>
</html>