<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>login</title>
		<style type="text/css">
			h1{
				color: #000;
				font-family: Noto Sans;
				font-size: 24px;
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
		</style>
					
		  <!-- 카카오 sdk 추가 -->
        <script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
        <script>
            // 카카오 sdk 초기화
            Kakao.init('1100bcfd9fdffe4494895e126275157a');

            function loginWithKakao() {
                // 로그인 창을 띄웁니다.
                Kakao.Auth.login({
                    success: function(authObj) {
                        alert(JSON.stringify(authObj));
                    },
                    fail: function(err) {
                        alert(JSON.stringify(err));
                    },
                    redirectUri: 'http://localhost:8189/app/login/kakao'
                });
            }
        </script>
	</head>
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp" %>
		<main class=" m-5 p-5" >
			<div class="container col-4 justify-content-start ">
				<form action="/auth" method="post">
					<div class="mt-5 mb-5">
						<div class="justify-content-start pt-5 pb-3">
							<label for="username" class="form-label mb-2">이메일</label>
							<input type="email" class="form-control" name="username"
								placeholder="festimap@festimap.com">						
						</div>
						<div class="justify-content-start pb-3">
							<label for="password" class="form-label mb-2">비밀번호</label>
							<input type="password" class="form-control" name="password"><p>
						</div>
						<input type="submit" value="로그인" class="btn btn-primary form-control">						
						<div class="form-check form-switch my-4">
							<input class="form-check-input" type="checkbox" id="stayLogin">
							<label class="form-check-label" for="stayLogin">로그인 상태 유지</label>
						</div>
						<hr>
						<div class="d-flex justify-content-between">
							<div>
								<a class="search-text" href="idSearch">아이디 찾기</a> |
								<a class="search-text" href="passwordSearch">비밀번호 찾기</a>							
							</div>
							<div class="go-login">
								<span class="member-yet">아직 회원이 아니세요? <a id="link-join" href="join">회원가입 하기</a></span>					
							</div>						
						</div>
					</div>		
				</form>
	<!--<button onclick="loginWithKakao()">카카오 로그인</button> -->
			</div>
		</main>

	
		<!-- Footer -->
		<%@ include file="/WEB-INF/components/Footer.jsp" %>
	</body>
</html>