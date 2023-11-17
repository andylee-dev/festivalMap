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
</style>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  $(document).ready(function () {
	    $("#edit-btn").click(function() {
	        $(".form-input").prop("disabled", false);
	        $("#submit-btn, #cancel-btn").show();
	        $(this).hide();
	    });

	    $("#cancel-btn").click(function() {
	        $(".form-input").prop("disabled", true);
	        $("#submit-btn, #cancel-btn").hide();
	        $("#edit-btn").show();
	    });
  });
</script>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
			<main class="col-10 overflow-auto p-0">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-people-fill "></i> <label
							class="admin-header-title ">일반 회원( ${user.name} )</label>
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
							<div class="container" id="detail-top-container">
								<label id="detail-top-text">회원 | 일반</label>
							</div>
							<div class="container p-5 mx-3" id="form-container">
							    <form action="/admin/user/updateUser" method="POST">
							        <div class="form-row">
							            <div class="col-md-6 mb-3">
							                <label for="name" class="form-label">이름</label>
							                <input type="text" class="form-control form-control-lg form-input" id="name" value="ahaha" disabled>
							            </div>								
							            <div class="col-md-6 mb-3">
							                <label for="nickname" class="form-label">닉네임</label>
							                <input type="text" class="form-control form-control-lg form-input" id="nickname" value="ahaha" disabled>
							            </div>								
							        </div>
							        <div class="form-row">
							            <div class="mb-3">
							                <label for="email" class="form-label">이메일</label>
							                <input type="email" class="form-control form-control-lg form-input" id="email" value="ahaha" disabled>
							            </div>								
							        </div>		
							        <div class="form-row d-flex justify-content-between">
							            <div class="col-7  mb-3">
									        <button type="submit" id="submit-btn" class="form-control btn btn-primary"style="display: none;">수정완료</button>						
							            </div>
							            <div class="col-4 mb-3">
									        <button type="reset" id="cancel-btn" class="form-control btn btn-primary"style="display: none;">취소</button>	
							            </div>
									</div>
									<button type="submit" id="edit-btn" class="btn btn-primary" onclick="event.preventDefault();">수정하기</button>					
							    </form>							
							</div>

						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>