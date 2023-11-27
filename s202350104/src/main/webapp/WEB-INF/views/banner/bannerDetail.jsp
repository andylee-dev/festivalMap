<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>배너 상세 정보</title>
<link rel="stylesheet" type="text/css"
	href="/css/adminContentsDetail.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
		function confirmDelete(id) {
	        if (confirm('정말로 이 항목을 삭제하시겠습니까?')) {
	            $.ajax({
	                type: 'POST', // 또는 'POST' 등의 HTTP 메서드 사용 가능
	                url: 'bannerDelete',
	                data: { id: id },
	                success: function(result) {
	                    // 성공적으로 삭제된 경우의 처리
	                    alert('삭제되었습니다.');
	                },
	                error: function(xhr, status, error) {
	                    // 오류 발생 시의 처리
	                    alert('삭제에 실패했습니다.');
	                }
	            });
	        } else {
	            // 취소 버튼을 눌렀을 때의 처리
	            // 필요한 로직을 추가하세요.
	        }
	    }
		
		function confirmRestore(id) {
	        if (confirm('정말로 이 항목을 복원하시겠습니까?')) {
	            $.ajax({
	                type: 'POST', // 또는 'POST' 등의 HTTP 메서드 사용 가능
	                url: 'bannerRestore',
	                data: { id: id },
	                success: function(result) {
	                    // 성공적으로 복원된 경우의 처리
	                    alert('복원되었습니다.');
	                    location.reload();
	                },
	                error: function(xhr, status, error) {
	                    // 오류 발생 시의 처리
	                    alert('복원에 실패했습니다.');
	                }
	            });
	        } else {
	            // 취소 버튼을 눌렀을 때의 처리
	            // 필요한 로직을 추가하세요.
	        }
	    }
			
			function approveConfirm() {
				var contentId = Number(${experience.content_id});
				var status = "${experience.status}";
				if(confirm("승인하시겠습니까?")) {
					location.href="../content/experienceApprove?contentId="+contentId+"&currentPage=${currentPage}&status="+status;
				}
			}			
			
			function approveConfirm1() {
				var contentId = Number(${experience.content_id});
				var status = "${experience.status}";
				if(confirm("반려전환 하시겠습니까?")) {
					location.href="../content/experienceApprove?contentId="+contentId+"&currentPage=${currentPage}&status="+status;
				}
			}
			
			function openRejectionPopup(contentId) {
			    window.open("rejectionFoam?contentId=" + contentId, "_blank", "width=600, height=400, top=100, left=100");
			}
			
		</script>
<style type="text/css">
#detail-top-container {
	position: absolute;
	width: 250px;
	height: 83px;
	border-radius: 10px;
	border: 1px solid #000;
	flex-shrink: 0;
	top: -35px; /* B의 상단에 A를 위치시키기 위해 top을 0으로 설정 */
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

#detail-top-id {
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

#detail-top-id2 {
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

.form-label {
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
	background-color: #52525C;
	border-color: #52525C;
	color: #9BDB04;
}
</style>

