<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
			document.addEventListener("DOMContentLoaded", function () {
			    const badgeSelect = document.querySelector('#badgeSelect');
			    const addBadgeBtn = document.querySelector('#addBadgeBtn');
			    const badgesArea = document.querySelector('#badgesArea');
			
			    // Initialize the list of available badges
			    const availableBadges = Array.from(badgeSelect.options).map(option => option.value).filter(value => value !== '');
			
			    addBadgeBtn.addEventListener('click', () => {
			      if (badgeSelect.value !== '') {
			        // Create a new badge and add it to the page
			        const newBadge = document.createElement('span');
			        newBadge.className = 'badge bg-primary';
			        newBadge.textContent = badgeSelect.value;
			
			        const closeButton = document.createElement('button');
			        closeButton.className = 'btn-close';
			        closeButton.setAttribute('aria-label', 'Close');
			        closeButton.addEventListener('click', (event) => {
			          // When the badge is deleted, add its value back to the select box
			          const deletedBadgeValue = event.target.parentElement.textContent.trim();
			          availableBadges.push(deletedBadgeValue);
			          updateSelectOptions();
			          event.target.parentElement.remove();
			        });
			
			        newBadge.appendChild(closeButton);
			        badgesArea.appendChild(newBadge);
			
			        // Remove the added badge's value from the select box
			        availableBadges.splice(availableBadges.indexOf(badgeSelect.value), 1);
			        updateSelectOptions();
			        badgeSelect.value = '';
			      }
			    });
			
			    function updateSelectOptions() {
			      badgeSelect.innerHTML = '<option value="">Select a badge</option>';
			      availableBadges.forEach(badge => {
			        const option = document.createElement('option');
			        option.value = badge;
			        option.textContent = badge;
			        badgeSelect.appendChild(option);
			      });				
			    }
			});
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
</style>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main>
		<div class="row justify-content-center mt-5">
			<div
				class="col-6 d-flex justify-content-between align-items-end mt-5">
				<div class="card col-3 p-0 m-0">
					<div class="row align-items-end g-0 p-0 m-0">
						<div class="col-md-4 p-0 m-0">
							<img src="/asset/registerUser.svg"
								class="img-fluid rounded-start" alt="...">
						</div>
						<div class="card-body  col-md-8 p-0 m-0">
							<h5 class="card-title p-0 m-0">일반회원</h5>
							<p class="card-text p-0 m-0">회원가입</p>
						</div>
					</div>
				</div>

				<div class="col-9 p-1" align="right">
					<span class="title-info">페스티맵에 가입해 다양한 정보를 받아보고 싶은 만 14세 이상의
						내국인</span>
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
				<input type="hidden" name="status" value="1"> <input
					type="hidden" name="big_code" value="1"> <input
					type="hidden" name="small_code" value="2"> <input
					type="hidden" name="point" value="0"> <input type="hidden"
					name="file_name" value="">
				<div class="my-4 row align-items-baseline ">
					<label for="email" class="col-sm-2 col-form-label fw-bold text-end"
						style="font-size: 20px;">이메일<SUP
						style="color: #FF4379; font-size: 18px;">*</SUP></label>
					<div class="col-sm-8">
						<input type="email" class="form-control" id="email"
							value="${user.email}" name="email">
					</div>
					<button class="btn btn-primary form-check-btn col-sm-2"
						onclick="event.preventDefault();">중복확인</button>
				</div>
				<div class="my-4 row align-items-baseline ">
					<label for="pw" class="col-sm-2 col-form-label fw-bold text-end"
						style="font-size: 20px;">패스워드<SUP
						style="color: #FF4379; font-size: 18px;">*</SUP></label>
					<div class="col-sm-8">
						<input type="password" class="form-control " id="pw"
							name="password" autoComplete="off">
						<p class="helptext text-start">패스워드(비밀번호)는 영문자, 숫자, 특수문자를 모두
							포함하여야 합니다.</p>
					</div>
				</div>

				<div class="my-4 row align-items-baseline ">
					<label for="pw2" class="col-sm-2 col-form-label fw-bold text-end"
						style="font-size: 20px;">패스워드확인<SUP
						style="color: #FF4379; font-size: 18px;">*</SUP></label>
					<div class="col-sm-8">
						<input type="password" class="form-control " id="pw2"
							autoComplete="off">
						<p class="helptext text-start">상기 입력한 패스워드를 한 번 더 입력해 주세요.</p>
					</div>
				</div>

				<div class="my-4 row align-items-baseline ">
					<label for="name" class="col-sm-2 col-form-label fw-bold text-end"
						style="font-size: 20px;">사용자명<SUP
						style="color: #FF4379; font-size: 18px;">*</SUP></label>
					<div class="col-sm-8">
						<input type="text" class="form-control " id="name"
							value="${user.name}" name="name">
						<p class="helptext text-start"></p>
					</div>
				</div>
				<div class="my-4 row align-items-baseline ">
					<label for="nickname"
						class="col-sm-2 col-form-label fw-bold text-end "
						style="font-size: 20px;">닉네임<SUP
						style="color: #FF4379; font-size: 18px;">*</SUP></label>
					<div class="col-sm-8">
						<input type="text" class="form-control " id="nickname"
							value="${user.nickname}" name="nickname">
						<p class="helptext text-start"></p>
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
							<input class="form-check-input" type="radio" name="gender"
								id="male" value="0" checked> <label
								class="form-check-label" for="male">남자</label>
						</div>
						<div class="form-check">
							<input class="form-check-input" type="radio" name="gender"
								id="female" value="1"}> <label class="form-check-label"
								for="female">여자</label>
						</div>
						<p class="helptext text-start"></p>
					</div>
				</div>
				<div class="my-4 row align-items-baseline ">
					<label for="phone_num"
						class="col-sm-2 col-form-label fw-bold text-end"
						style="font-size: 20px;">핸드폰번호<SUP
						style="color: #FF4379; font-size: 18px;">*</SUP></label>
					<div class="col-sm-8">
						<input type="tel" class="form-control " id="phone_num"
							value="${user.phone_num}" name="phone_num">
						<p class="helptext text-start"></p>
					</div>
				</div>
				<div class="my-4 row align-items-baseline ">
					<label for="address"
						class="col-2 col-form-label fw-bold text-end px-3 "
						style="font-size: 20px;">주소<SUP
						style="color: #FF4379; font-size: 18px;">*</SUP></label>
					<div class="col-8 px-3">
						<input type="text" class="form-control " id="address"
							value="${user.address}" name="address">
						<p class="helptext text-start"></p>
					</div>

					<button class="btn btn-primary form-check-btn col-2 px-3"
						onclick="event.preventDefault();">주소찾기</button>
				</div>
				<div class="container">
					<label for="address"
						class="col-2 col-form-label fw-bold text-end px-3 "
						style="font-size: 20px;">관심사</label>
					<select id="badgeSelect" name="tag_id">
						<option value="">태그를 선택해주세요.</option>
						<c:forEach var="tag" items="${listTags}">
							<option value="${tag.id}">${tag.name}</option>
						</c:forEach>
						<!-- Add more options as needed -->
					</select>
					<button id="addBadgeBtn">Add Badge</button>
					<div id="badgesArea">
						<!-- New badges will be added here -->
					</div>
				</div>

				<div class="container row justify-content-center my-5">
					<button type="submit" class="btn btn-primary col-5 px-3 mx-2" style="background: #52525C;border:none"
						onclick="checkSubmitHandler(event)">저장하기</button>
					<button type="reset" class="btn btn-primary col-5 px-3 mx-2"
						onclick="cancelBtnHandler()">취소</button>
				</div>
			</form>
		</div>

	</main>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>