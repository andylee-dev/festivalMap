<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
h1 {
	color: black;
	font-size: 28px;
	font-family: Noto Sans;
	font-weight: 600;
	word-wrap: break-word
}

a {
	color: white;
	font-size: 15px;
	font-family: Noto Sans;
	font-weight: 600;
	line-height: 18px;
	word-wrap: break-word
}

.card {
	border: none;
	display: inline-block; /* 또는 display: inline-flex; */
}

.card-body {
	padding: 0px;
	margin-top: 10px;
}

main {
	min-height: 75vh;
}

#do-login{
	color: #FF4379;
	text-align: center;
	font-family: Noto Sans;
	font-size: 16px;
	font-style: normal;
	font-weight: 600;
	line-height: normal;
	letter-spacing: -0.48px;
}

#do-login-hint{
	color: rgba(0, 0, 0, 0.60);
	
	font-family: Noto Sans;
	font-size: 16px;
	font-style: normal;
	font-weight: 500;
	line-height: normal;
	letter-spacing: -0.48px;
}

</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main class="d-flex justify-content-center">
		<div class="col-4 justify-content-center">
			<div id="card-container" class="d-flex justify-content-around">
				<div class="card mx-3 mt-5 p-5 pb-3 col-4">
					<img src="/asset/registerUser.svg" class="card-img-top" alt="...">
					<div class="card-body  text-center">
						<h1>일반회원</h1>
						<a href="/signUp/user" " class="btn btn-primary">가입하기</a>
					</div>
				</div>
				<div class="card mx-3 mt-5 p-5 pb-3 col-4 ">
					<img src="/asset/registerBizUser.svg" class="card-img-top" alt="...">
					<div class="card-body text-center">
						<h1>비즈회원</h1>
						<a href="/signUp/biz" class="btn btn-primary">가입하기</a>
					</div>
				</div>
			</div >
			<hr> <!-- card-container 바로 아래에 수평선 추가 -->
			<div class="container d-flex justify-content-end">
				<span id="do-login-hint" class="mx-3">이미 페스티맵 회원이라면</span>
				<a id="do-login" class="text-decoration-none" href="/login" >로그인하기</a>
			</div>
		</div>
	</main>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>