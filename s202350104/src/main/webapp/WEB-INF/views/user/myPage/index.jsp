<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Festival</title>
<style type="text/css">
h1 {
	color: black;
	font-size: 32px;
	font-family: Noto Sans;
	font-weight: 600;
	word-wrap: break-word
}

h2 {
	color: #FF4379;
	font-size: 24px;
	font-family: Noto Sans;
	font-weight: 800;
	word-wrap: break-word
}

h3 {
	color: #6D6A6A;
	font-size: 20px;
	font-family: Noto Sans;
	font-weight: 600;
	word-wrap: break-word
}

h4 {
	color: black;
	font-size: 15px;
	font-family: Noto Sans;
	font-weight: 500;
	word-wrap: break-word
}

.username {
	color: black;
	font-size: 32px;
	font-family: Noto Sans;
	font-weight: 600;
	word-wrap: break-word
}

.hello {
	color: #6D6A6A;
	font-size: 20px;
	font-family: Noto Sans;
	font-weight: 600;
	word-wrap: break-word
}

.helptext {
	color: #6D6A6A;
	font-size: 13px;
	font-family: Noto Sans;
	font-weight: 400;
	line-height: 20px;
	word-wrap: break-word
}

.birthday-text {
	font-size: 16px;
	font-family: Noto Sans;
	font-weight: 600;
	margin-right: 20px;
	margin-left: 10px;
	text-align: center;
}

#history-table td{
    white-space: nowrap; /* 줄바꿈을 방지 */
}

table td {
    text-align: center; 
    vertical-align: middle;
}
table {
  border-collapse: collapse;
}
table td {
  border: 1px solid #D9D9D9; 
}
table th {
  border: 1px solid #D9D9D9; 
}


.table-container{
border-radius: 10px;
border: 1px solid #000;
}
#history-table {
    width: 90%; /* 테이블의 너비를 컨테이너의 너비에 맞게 조정 */
}
.modal-body {
  max-height: 600px; /* 모달 본문의 최대 높이를 설정. 필요에 따라 조정하세요 */
  overflow-y: auto; /* 내용이 높이를 넘어갈 경우 스크롤바를 표시 */
}

</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/checkUserDuplicate.js"></script>
<script>

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

	
	document.addEventListener('DOMContentLoaded', (event) => {
	    const pw = document.getElementById("pw");
	    const pw2 = document.getElementById("pw2");
	
	    pw2.oninput = function() {
	        if (pw.value !== pw2.value) {
	            pw2.setCustomValidity("패스워드가 일치하지 않습니다.");
	        } else {
	            pw2.setCustomValidity("");
	        }
	    }
	    
	    function checkPassword(password) {
	        // 영문자, 숫자, 특수문자가 모두 포함되어 있는지 확인하는 정규표현식
	        const regex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*]).+$/;
	
	        if (regex.test(password)) {
	            // 패스워드가 요구 사항을 만족하는 경우
	            return true;
	        } else {
	            // 패스워드가 요구 사항을 만족하지 않는 경우
	            return false;
	        }
	    }    
	
	    pw.onchange = function() {
	        if (!checkPassword(pw.value)) {
	            pw.setCustomValidity("패스워드는 영문자, 숫자, 특수문자를 모두 포함해야 합니다.");
	        } else {
	            pw.setCustomValidity("");
	        }
	    }
	    
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
	    const username = document.getElementById("username");
	    const nickname = document.getElementById("nickname");
	    const phone_num = document.getElementById("phone_num");
	    const	 address = document.getElementById("address");
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
	    if (username.value === "") {
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
	
        alert("정보가 정상적으로 수정 되었습니다.");
	    // 모든 검사를 통과한 경우
	    return true;
	}

	function editBtnHandler() {
	    // 조회 화면 숨기기
	    document.getElementById("view").style.display = "none";
	
	    // 수정 화면 표시
	    document.getElementById("edit").style.display = "block";
	};
	
	function cancelBtnHandler(){
	    // 조회 화면 숨기기
	    document.getElementById("view").style.display = "block";
	
	    // 수정 화면 표시
	    document.getElementById("edit").style.display = "none";
		
	}
