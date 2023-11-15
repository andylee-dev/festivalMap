<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
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
a{
	color: white;
	font-size: 15px;
	font-family: Noto Sans;
	font-weight: 600;
	line-height: 18px;
	word-wrap: break-word
}

.card {
	border: none;
	display: inline-block;  /* 또는 display: inline-flex; */
}
.card-body {
	padding:0px;
	margin-top: 10px;
}
main {
  display: flex;
  min-height: 75vh;
}

</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main class="d-flex justify-content-center align-items-center ">
	<div class="col-4 d-flex justify-content-around">
			<div class="card mx-3 my-5 p-5 col-4">
			  <img src="/asset/registerUser.svg" class="card-img-top" alt="...">
			  <div class="card-body  text-center">
			    <h1>일반회원</h1>
			    <a href="/signUp/user"" class="btn btn-primary">가입하기</a>
			  </div>
			</div>
			<div class="card mx-3 my-5 p-5 col-4 ">
			  <img src="/asset/registerBizUser.svg" class="card-img-top" alt="...">
			  <div class="card-body text-center">
			    <h1>비즈회원</h1>
			    <a href="/signUp/biz"" class="btn btn-primary">가입하기</a>
			  </div>
			</div>
	</div>

	</main>	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>