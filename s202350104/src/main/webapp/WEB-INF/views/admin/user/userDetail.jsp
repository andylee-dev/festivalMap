<%@page import="org.apache.catalina.User"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Detail Form</title>
<style type="text/css">
.detail-body-container {
	justify-content: center;
	padding-right: 0;
	padding-left: 0;
	margin-right: 0;
	margin-left: 0;
}

h1 {
	color: #000;
	font-family: Noto Sans;
	font-size: 32px;
	font-style: normal;
	font-weight: 600;
	line-height: normal;
	letter-spacing: -0.96px;
}

h2 {
	color: #FF4379;
	font-family: Noto Sans;
	font-size: 24px;
	font-style: normal;
	font-weight: 600;
	line-height: normal;
	padding-bottom: 10px;
}

#detail-main-container {
	position: relative;
	border: 1px solid #000;
	border-radius: 10px;
	background-color: white;
}

#detail-top-container {
	position: absolute;
	width: 250px;
	height: 83px;
	border-radius: 10px;
	border: 1px solid #000;
	flex-shrink: 0;
	top: -40px; /* B의 상단에 A를 위치시키기 위해 top을 0으로 설정 */
	margin: auto; /* 수평 및 수직 가운데 정렬을 위해 margin을 auto로 설정 */
	z-index: -1; /* A를 B 뒤로 보내기 위해 z-index를 -1로 설정 */
	background-color: black;
}

#detail-top-text {
	color: white;
	font-family: Noto Sans;
	font-size: 16px;
	font-style: normal;
	font-weight: 600;
	line-height: normal;
	letter-spacing: -0.48px;
	padding-top: 5px;
	white-space: nowrap; /* 줄바꿈을 방지 */
}

#detail-top-id{
	color: #FF4379;
	font-family: Noto Sans;
	font-size: 16px;
	font-style: normal;
	font-weight: 600;
	line-height: normal;
	letter-spacing: -0.48px;
	padding-top: 5px;
	white-space: nowrap; /* 줄바꿈을 방지 */
}


.form-label{
	color: #000;
	
	font-family: Noto Sans;
	font-size: 16px;
	font-style: normal;
	font-weight: 600;
	line-height: normal;
}

.form-input[disabled] {
	color: #000;
	border: 0px solid #F4F4F4;
	border-radius: 10px;
	background: #F4F4F4;
	font-family: Noto Sans;
	font-size: 24px;
	font-style: normal;
	font-weight: 400;
	line-height: normal;
	letter-spacing: -0.72px;
}

.form-input {
	color: #000;
	border: 1px solid ;
	border-radius: 10px;
	font-family: Noto Sans;
	font-size: 24px;
	font-style: normal;
	font-weight: 400;
	line-height: normal;
	letter-spacing: -0.72px;
}
	
.helptext {
	color: #6D6A6A;
	font-size: 13px;
	font-family: Noto Sans;
	font-weight: 400;
	line-height: 20px;
	word-wrap: break-word
}

.birthday-text{
	font-size: 16px;
	font-family: Noto Sans;
	font-weight: 600;
	margin-right: 20px;	
	margin-left:  10px;
	text-align: center;
}	

.btn[disabled]{
	border: 0px solid #F4F4F4;
	background: #F4F4F4;
	color: #6D6A6A;

}
	
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function () {
	$(".edit-btn").click(function () {
		$(".form-input").prop("disabled", false);
		$(".check-duple").prop("disabled", false);
	});

	$(".cancel-btn").click(function () {
		$(".form-input").prop("disabled", true);
		$(".check-duple").prop("disabled", true);
	});

	$("toggle-status-btn").click(function () { });
});
</script>
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
	
	function userDeleteAjax() {
		if(confirm("정말 삭제하시겠습니까?")) {
		$.ajax(
			{
				method:"POST",
				url:"/admin/user/userDeleteAjax",
				data:{id : ${user.id}},
				dataType:'text',
				success:
					function(result) {
						if(result == '1') {
							alert("성공적으로 삭제되었습니다.");
							location.reload();
						} else {
							alert("삭제에 실패하였습니다.");
						}		
					}
				}		
			)
		}
	}