</script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main>
		<div class="d-flex">
			<div class="col-2">
			<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			</div>
			<div class="container p-5 col-10">
				<div class="container my-5">
					<h1>계정 관리</h1>
					<hr class="hr" />
					<h4>당신의 매일이 축제와 같기를</h4>
					<span class="username">${user.name}</span> <span class="hello">님,
						반가워요!</span>
					<hr class="hr" />
					<div class="container p-2 my-2">
						<h2>내 정보</h2>
						<div class="container w-80 my-5" align="center">

							<!-- 회원 정보 조회 화면 -->
							<div id="view" class="container" align="center">
								<div class="m-4 row align-items-baseline ">
									<label for="email-view"
										class="col-sm-2 col-form-label fw-bold text-end mx-3"
										style="font-size: 20px;">이메일</label>
									<div class="col-sm-6 mx-3">
										<input type="email" class="form-control-plaintext "
											id="email-view" value="${user.email}" readonly>
									</div>
								</div>
								<div class="m-4 row align-items-baseline ">
									<label for="username-view"
										class="col-sm-2 col-form-label fw-bold text-end mx-3"
										style="font-size: 20px;">사용자명</label>
									<div class="col-sm-6 mx-3">
										<input type="text" class="form-control-plaintext "
											id="username-view" value="${user.name}" readonly>
									</div>
								</div>
								<div class="m-4 row align-items-baseline ">
									<label for="nickname-view"
										class="col-sm-2 col-form-label fw-bold text-end mx-3"
										style="font-size: 20px;">닉네임</label>
									<div class="col-sm-6 mx-3">
										<input type="text" class="form-control-plaintext "
											id="nickname-view" value="${user.nickname}" readonly>
									</div>
								</div>

								<div class="m-4 row align-items-baseline ">
									<label class="col-sm-2 col-form-label fw-bold text-end mx-3"
										style="font-size: 20px;">성별</label>
									<div class="col-sm-6 mx-3 d-flex">
										<div class="form-check mx-2">
											<input class="form-check-input" type="radio" name="gender-퍋ㅈ"
												id="male-view" value="0" ${user.gender =="0"?"checked":""}
												disabled> <label class="form-check-label" for="male">남자</label>
										</div>
										<div class="form-check mx-2">
											<input class="form-check-input" type="radio" name="gender"
												id="female-view" value="1" ${user.gender =="1"?"checked":""}
												disabled> <label class="form-check-label"
												for="female">여자</label>
										</div>
									</div>
								</div>
								<div class="m-4 row align-items-baseline ">
									<label for="phone_num-view"
										class="col-sm-2 col-form-label fw-bold text-end mx-3"
										style="font-size: 20px;">핸드폰번호</label>
									<div class="col-sm-6 mx-3">
										<input type="tel" class="form-control-plaintext "
											id="phone_num-view" value="${user.phone_num}" readonly>
									</div>
								</div>
								<div class="m-4 row align-items-baseline ">
									<label for="address-view"
										class="col-sm-2 col-form-label fw-bold text-end mx-3"
										style="font-size: 20px;">주소</label>
									<div class="col-sm-6 mx-3">
										<input type="text" class="form-control-plaintext "
											id="address-view" value="${user.address}" readonly>
									</div>
								</div>
								<div class="container  justify-content-start my-5">
									<button class="btn btn-primary col-sm-4 mx-3" style="background-color: #171717; border-color: #171717"
										onclick="editBtnHandler()">수정하기</button>
								</div>
							</div>

							<!-- 회원 정보 수정 화면 -->
							<div id="edit" style="display: none;">
								<form action="/admin/user/updateUser" method="POST">
									<input type="hidden" name="id" value="${user.id }"> <input
										type="hidden" name="birthday" value="${user.birthday }">
									<input type="hidden" name="status" value="${user.status }">
									<input type="hidden" name="point" value="${user.point }">
									<input type="hidden" name="file_name"
										value="${user.file_name }"> <input type="hidden"
										name="is_deleted" value="${user.is_deleted }">
									<div class="mb-2 row align-items-baseline ">
										<label for="email"
											class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">이메일<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3">
											<input type="email" class="form-control-plaintext "
												id="email" value="${user.email}" name="email" readonly>
										</div>
									</div>
									<div class="mb-2 row align-items-baseline ">
										<label for="pw"
											class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">패스워드<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3">
											<input type="password" class="form-control " id="pw"
												name="password" autoComplete="off">
											<p class="helptext text-start">패스워드(비밀번호)는 영문자, 숫자, 특수문자를
												모두 포함하여야 합니다.</p>
										</div>
									</div>

									<div class="mb-2 row align-items-baseline ">
										<label for="pw2"
											class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">패스워드 확인<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3">
											<input type="password" class="form-control " id="pw2"
												autoComplete="off">
											<p class="helptext text-start">상기 입력한 패스워드를 한 번 더 입력해
												주세요.</p>
										</div>
									</div>

									<div class="mb-2 row align-items-baseline ">
										<label for="name"
											class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">사용자명<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3">
											<input type="text" class="form-control " id="name"
												value="${user.name}" name="name">
											<p class="helptext text-start"></p>
										</div>
									</div>
									<div class="mb-2 row align-items-baseline ">
										<label for="nickname"
											class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">닉네임<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3">
											<input type="text" class="form-control " id="nickname"
												value="${user.nickname}" name="nickname">
											<p id="nicknameValidationFeedback"
												class="helptext text-start"></p>
										</div>
										<button class="btn btn-primary col-sm-1 mx-3"
											onclick="checkDuplicateNickname();event.preventDefault();">중복확인</button>
									</div>

									<div class="mb-2 row align-items-baseline ">
										<label class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">성별<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3 d-flex">
											<div class="form-check mx-2">
												<input class="form-check-input" type="radio" name="gender"
													id="male" value="0" ${user.gender =="0"?"checked":""}>
												<label class="form-check-label" for="male">남자</label>
											</div>
											<div class="form-check mx-2">
												<input class="form-check-input" type="radio" name="gender"
													id="female" value="1" ${user.gender =="1"?"checked":""}>
												<label class="form-check-label" for="female">여자</label>
											</div>
											<p class="helptext text-start"></p>
										</div>
									</div>
									<div class="mb-2 row align-items-center ">
										<label class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">생일<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3 d-flex">
											<div class="col-4">
												<select class="form-select text-center" id="year">
													<option value=""></option>
												</select>
											</div>
											<span class="birthday-text">년</span>
											<div class="col-3">
												<select class="form-select text-center" id="month">
													<option value=""></option>
												</select>
											</div>
											<span class="birthday-text">월</span>
											<div class="col-3 ">
												<select class="form-select text-center" id="day">
													<option value=""></option>
												</select>
											</div>
											<span class="birthday-text">일</span>
										</div>
									</div>
									<div class="mb-2 row align-items-baseline ">
										<label for="phone_num"
											class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">핸드폰번호<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3">
											<input type="tel" class="form-control " id="phone_num"
												value="${user.phone_num}" name="phone_num">
											<p class="helptext text-start"></p>
										</div>
									</div>
									<div class="mb-2 row align-items-baseline ">
										<label for="address"
											class="col-sm-2 col-form-label fw-bold text-end mx-3"
											style="font-size: 20px;">주소<SUP
											style="color: #FF4379; font-size: 18px;">*</SUP></label>
										<div class="col-sm-6 mx-3">
											<input type="text" class="form-control " id="address"
												value="${user.address}" name="address">
											<p class="helptext text-start"></p>
										</div>
										<button class="btn btn-primary col-sm-1 mx-3"
											onclick="event.preventDefault();">주소찾기</button>
									</div>
									<div class="container  justify-content-start my-5">
										<button type="submit" class="btn btn-primary col-sm-4 mx-3"
											onclick="checkSubmitHandler(event)">저장하기</button>
										<button type="reset" class="btn col-sm-4 mx-3"
											onclick="cancelBtnHandler()">취소</button>
									</div>
								</form>
							</div>



						</div>
					</div>
					<div class="container  p-2 my-5">
						<hr class="hr" />
						<h2>포인트 내역</h2>
						<div
							class="container m-3 p-5 row align-items-center justify-content-center ">
							<label for="point"
								class="col-3 col-lg-2 col-form-label fw-bold text-end"
								style="font-size: 20px;">잔여포인트</label>
							<div class="col-6 col-lg-5 d-flex align-items-center">
								<input type="text" class="form-control" id="point"
									value="${user.point}" name="point"> <label
									class="col-form-label fw-bold mx-2" style="font-size: 20px;">P</label>
							</div>
							<div class="col-3 col-lg-2">
								<button type="button" class="btn btn-primary w-100"
									data-bs-toggle="modal" data-bs-target="#pointHistoryModal" style="background-color: #171717; border-color: #171717">
									포인트 내역</button>

							</div>
							<!-- 모달 -->
							<div class="modal fade" id="pointHistoryModal" tabindex="-1"
								aria-labelledby="pointHistoryModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header text-center d-flex align-items-center">
										  <div class="col text-center">
										    <h2 class="modal-title" id="pointHistoryModalLabel">포인트 사용 내역</h2>
										  </div>
										  <div class="col-auto">
										    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
										  </div>
										</div>
										<div class="modal-body">
											<div class="table-container" align="center">
												<table class="table history-table">
													<thead>
														<tr>
															<th scope="col">생성일</th>
															<th scope="col">내용</th>
															<th scope="col">포인트</th>
														</tr>
													</thead>
													<tbody>
														<c:forEach var="pointHistory" items="${pointHistoryList}"
															varStatus="st">
															<tr id="user${st.index}">
																<td><fmt:formatDate
																		value="${pointHistory.created_at}" type="date"
																		pattern="YY/MM/dd" /></td>
																<td>${pointHistory.point_title}</td>
																<td>${pointHistory.point_point}</td>
															</tr>
														</c:forEach>
													</tbody>
												</table>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal">Close</button>
										</div>
									</div>
								</div>
							</div>
						</div>


					</div>
				</div>
			</div>
		</div>

	</main>

</body>
</html>