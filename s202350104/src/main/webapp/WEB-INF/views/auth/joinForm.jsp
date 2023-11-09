<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		<link href="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/css/bootstrap.min.css" rel="stylesheet" />
 	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5/dist/js/bootstrap.bundle.min.js" type="module"></script>

		<style>
		  .form-control-focus {
		  color: #212529;
		  background-color: #fff;
		  border-color: #86b7fe;
		  outline: 0;
		  box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.25);
		}
		
		.was-validated :valid + .form-control-focus {
		  border-color: #198754;
		  box-shadow: 0 0 0 0.25rem rgba(25, 135, 84, 0.25);
		}
		
		.was-validated :invalid + .form-control-focus {
		  border-color: #dc3545;
		  box-shadow: 0 0 0 0.25rem rgba(220, 53, 69, 0.25);
		}
		</style>
		
		<script type="module">
   			import Tags from "https://cdn.jsdelivr.net/gh/lekoala/bootstrap5-tags@master/tags.js";
    		Tags.init("select");
 		</script>
	</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>일반회원 회원가입</h1>
	<div class="container border p-5">
		<form action="/signUp" method="post">
			<input type="hidden" name="status" value="1">
			<input type="hidden" name="big_code" value="1">
			<input type="hidden" name="small_code" value="2">
			<input type="hidden" name="point" value="0">
			<input type="hidden" name="file_name" value="">
			아이디 <input type="text" name="id" placeholder="아이디를 입력하세요"><p>
			비밀번호 <input type="password" name="password" placeholder="비밀번호를 입력하세요"><p>
			비밀번호 확인 <input type="password" placeholder="비밀번호를 다시 한 번 입력하세요"><p>
			이름 <input type="text" name="name"><p>
			닉네임 <input type="text" name="nickname"><p>
			성별 <input type="radio" name="gender" value="0">남자
				<input type="radio" name="gender" value="1">여자<p>
			생년월일 <input type="date" name="birthday"><p>
			전화번호 <input type="tel" name="phone_num" placeholder="010 - 0000 - 0000"
					pattern="\d{2,3}-\d{3,4}-\d{4}"><p>
			이메일 <input type="email" name="email"><p> <!-- 이메일 도메인 주소를 select할 수 있도록 바꾸기 -->
			주소 <!-- 우편번호 검색 api 및 기본주소 자동입력 -->
				<input type="text" name="address"><p>
			관심사
			 <div class="container">
				<div class="row mb-3 g-3">
      			  <div class="col-md-4">
         			 <select class="form-select" id="validationTagsClear" name="tagsClear[]" multiple data-allow-clear="true">
            			<option selected disabled hidden value="">태그를 선택해주세요.</option>
			            <c:forEach var="tag" items="${listTags}">
			            	<option value="${tag.id}" data-badge-style="primary">${tag.name}</option>
			            </c:forEach>
			          </select>
			          <div class="invalid-feedback">유효한 태그를 선택해주세요.</div>
			        </div>
			      </div>
  			</div>
			<button type="submit" class="btn btn-primary">회원가입</button>
			<button type="reset" class="btn btn-light">초기화</button>
		</form>
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>