/* 	function insertHistoryAjax() {
		const banReason = document.getElementById('message-text').value;
		const modalTitleText = document.getElementById('modal-title').innerText;
		
		$.ajax(
			{
				method:"POST",
				url:"/insertHistoryAjax",
				data:{
					big_code: ${user.big_code},
					small_code:${user.small_code},
					target_id:${user.id},
					title: modalTitleText,
					content: banReason,
					
				},
				dataType:'text',
				success:
					function(result) {
 						if(result == '1') {
							// row.parentNode.removeChild(row);
							alert("성공적으로 삭제되었습니다.");
							location.reload();
						} else {
							alert("삭제에 실패하였습니다.");
						}		
					}
				}		
			)
	} */

	/* 모달에서 반려 했을 경우 동작하는 핸들러.*/
	function submitRejectForm() {
		// Status 0으로 만들기.
		document.getElementById('statusInput').value = 0;
		$(".form-input ,.check-duple").prop("disabled", false);

		$('#exampleModal').modal('hide');
		    
		const banReason = document.getElementById('message-text').value;
		const modalTitleText = document.getElementById('modal-title').innerText;
		$("#ban-title").val(modalTitleText);
		$("#ban-content").val(banReason);
		   
		document.getElementById('update-form').submit();
	}

	/* 모달에서 승인 했을 경우 동작하는 핸들러.*/
	function submitAcceptForm() {
		document.getElementById('statusInput').value = 1;
		$(".form-input ,.check-duple").prop("disabled", false);
		alert("승인처리를 했습니다.");
		document.getElementById('update-form').submit();
	}