</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
			<main class="col-10 p-0">
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-pencil-square "></i> <label
						   class="admin-header-title ">배너&nbsp;상세&nbsp;정보</label>
					</div>
				</div>


				<div class="container my-5" id="detail-body-container">
					<div>
						<h1>배너&nbsp;관리</h1>
						<hr class="hr" />
					</div>
					<div>
						<h3 style="color: #FF4379">배너별&nbsp;상세&nbsp;정보</h3>
					</div>
					<div class="my-5">
						<div class="" id="detail-main-container">
							<div class="container d-flex justify-content-content"
								 id="detail-top-container" style="width: 180px;">
								<label id="detail-top-text" style="margin-right: 4px;">배너&nbsp;ㅣ </label> 
								<label id="detail-top-text" style="margin-right: 4px;">${banner.id}&nbsp;ㅣ</label>
								<c:choose>
									<c:when test="${banner.status == 0}">
										<label id="detail-top-id2" style="color: #FF4379;">미사용중</label>
									</c:when>
									<c:when test="${banner.status == 1}">
										<label id="detail-top-id2">사용중</label>
									</c:when>
								</c:choose>
							</div>
							<div class="container p-5" id="form-container">
								<div class="mb-3">
									<label for="id" class="form-label">배너&nbsp;ID</label> 
									<input type="text" class="form-control" id="id" value="${banner.id}" readonly>
								</div>

								<div class="mb-3" id="detail-content-title">
									<label for="type" class="form-label">배너&nbsp;종류</label> 
									<input type="text" class="form-control" id="type" value="${banner.type}" readonly>
								</div>

								<div class="mb-3 ">
									<label for="title" class="form-label">제목</label> 
									<input type="text" class="form-control" id="title" value="${banner.title}" readonly>
								</div>

								<div class="mb-3 ">
									<label for="content" class="form-label">내용</label> 
									<input type="text" class="form-control" id="content" value="${banner.content}" readonly>
								</div>

								<div class="mb-3 ">
									<label for="url" class="form-label">URL</label> 
									<input type="text" class="form-control" id="url" value="${banner.url}" readonly>
								</div>

								<div class="mb-3 ">
									<label for="image" class="form-label">이미지</label><br> 
									<img alt="${banner.image }" src="${banner.image }"
										 style="width: 600px;" height="300px;">
								</div>

								<hr class="hr" />

								<div class="d-flex justify-content-between">

									<c:choose>
										<c:when test="${banner.status == 0}">
											<div class="col-6 mb-3">
												<button type="button" class="form-control btn btn-primary w-100"
														onclick="approveConfirm()">사용&nbsp;전환</button>
											</div>
											<div class="col-2 mb-3">
												<button type="button" class="btn btn-outline-secondary w-100"
													    onclick="confirmDelete(${banner.id})">삭제</button>
											</div>
											<div class="col-1 mb-3">
												<button type="button" class="btn btn-outline-secondary w-100"
													    onclick="location.href='admin/notice/banner'">목록</button>
											</div>
											<div class="col-1 mb-3"></div>
											<div class="col-1 mb-3"></div>											
										</c:when>

										<c:when test="${banner.status == 1}">
											<div class="col-6 mb-3">
												<button type="button"
													class="form-control btn btn-primary2 w-100"
													onclick="location.href='bannerUpdateForm?id=${banner.id}&currentPage=${currentPage}'">수정하기</button>
											</div>
											<div class="col-2 mb-3">
												<button type="button" class="btn btn-outline-secondary w-100"
														onclick="confirmDelete(${banner.id})">삭제</button>
											</div>
											<div class="col-1 mb-3">
												<button type="button" class="btn btn-outline-secondary w-100"
														onclick="location.href='admin/notice/banner'">목록</button>
											</div>
											<div class="col-1 mb-3"></div>
											<div class="col-1 mb-3"></div>
										</c:when>
									</c:choose>

									<%-- <c:if test="${experience.status == 0}">
	                          <div class="col-6 mb-3" >
	                              <button type="button" class="form-control btn btn-primary w-100" onclick="approveConfirm()">승인(게시하기)</button>
	                          </div>
	                            <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="">대기(임시저장)</button>
	                          </div>
	                          <div class="col-2 mb-3">
	                              <button type="button" class="btn btn-outline-secondary w-100" onclick="openRejectionPopup(${experience.content_id})">반려(사유선택)</button>
	                          </div>
	                          <div class="col-1 mb-3">
	                              <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/experience?currentPage=1'">삭제</button>
	                          </div>
	                         </c:if>
	                         <c:if test="${experience.status == 1}">
	                             <div class="col-6 mb-3">
	                                <button type="button" class="form-control btn btn-primary2 w-100" onclick="location.href='../content/experienceUpdateForm?contentId=${experience.content_id}&currentPage=${currentPage}'">수정하기</button>
	                             </div>
	                             <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="">반려전환</button>
	                             </div>
	                             <div class="col-2 mb-3">
	                                <button type="button" class="btn btn-outline-secondary w-100" onclick="confirmDelete(${experience.content_id})">삭제</button>
	                             </div>
	                          <div class="col-1 mb-3">
	                             <button type="button" class="btn btn-outline-secondary w-100" onclick="location.href='../content/experience?currentPage=1'">목록</button>
	                          </div>
	                         </c:if> --%>
								</div>


							</div>
						</div>
					</div>
				</div>
			</main>
		</div>
	</div>
</body>
</html>