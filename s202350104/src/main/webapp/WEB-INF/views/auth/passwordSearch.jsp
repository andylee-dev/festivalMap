<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>비밀번호 찾기</title>		
		<style type="text/css">
			h1{
				color: #000;
				font-family: Noto Sans;
				font-size: 36px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				letter-spacing: -0.72px;
			}		
			.form-label{
				color: #000;
				font-family: Noto Sans;
				font-size: 20px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				letter-spacing: -0.72px;
			}
			.search-text{
					color: rgba(0, 0, 0, 0.60);
					font-family: Noto Sans;
					font-size: 16px;
					font-style: normal;
					font-weight: 600;
					line-height: normal;
			}
			.member-yet{
				color: rgba(0, 0, 0, 0.60);
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 500;
				line-height: normal;
				letter-spacing: -0.48px;						
			}
			#link-join{
				color: #FF4379;
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				letter-spacing: -0.48px;
			}
			.border{
				border-radius: 10px;
				border: 1px solid #000;
			}		
		</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main class=" m-5 p-5" >
		<div class="container col-4 justify-content-start border mt-3 p-5">
			<form action="/passwordSearchResult" method="post">
				<div class="mt-5 mb-5">
					<div class="justify-content-center pt-3 pb-3" align="center">
						<h1>비밀번호 찾기</h1>	
					</div>
					<div class="justify-content-center pb-1" align="center">
						<p>입력하신 내용이 회원정보와 일치하면 <br>
						      이메일로 임시 비밀번호를 발급받으실 수 있습니다.</p>
					</div>
					<hr>
					<div class="justify-content-start pb-3">
						<label for="name" class="form-label mb-2">이름</label>
						<input type="text" class="form-control" name="name" required>
					</div>
					<div class="justify-content-start pb-3">
						<label for="email" class="form-label mb-2">이메일</label>
						<input type="text" class="form-control" name="email"
						 placeholder="festimap@festimap.com" required>
					</div>
					<div class="justify-content-center pt-3 pb-3" align="center">
						<button type="submit" class="btn btn-primary">다음</button>
					</div>
				</div>
			</form>
		</div>
	</main>	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>