</script>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-10 overflow-auto p-0">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-people-fill "></i> <label class="admin-header-title ">회원 정보(
							${user.name} )</label>
					</div>
				</div>
				<!-- Section2: Search Form -->
				<div id="detail-body-container" class="container col-9 my-5">
					<div>
						<h1>회원관리</h1>
					</div>
					<div>
						<hr>
					</div>
					<div>
						<h2>회원 상세정보</h2>
					</div>
					<div class="my-5">
						<div class="" id="detail-main-container">
							<div class="container d-flex justify-content-around" id="detail-top-container">
								<label id="detail-top-text">회원 | ${ user.small_code == 2 ? "일반": (user.small_code == 3
									?"비즈니스": null) } | ${user.id }</label>
								<c:if test="${ user.small_code == 3}">
									<label id="detail-top-id"
										style='${user.status == 1?"color:#9BDB04":""}'>${user.status == 1?
										"승인(게시중)":"승인대기"} </label>
								</c:if>
							</div>
							<div class="container p-5 mx-3" id="form-container">
								<form action="/admin/user/updateUser" id="update-form" method="POST">
									<input type="hidden" name="id" value="${user.id }">
									<input type="hidden" name="birthday" value="${user.birthday }">
									<input type="hidden" name="status" id="statusInput" value="${user.status }">
									<input type="hidden" name="point" value="${user.point }">
									<input type="hidden" name="file_name" value="${user.file_name }">
									<input type="hidden" name="is_deleted" value="${user.is_deleted }">
									<input type="hidden" name="password" value="${user.password }">
									<input type="hidden" name="address" value="${user.address }">
									<input type="hidden" name="phone_num" value="${user.phone_num }">
									<input type="hidden" name="gender" value="${user.gender }">
									<input type="hidden" name="big_code" value="${user.big_code }">
									<input type="hidden" name="small_code" value="${user.small_code }">
									<input type="hidden" name="target_id" value="${user.id }">
									<input type="hidden" name="title" id="ban-title" >
									<input type="hidden" name="content" id="ban-content">

									<div class="form-row d-flex justify-content-between">
										<div class="col-md-9 mb-3 px-2">
											<label for="name" class="form-label">이름</label>
											<input type="text" class="form-control form-control form-input" id="name"
												name="name" value="${user.name }" disabled>
										</div>
									</div>
									<div class="form-row d-flex justify-content-between">
										<div class="col-md-12 mb-3">
											<label for="nickname" class="form-label">닉네임</label>
											<div class="form-row d-flex justify-content-between">
												<div class="col-md-9 px-2">
													<input type="text" class="form-control form-control form-input"
														id="nickname" name="nickname" value="${user.nickname }"
														disabled>
												</div>
												<div class="col-md-2">
													<button id="check-nickname-duple"
														class="check-duple form-control btn btn-primary " disabled
														onclick="checkDuplicateNickname();event.preventDefault();">중복확인</button>
												</div>
											</div>
											<p id="nicknameValidationFeedback" class="helptext text-start"></p>
										</div>
									</div>
									<div class="form-row d-flex justify-content-between">
										<div class="col-md-12 mb-3">
											<label for="email" class="form-label">이메일</label>
											<div class="form-row d-flex justify-content-between">
												<div class="col-md-9 px-2">
													<input type="email" class="form-control form-control form-input"
														name="email" id="email" value="${user.email }" disabled>
												</div>
												<div class="col-md-2">
													<button id="check-nickname-duple"
														class="check-duple form-control btn btn-primary " disabled
														onclick="checkDuplicateNickname();event.preventDefault();">중복확인</button>
												</div>
											</div>
											<p id="nicknameValidationFeedback" class="helptext text-start"></p>
										</div>
									</div>

									<c:choose>
										<c:when test="${user.status == 0 }">
											<div id="view" class="container" align="center">
												<div class="form-row d-flex justify-content-between px-2">
													<div class="col-7 mb-3">
														<button type="submit" id="edit-btn"
															class="edit-btn form-control btn btn-primary "
															onclick="submitAcceptForm();event.preventDefault();">승인하기</button>
													</div>
													<div class="form-row col-5 d-flex justify-content-between mx-3">
														<div class="col-4 mb-3">
															<!-- Button trigger modal -->
															<button type="button"
																class="form-control btn btn-outline-secondary"
																data-bs-toggle="modal" data-bs-target="#exampleModal">
																반려
															</button>
														</div>
														<div class="col-4 mb-3">
															<button type="submit" id="delete-btn"
																onclick="userDeleteAjax();event.preventDefault();"
																class="form-control btn btn-outline-secondary">삭제</button>
														</div>
														<div class="col-3 mb-3">
															<c:choose>
																<c:when test="${user.small_code ==2 }">
																	<a class="form-control btn btn-outline-secondary"
																		href="/admin/user/userList">목록</a>
																</c:when>
																<c:when test="${user.small_code ==3 }">
																	<a class=" form-control btn btn-outline-secondary"
																		href="/admin/user/bizUserList">목록</a>
																</c:when>
															</c:choose>
														</div>
													</div>
												</div>
											</div>
										</c:when>

										<c:when test="${user.status == 1 }">
											<div id="view" class="container" align="center">
												<div class="form-row d-flex justify-content-between px-2">
													<div class="col-7 mb-3">
														<button type="submit" id="edit-btn"
															class="edit-btn form-control btn btn-primary "
															style="background-color:#9BDB04; border:1px solid #9BDB04"
															onclick="editBtnHandler();event.preventDefault();">수정하기</button>
													</div>
													<div class="form-row col-5 d-flex justify-content-between mx-3">
														<div class="col-4 mb-3">
															<!-- Button trigger modal -->
															<button type="button"
																class="form-control btn btn-outline-secondary"
																data-bs-toggle="modal" data-bs-target="#exampleModal">
																반려전환
															</button>
														</div>
														<div class="col-4 mb-3">
															<button type="reset" id="delete-btn"
																class="form-control btn btn-outline-secondary">삭제</button>
														</div>
														<div class="col-3 mb-3">
															<c:choose>
																<c:when test="${user.small_code ==2 }">
																	<a class="form-control btn btn-outline-secondary"
																		href="/admin/user/userList">목록</a>
																</c:when>
																<c:when test="${user.small_code ==3 }">
																	<a class=" form-control btn btn-outline-secondary"
																		href="/admin/user/bizUserList">목록</a>
																</c:when>
															</c:choose>
														</div>
													</div>
												</div>
											</div>

											<div id="edit" style="display: none;">
												<div class="form-row d-flex justify-content-between  px-2">
													<div class="col-7  mb-3">
														<button type="submit" style="background-color:#9BDB04; border:1px solid #9BDB04"
															class="form-control btn btn-primary">수정완료</button>
													</div>
													<div class="col-5  mb-3 mx-3">
														<button type="reset" id="cancel-btn"
															class="cancel-btn form-control btn btn-outline-secondary"
															onclick="cancelBtnHandler()">취소</button>
													</div>
												</div>
											</div>

										</c:when>
									</c:choose>
								</form>
							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>


<!-- Modal -->
<div class="modal fade " id="exampleModal" tabindex="-1" aria-labelledby="label" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="modal-title">반려 전환</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
          <div class="mb-3">
            <label class="col-form-label">반려사유</label>
 			<textarea class="form-control" id="message-text"></textarea>
           </div>
     </div>
	   <div class="form-row d-flex justify-content-around modal-footer">
        <button type="button" onclick="submitRejectForm()" class="btn btn-primary col-4">반려</button>
        <button type="button" class="btn btn-outline-secondary col-4" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>

</body>
</html>