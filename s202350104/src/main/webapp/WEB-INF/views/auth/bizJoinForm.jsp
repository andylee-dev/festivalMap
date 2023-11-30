<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>회원가입</title>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/js/checkUserDuplicate.js"></script>
	<script src="/js/updateArea.js"></script>
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function () {
	
		    // 년도 옵션 생성
		    const yearSelect = document.getElementById("year");
		    const currentYear = new Date().getFullYear();
		    for (let i = currentYear; i >= currentYear - 100; i--) {
		        const option = document.createElement("option");
		        option.value = i;
		        option.text = i;
		        yearSelect.appendChild(option);
		    }
	
		    // 월 옵션 생성
		    const monthSelect = document.getElementById("month");
		    for (let j = 1; j <= 12; j++) {
		        const option = document.createElement("option");
		        option.value = j;
		        option.text = j;
		        monthSelect.appendChild(option);
		    }
	
		    // 일 옵션 생성
		    const daySelect = document.getElementById("day");
		    for (let k = 1; k <= 31; k++) {
		        const option = document.createElement("option");
		        option.value = k;
		        option.text = k ;
		        daySelect.appendChild(option);
		    }
			
		    <!-- 지역 코드 넣는 코드  Start -->	
			updateAreaOptions();
			$(".area-dropdown").change(function() {
				const selectedArea = $(this).val();
				if (selectedArea) {
					updateSigunguOptions(selectedArea);
				} else {
					$(".sigungu-dropdown").empty().append("<option value='0'>전체</option>");
				}
			<!-- 지역 코드 넣는 코드  End -->
		});
			
		// 선택된 값으로 생년월일 입력 필드 업데이트
		function updateBirthday() {
		    const yearSelect = document.getElementById("year");
		    const monthSelect = document.getElementById("month");
		    const daySelect = document.getElementById("day");

		    
		    const year = yearSelect.value;
			const month = monthSelect.value.padStart(2, '0');
			const day = daySelect.value.padStart(2, '0');
			const birthday = year + month + day;
		    document.getElementById("birthday").value = birthday;
		}

		function checkSubmitHandler(event) {
		    // 필요한 입력 필드 가져오기
		    const email = document.getElementById("email");
		    const pw = document.getElementById("pw");
		    const pw2 = document.getElementById("pw2");
		    const username = document.getElementById("name");
		    const nickname = document.getElementById("nickname");
		    const phone_num = document.getElementById("phone_num");
		    const address = document.getElementById("address");
		    const file_name = document.getElementById("file_name");
		    // 추가 필요한 필드...

		    // 이메일이 제공되었는지 확인
		    if (email.value === "") {
		        alert("이메일을 입력해주세요.");
		        event.preventDefault();
		        return false;
		    }

		    // 패스워드가 제공되었는지 확인
		    if (pw.value === "") {
		        alert("패스워드를 입력해주세요.");
		        event.preventDefault();
		        return false;
		    }
		    // 패스워드 확인이 제공되었는지 확인
		    if (pw2.value === "") {
		        alert("패스워드 확인을 입력해주세요.");
		        event.preventDefault();
		        return false;
		    }

		    // 패스워드와 패스워드 확인이 일치하는지 확인
		    if (pw.value !== pw2.value) {
		        alert("패스워드가 일치하지 않습니다.");
		        event.preventDefault();
		        return false;
		    }

		    // 사용자명이 제공되었는지 확인
		    if (name.value === "") {
		        alert("사용자명을 입력해주세요.");
		        event.preventDefault();
		        return false;
		    }

		    // 닉네임이 제공되었는지 확인
		    if (nickname.value === "") {
		        alert("닉네임을 입력해주세요.");
		        event.preventDefault();
		        return false;
		    }

		    // 핸드폰번호가 제공되었는지 확인
		    if (phone_num.value === "") {
		        alert("핸드폰번호를 입력해주세요.");
		        event.preventDefault();
		        return false;
		    }

		    // 주소가 제공되었는지 확인
		    if (address.value === "") {
		        alert("주소를 입력해주세요.");
		        event.preventDefault();
		        return false;
		    }
		    
		    // 사업자 증빙자료가 제공되었는지 확인
		    if (file_name.value === "") {
		    	alert("사업자 증빙자료를 첨부해주세요.");
		    	event.preventDefault();
		    	return false;
		    }

		    alert("정보가 정상적으로 수정 되었습니다.");
		    // 모든 검사를 통과한 경우
		    return true;
		}
		
		function checkDuplicateEmail() {
		    const emailEl = document.getElementById("email");
		    const emailValidationFeedback = document.getElementById("emailValidationFeedback");
		    const email = emailEl.value;

		    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/; // 이메일 형식을 체크하는 정규표현식

		    if (email) {
		        if (!emailRegex.test(email)) {
		            emailEl.classList.add("is-invalid");
		            emailEl.classList.remove("is-valid");
		            emailValidationFeedback.textContent = "올바른 이메일 형식이 아닙니다.";
		            return;
		        }

		        if (email === '${user.email}') {
		            emailEl.classList.add("is-valid");
		            emailEl.classList.remove("is-invalid");
		            emailValidationFeedback.textContent = "현재 귀하가 사용중인 이메일 입니다.";
		            return;
		        }

		        isDuplicate({ email: email }, function(isDuplicate) {
		            if (isDuplicate) {
		                emailEl.classList.add("is-invalid");
		                emailEl.classList.remove("is-valid");
		                emailValidationFeedback.textContent = "중복된 이메일입니다.";
		            } else {
		                emailEl.classList.add("is-valid");
		                emailEl.classList.remove("is-invalid");
		                emailValidationFeedback.textContent = "사용 가능한 이메일입니다.";
		            }
		        });
		    } else {
		        emailEl.classList.add("is-invalid");
		        emailEl.classList.remove("is-valid");
		        emailValidationFeedback.textContent = "이메일을 입력바랍니다.";
		    }
		}

		function checkDuplicateNickname() {
		    const nicknameEl = document.getElementById("nickname");
			const nicknameValidationFeedback = document.getElementById("nicknameValidationFeedback");
		    if (nicknameEl.value) {
		    	console.log('${user.nickname}',nicknameEl.value)
		    	if(nicknameEl.value === '${user.nickname}'){
		            nicknameEl.classList.add("is-valid");
		            nicknameEl.classList.remove("is-invalid");
		            nicknameValidationFeedback.textContent = "현재 귀하가 사용중인 닉네임 입니다.";
		            return;
		    	}
		    	
		        isDuplicate({ nickname: nicknameEl.value }, function(isDuplicate) {
		            if (isDuplicate) {
		                nicknameEl.classList.add("is-invalid");
		                nicknameEl.classList.remove("is-valid");
		                nicknameValidationFeedback.textContent = "중복된 닉네임입니다.";
		            } else {
		                nicknameEl.classList.add("is-valid");
		                nicknameEl.classList.remove("is-invalid");
		                nicknameValidationFeedback.textContent = "사용 가능한 닉네임입니다.";
		            }
		        });
		    } else {
		        nicknameEl.classList.add("is-invalid");
		        nicknameEl.classList.remove("is-valid");
		        nicknameValidationFeedback.textContent = "닉네임을 입력바랍니다.";
		    }
		}

		function checkPasswordStrength() {
		    const passwordInput = document.getElementById("pw");
		    const helptext = passwordInput.nextElementSibling;
		    const password = passwordInput.value;

		    // 패스워드 강도 체크 로직을 구현합니다.
		    const lengthRegex = /^.{8,}$/; // 8글자 이상인지를 체크하는 정규표현식
		    const uppercaseRegex = /[A-Z]/; // 영문 대문자가 포함되어 있는지를 체크하는 정규표현식
		    const lowercaseRegex = /[a-z]/; // 영문 소문자가 포함되어 있는지를 체크하는 정규표현식
		    const numberRegex = /[0-9]/; // 숫자가 포함되어 있는지를 체크하는 정규표현식
		    const specialCharRegex = /[\W_]/; // 특수문자가 포함되어 있는지를 체크하는 정규표현식

		    let strength = 0; // 패스워드 강도를 나타내는 변수

		    // 각 조건에 맞는지를 체크하여 강도를 증가시킵니다.
		    if (lengthRegex.test(password)) {
		        strength++;
		    }
		    if (uppercaseRegex.test(password)) {
		        strength++;
		    }
		    if (lowercaseRegex.test(password)) {
		        strength++;
		    }
		    if (numberRegex.test(password)) {
		        strength++;
		    }
		    if (specialCharRegex.test(password)) {
		        strength++;
		    }

		    // 강도에 따라 스타일을 적용하고 메시지를 업데이트합니다.
		    if (strength === 5) {
		        passwordInput.classList.add("is-valid");
		        passwordInput.classList.remove("is-invalid");
		        helptext.textContent = "강력한 패스워드입니다.";
		    } else if (strength >= 3) {
		        passwordInput.classList.add("is-valid");
		        passwordInput.classList.remove("is-invalid");
		        helptext.textContent = "보통 수준의 패스워드입니다.";
		    } else {
		        passwordInput.classList.add("is-invalid");
		        passwordInput.classList.remove("is-valid");
		        helptext.textContent = "패스워드는 8글자 이상이어야 하며, 영문자, 숫자, 특수문자를 모두 포함해야 합니다.";
		    }
		}

		function checkPasswordMatch() {
		    const passwordInput = document.getElementById("pw");
		    const passwordConfirmationInput = document.getElementById("pw2");
		    const passwordConfirmationValidationFeedback = document.getElementById("passwordConfirmationValidationFeedback");

		    const password = passwordInput.value;
		    const passwordConfirmation = passwordConfirmationInput.value;

		    if (password === passwordConfirmation) {
		        passwordConfirmationInput.classList.add("is-valid");
		        passwordConfirmationInput.classList.remove("is-invalid");
		        passwordConfirmationValidationFeedback.textContent = "패스워드가 일치합니다.";
		    } else {
		        passwordConfirmationInput.classList.add("is-invalid");
		        passwordConfirmationInput.classList.remove("is-valid");
		        passwordConfirmationValidationFeedback.textContent = "패스워드가 일치하지 않습니다.";
		    }
		}
		
		function submitForm(event) {
			updateBirthday();
			checkSubmitHandler(event)
		}
		
	</script>
	
	<style type="text/css">
		.card {
			border: none;
		}
		
		.card-title {
			color: #FF4379;
			font-size: 16px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		
		.card-text {
			color: black;
			font-size: 30px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word;
			letter-spacing: -3pt;
		}
		
		.title-info {
			color: rgba(0, 0, 0, 0.60);
			font-size: 16px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word;
			letter-spacing: -1pt;
		}
		
		.img-fluid {
			object-fit: cover; /* 이미지가 원래의 비율을 유지하면서 요소를 채움 */
			height: 70px; /* 이미지의 높이를 부모 요소의 높이에 맞춤 */
		}
		
		.form-hint {
			color: #FF4379;
			font-size: 16px;
			font-family: Noto Sans;
			font-weight: 600;
			word-wrap: break-word
		}
		
		.form-check-btn {
			color: white;
			font-size: 16px;
			font-family: Noto Sans;
			font-weight: 600;
			background: black;
			border: black;
			letter-spacing: -1pt;
			width: 12%;
		}
		
		.birthday-text{
			font-size: 16px;
			font-family: Noto Sans;
			font-weight: 600;
			margin-right: 20px;	
			margin-left:  10px;
			text-align: center;
		}
		.helptext {
			color: #6D6A6A;
			font-size: 13px;
			font-family: Noto Sans;
			font-weight: 400;
			line-height: 20px;
			word-wrap: break-word
		}
		
		.tags-container {
			border-radius: 10px;
			border: 1px solid #000;
			padding: 10px;
		}
	</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<% String[] errorMessages=request.getParameterValues("errorMessages"); %>
	
	<main>
		<!-- 에러 메시지를 표시할 Bootstrap Modal -->
		<div class="modal fade" id="errorModal" tabindex="-1" role="dialog" aria-labelledby="errorModalLabel"
			aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="errorModalLabel">입력 정보 오류</h5>
					</div>
					<div class="modal-body">
						<% if (errorMessages !=null && errorMessages.length> 0) {%>
							<ul>
							<% for (String errorMessage : errorMessages) { %>
									<li>
										<%=errorMessage%>
									</li>
									<% } %>
							</ul>
							<% } %>
					</div>
				</div>
			</div>
		</div>
		<% if (errorMessages !=null && errorMessages.length> 0) {
			// 에러 발생 시 모달을 자동으로 열도록 스크립트 추가
			%>
			<script>
				$(document).ready(function () {
					$('#errorModal').modal('show');
					setTimeout(function () {
						$('#errorModal').modal('hide');
					}, 3000); // 3초 후에 모달 창을 자동으로 닫음
				});
			</script>
			<% } %>

				<div class="container col-6 mt-5 pt-5">
					<div class="d-flex justify-content-between align-items-end mt-5">
						<div class="card col-3 p-0 m-0">
							<div class="row align-items-end g-0 p-0 m-0">
								<div class="col-md-4 p-0 m-0">
									<img src="/asset/registerBizUser.svg" class="img-fluid rounded-start"
										alt="...">
								</div>
								<div class="card-body  col-md-8 p-0 m-0">
									<h5 class="card-title p-0 m-0">비즈회원</h5>
									<p class="card-text p-0 m-0">회원가입</p>
								</div>
							</div>							
						</div>
						<div class="col-9 p-1" align="right">
							<span class="title-info">페스티맵에 가입해 사업 정보를 제공하고싶은 기업이나 단체</span>
						</div>
					</div>
				</div>
				<div class="container col-6 mb-1">
					<hr>
				</div>
				<div class="container col-6 mb-5" align="right">
					<span class="form-hint">*필수항목</span>
				</div>
				
				<div class="container col-6">
					<form action="/signUp" method="post">
						<input type="hidden" name="status" value="0"> 
						<input type="hidden" name="big_code" value="1"> 
						<input type="hidden" name="small_code" value="3"> 
						<input type="hidden" name="point" value="0"> 
						<input type="text" id="birthday" name="birthday" style="display: none;">

						<div class="my-4 row align-items-baseline ">
							<label for="email" class="col-sm-2 col-form-label fw-bold text-end"
								style="font-size: 20px;">이메일<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-sm-8">
								<input type="email" class="form-control" id="email" value="${user.email}"
									name="email">
								<p id="emailValidationFeedback" class="helptext text-start"></p>
							</div>
							<button class="btn btn-primary form-check-btn col-sm-2"
								onclick="checkDuplicateEmail();event.preventDefault();">중복확인</button>
						</div>
						<div class="my-4 row align-items-baseline ">
							<label for="pw" class="col-sm-2 col-form-label fw-bold text-end"
								style="font-size: 20px;">패스워드<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-sm-8">
								<input type="password" class="form-control " id="pw" name="password"
									autoComplete="off" oninput="checkPasswordStrength()">
								<p id="passwordValidationFeedback" class="helptext text-start">패스워드(비밀번호)는 8글자 이상의 영문자, 숫자를 포함하여야 합니다.</p>
							</div>
						</div>

						<div class="my-4 row align-items-baseline ">
							<label for="pw2" class="col-sm-2 col-form-label fw-bold text-end"
								style="font-size: 20px;">패스워드확인<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-sm-8">
								<input type="password" class="form-control " id="pw2" autoComplete="off"
									oninput="checkPasswordMatch()">
								<p id="passwordConfirmationValidationFeedback"class="helptext text-start">상기 입력한 패스워드를 한 번 더 입력해 주세요.</p>
							</div>
						</div>

						<div class="my-4 row align-items-baseline ">
							<label for="name" class="col-sm-2 col-form-label fw-bold text-end"
								style="font-size: 20px;">사용자명<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-sm-8">
								<input type="text" class="form-control " id="name" value="${user.name}"
									name="name">
								<p class="helptext text-start"></p>
							</div>
						</div>
						<div class="my-4 row align-items-baseline ">
							<label for="nickname" class="col-sm-2 col-form-label fw-bold text-end "
								style="font-size: 20px;">상호명<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-sm-8">
								<input type="text" class="form-control " id="nickname" value="${user.nickname}"
									name="nickname">
								<p id="nicknameValidationFeedback" class="helptext text-start"></p>
							</div>
							<button class="btn btn-primary form-check-btn col-sm-2 "
								onclick="checkDuplicateNickname();event.preventDefault();">중복확인</button>
						</div>

						<div class="my-4 row align-items-baseline ">
							<label class="col-sm-2 col-form-label fw-bold text-end"
								style="font-size: 20px;">성별<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-sm-8 d-flex">
								<div class="form-check">
									<input class="form-check-input" type="radio" name="gender" id="male"
										value="0" checked> <label class="form-check-label" for="male">남자</label>
								</div>
								<div class="col-1"></div>
								<div class="form-check">
									<input class="form-check-input" type="radio" name="gender" id="female"
										value="1" }> <label class="form-check-label" for="female">여자</label>
								</div>
								<p class="helptext text-start"></p>
							</div>
						</div>
						<div class="my-4 row align-items-center ">
							<label class="col-sm-2 col-form-label fw-bold text-end"
								style="font-size: 20px;">생일<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-sm-8 d-flex align-items-center">
								<div class="col-4"	>
								    <select class="form-select text-center" id="year">
								        <option value=""></option>
								    </select>
								</div>
								<span class="birthday-text">년</span>
								<div class="col-3"	>
									<select class="form-select text-center" id="month">
									       <option value=""></option>
								    </select>
								</div>
								<span class="birthday-text">월</span>
								<div class="col-3 "	>
									<select class="form-select text-center" id="day">
									 	<option value=""></option>
									</select>
								</div>
								<span class="birthday-text">일</span>
							</div>
						</div>
															
						<div class="my-4 row align-items-baseline ">
							<label for="phone_num" class="col-sm-2 col-form-label fw-bold text-end"
								style="font-size: 20px;">전화번호<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-sm-8">
								<input type="tel" class="form-control " id="phone_num" value="${user.phone_num}"
									name="phone_num">
								<p class="helptext text-start"></p>
							</div>
						</div>
						<div class="my-4 row align-items-baseline ">
							<label for="address" class="col-2 col-form-label fw-bold text-end px-3 "
								style="font-size: 20px;">주소<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label>
							<div class="col-4 px-3">
								<select name="area" class="form-select area-dropdown"></select>
								<p class="helptext text-start"></p>
							</div>
							<div class="col-4 px-3">
								<select name="sigungu" class="form-select sigungu-dropdown"></select>
								<p class="helptext text-start"></p>
							</div>

							<!-- <button class="btn btn-primary form-check-btn col-2 px-3"
								onclick="event.preventDefault();">주소찾기</button> -->
						</div>
						<div class="my-4 row align-items-baseline ">
							<label for="phone_num" class="col-sm-2 col-form-label fw-bold text-end"
								style="font-size: 20px;"></label>
							<div class="col-sm-8">
								<input type="text" class="form-control " id="address" name="address"
								 placeholder="상세주소를 입력해주세요.">
								<p class="helptext text-start"></p>
							</div>
						</div>
						<div class="my-4 row align-items-baseline ">
							<label for="address" class="col-2 col-form-label fw-bold text-end px-3 "
								style="font-size: 20px;">사업자 증빙<SUP
									style="color: #FF4379; font-size: 18px;">*</SUP></label> 
							<div class="col-8 mb-3 d-flex">
								<div class="form-group col">
									<input type="file" class="form-control" name="file_name" id="file_name"> 
								</div>
							</div>
						</div>

						<div class="container row justify-content-center my-5">
							<button type="submit" class="btn btn-primary col-5 px-3 mx-2"
								style="background: #52525C; border: none"
								onclick="submitForm(event);">저장하기</button>									
							<button type="reset" class="btn btn-primary col-5 px-3 mx-2"
								onclick="cancelForm()">취소</button>
						</div>
					</form>
				</div>
				
			</main>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
</body>
</html>