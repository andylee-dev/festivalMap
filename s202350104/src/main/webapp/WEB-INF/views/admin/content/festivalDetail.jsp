<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축제 상세 정보</title>
		<link rel="stylesheet" type="text/css" href="/css/adminContentsDetail.css">
		<style type="text/css">
			#detail-top-container {
				position: absolute;
				width: 360px;
				height: 83px;
				border-radius: 10px;
				border: 1px solid #000;
				flex-shrink: 0;
				top: -35px; 
				margin: auto; 
				z-index: -1;
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
			
			#detail-top-id{
				color: #FF4379;
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				letter-spacing: -0.48px;
				padding-top: 5px;
				word-wrap: break-word;
			}	
			
			#detail-top-id2{
				color: #BDEB50;
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				letter-spacing: -0.48px;
				padding-top: 5px;
				word-wrap: break-word;
			}	
			
			#detail-top-id3 {
				color: red;
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				letter-spacing: -0.48px;
				padding-top: 5px;
				word-wrap: break-word;
			}
			
			#detail-main-container {
				position: relative;
				border: 1px solid #000;
				border-radius: 10px;
				background-color: white;
			}
			
			.detail-body-container {
				justify-content: center;
				padding-right: 0;
				padding-left: 0;
				margin-right: 0;
				margin-left: 0;
			}
			
			.form-label{
				color: #000;
				font-family: Noto Sans;
				font-size: 16px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
			}
			
			h1 {
				color: black;
				font-size: 32px;
				font-family: Noto Sans;
				font-weight: 600;
				word-wrap: break-word
			}
			
			h3 {
				color: #FF4379;
				font-size: 24px;
				font-family: Noto Sans;
				font-weight: 600;
				word-wrap: break-word
			}
			
			.btn-primary2 {
			    background-color: #9BDB04; 
			    border-color: #9BDB04; 
			    color: white;
			}
			
			.btn-primary2:hover {
			    background-color: #52525C ; 
			    border-color: #52525C; 
			    color: #9BDB04;
			}
		</style>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteConfirm() {
				var contentId = Number(${festival.content_id}); 
				var is_deleted = "${festival.is_deleted}";
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href="../content/festivalDelete?contentId="+contentId+"&currentPage=${currentPage}&is_deleted="+is_deleted;
				}
			}
			
			function deleteConfirm1() {
				var contentId = Number(${festival.content_id}); 
				var is_deleted = "${festival.is_deleted}";
				if(confirm("복원 하시겠습니까?")) {
					location.href="../content/festivalDelete?contentId="+contentId+"&currentPage=${currentPage}&is_deleted="+is_deleted;
				}
			}
			
			function approveConfirm() {
				var contentId = Number(${festival.content_id}); 
				var status = "${festival.status}";
				if(confirm("승인하시겠습니까?")) {
					location.href="festivalApprove?contentId=${festival.content_id}&currentPage=${currentPage}&status="+status;
				}
			}
			
			function approveConfirm1() {
				var contentId = Number(${festival.content_id}); 
				var status = "${festival.status}";
				if(confirm("반려전환 하시겠습니까?")) {
					location.href="festivalApprove?contentId=${festival.content_id}&currentPage=${currentPage}&status="+status;
				}
			}
			
			function submitRejectForm(formName) {
				// $('#statusInput').value = 0;
				formName.action = "/admin/content/insertHistory";
				formName.method = "post";
				$('.form-input, .check-duple').prop("disabled", false);
				
				$('#rejectModal').modal('hide');
				
				const rejectContent = document.getElementById('message-text').value;
				const rejectTitle = document.getElementById('modal-title').innerText;		
				$('#reject-title').val(rejectTitle);
				$('#reject-content').val(rejectContent);
				
				formName.submit();
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
						<i class="title-bi bi bi-pencil-square "></i>
						<label class="admin-header-title ">축제 상세 정보</label>					
					</div>
				</div>
				
				<!-- Section2: Table -->		
				<div class="container my-5" id="detail-body-container">
					<div>
						<h1>축제 관리</h1>
						<hr class="hr">
					</div>
					<div>
						<h3 style="color: #FF4379">축제별 상세 정보</h3>
					</div>
					<div class="my-5">
					<div class="" id="detail-main-container">
						<div class="container d-flex justify-content-around" id="detail-top-container">
							<label id="detail-top-text">축제 ㅣ </label>
							<label id="detail-top-text">${festival.scode_content} ㅣ </label>
							<label id="detail-top-text">${festival.content_id}</label>
							<c:choose>
								<c:when test="${festival.is_deleted == 1}">
									<label id="detail-top-id3">삭제(숨김)</label>
								</c:when>
								<c:when test="${festival.status == 0}">
									<label id="detail-top-id">승인대기</label>
								</c:when>
								<c:when test="${festival.status == 1}">
									<label id="detail-top-id2">승인(게시중)</label>
								</c:when>
							</c:choose>
						</div>
						<div class="container p-5" id="form-container">
							<div class="mb-3">
								<label for="title" class="form-label">축제명</label>
								<input type="text" class="form-control" id="title" value="${festival.title}" readonly>
							</div>
							<div class="mb-3">
								<label for="period" class="form-label">축제기간</label>
									<div class="row">
										<div class="col-3">
											<input type="date" class="form-control" id="start_date" value="${festival.start_date}">
										</div>
										<div class="col-3">
											<input type="date" class="form-control" id="end_date" value="${festival.end_date}">
										</div>
									</div>
							</div>
							<div class="mb-3">
								<label for="sponsor" class="form-label">주최</label>
								<input type="text" class="form-control" id="sponsor" value="${festival.sponsor}">
							</div>
							<div class="mb-3">
								<label for="eventplace" class="form-label">장소</label>
								<div class="row">
									<div class="col-2">
										<input type="text" class="form-control" id="area" value="${festival.area_content}">
									</div>
									<div class="col-2">
										<input type="text" class="form-control" id="sigungu" value="${festival.sigungu_content}"> 
									</div>
									<div class="col-4">
										<input type="text" class="form-control" id="address" value="${festival.address}">
									</div>
									<div class="col-4">
										<input type="text" class="form-control" id="eventplace" value="${festival.eventplace}">
									</div>
								</div>
							</div>
							<div class="mb-3">
								<label for="homepage" class="form-label">홈페이지</label>
								<input type="text" class="form-control" id="homepage" value="${festival.homepage}">
							</div>
							<div class="mb-3">
								<div class="row">
									<div class="col-6">
										<label for="phone" class="form-label">전화번호</label>
										<input type="text" class="form-control" id="phone" value="${festival.phone}">
									</div>
									<div class="col-6">
										<label for="email" class="form-label">이메일</label>
										<input type="text" class="form-control" id="email" value="${festival.email}">
									</div>
								</div>
							</div>
							<div class="mb-3">
								<label for="content" class="form-label">축제 개요</label>
								<textarea rows="5" class="form-control" id="content">${festival.content}</textarea>
							</div>
							<div class="mb-3">
								<label for="overview" class="form-label">상세 내용</label>
								<textarea rows="5" class="form-control" id="overview">${festival.overview}</textarea>
							</div>		
							
							<div class="mb-3">
								<label for="hours" class="form-label">진행시간</label>
								<input type="text" class="form-control" id="hours" value="${festival.hours}">
							</div>
							<div class="mb-3">
								<label for="cost" class="form-label">이용요금</label>
								<input type="text" class="form-control" id="cost" value="${festival.cost}">
							</div>
							
							<div class="mb-3">
								<label for="images" class="form-label">등록 이미지</label>
								<%-- <img alt="${festival.title}이미지1" src="${festival.img1}"><br>
								<img alt="${festival.title}이미지2" src="${festival.img2}"><br>
								<img alt="${festival.title}이미지3" src="${festival.img3}"></td> --%>
							</div>
	
							<div class="mb-3">
								<label for="facilities" class="form-label">부대/편의 시설</label>
								<div class="col-12 d-flex justify-content-between">
							  		<div class="col-3 form-check">
							  			<input class="form-check-input" type="checkbox" name="is_parking"
							  			 id="is_parking" value="${festival.is_parking == 1? 'checked':''}" disabled>
							  			<label class="form-check-label" for="is_parking">주차여부</label>
							  		</div>
							  		<div class="col-3 form-check">
							  			<input class="form-check-input" type="checkbox" name="is_stroller"
							  			 id="is_stroller" value="${festival.is_stroller == 1? 'checked':''}" disabled>
							  			<label class="form-check-label" for="is_stroller">유아차 대여</label>
							  		</div>
							  		<div class="col-3 form-check">
							  			<input class="form-check-input" type="checkbox" name="is_wheelchair"
							  			 id="is_wheelchair" value="${festival.is_wheelchair == 1? 'checked':''}" disabled>
							  			<label class="form-check-label" for="is_wheelchair">휠체어 대여</label>
							  		</div>
							  		<div class="col-3 form-check">
							  			<input class="form-check-input" type="checkbox" name="is_restroom"
							  			 id="is_restroom" value="${festival.is_restroom == 1? 'checked':''}" disabled>
							  			<label class="form-check-label" for="is_restroom">장애인 화장실</label>
							  		</div>
							  	</div>
							</div>
							<div class="mb-3">
								<div class="row">
									<div class="col-6">
										<label for="user_id" class="form-label">신청자ID</label>
										<input type="text" class="form-control" id="user_id" value="${festival.user_id}">
									</div>
									<div class="col-6">
										<label for="created_at" class="form-label">신청일</label>
										<input type="text" class="form-control" id="created_at" value="<fmt:formatDate value="${festival.created_at}" type="date" pattern="YY/MM/dd"/>">
									</div>
								</div>
							</div>
							<form name="updateForm">
								<input type="hidden" name="status" id="statusInput" value="${festival.status}">
								<input type="hidden" name="big_code" value="${festival.big_code}">
								<input type="hidden" name="small_code" value="${festival.small_code}">
								<input type="hidden" name="target_id" value="${festival.content_id}">
								<input type="hidden" name="title" id="reject-title">
								<input type="hidden" name="content" id="reject-content">
							</form>
							
							<div>
								<hr class="hr">
							</div>
							
							<div class="d-flex justify-content-between">
								<c:choose>
									<c:when test="${festival.is_deleted == 1}">
										<div class="col-6 mb-3">
											<button type="button" class="form-control btn btn-primary w-100" onclick="deleteConfirm1()">복원</button>
										</div>
										<div class="col-6 mb-3">
											<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='festival'">취소</button>
										</div>
									</c:when>
									<c:when test="${festival.status == 0}">
										<div class="col-6 mb-3">
											<button type="button" class="form-control btn btn-primary w-100" onclick="approveConfirm()">승인(게시하기)</button>
										</div>
										<div class="col-3 mb-3">
											<button type="button" class="btn btn-outline-secondary w-100" data-bs-toggle="modal" data-bs-target="#rejectModal">반려(사유선택)</button>
										</div>
										<div class="col-3 mb-3">
											<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='festival'">목록</button>
										</div>
									</c:when>
									<c:when test="${festival.status == 1}">
										<div class="col-6 mb-3">
											<button type="button" class="form-control btn btn-primary w-100" onclick="location.href='festivalUpdateForm?contentId=${festival.content_id}&currentPage=${currentPage}'">수정하기</button>
										</div>
										<div class="col-2 mb-3">
											<button type="button" class="btn btn-outline-secondary w-100" onclick="approveConfirm1()">반려전환</button>
										</div>
										<div class="col-2 mb-3">
											<button type="button" class="btn btn-outline-secondary w-100" onclick="deleteConfirm()">삭제</button>
										</div>
										<div class="col-1 mb-3">
											<button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='festival'">목록</button>
										</div>
									</c:when>
								</c:choose>
							</div>
						</div>
						</div>
					</div>
				</div>		
			</main>
		</div>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="rejectModal" tabindex="-1" aria-labelledby="label" aria-hidden="true">
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
						<button type="button" onclick="submitRejectForm(updateForm)" class="btn btn-primary col-4">반려</button>
						<button type="button" class="btn btn-outline-secondary col-4" data-bs-dismiss="modal">취소</button>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>