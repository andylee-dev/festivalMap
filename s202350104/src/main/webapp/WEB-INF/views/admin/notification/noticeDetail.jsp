<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>communityDetail</title>
<link rel="stylesheet" type="text/css"
	href="/css/adminContentsDetail.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
		function confirmDelete(id) {
	        if (confirm('정말로 이 항목을 삭제하시겠습니까?')) {
	            $.ajax({
	                type: 'POST', // 또는 'POST' 등의 HTTP 메서드 사용 가능
	                url: 'noticeDelete',
	                data: { id: id},
	                success: function(result) {
	                    // 성공적으로 삭제된 경우의 처리
	                    alert('삭제되었습니다.');
	                    location.reload();
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
	                url: 'noticeRecycle',
	                data: { id: id},
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
						<i class="title-bi bi bi-pencil-square "></i> 
						<c:choose>
							<c:when test="${board.small_code eq 1 }">
								<label class="admin-header-title ">공지사항&nbsp;상세정보</label>					
							</c:when>
							<c:when test="${board.small_code eq 5 }">
								<label class="admin-header-title ">이벤트&nbsp;상세정보</label>				
							</c:when>
						</c:choose>						
					</div>
				</div>


				<div class="container my-5" id="detail-body-container">
					<div>
						<c:choose>
							<c:when test="${board.small_code eq 1 }">
								<h1>공지사항&nbsp;관리</h1>						
							</c:when>
							<c:when test="${board.small_code eq 5 }">
								<h1>이벤트&nbsp;관리</h1>					
							</c:when>

						</c:choose>					

						<hr class="hr" />
					</div>
					
					<div>
						<c:choose>
							<c:when test="${board.small_code eq 1 }">
								<h3 style="color: #FF4379">공지사항&nbsp;상세정보</h3>							
							</c:when>
							<c:when test="${board.small_code eq 5 }">
								<h3 style="color: #FF4379">이벤트&nbsp;상세정보</h3>						
							</c:when>
						</c:choose>
					</div>
					
					<div class="my-5">
						<div class="" id="detail-main-container">
							<div class="container d-flex justify-content-content"
								 id="detail-top-container" style="width: 240px;">
								 <c:choose>
								 	<c:when test="${board.small_code eq 1}">
										<label id="detail-top-text" style="margin-right: 4px;">공지사항&nbsp;ㅣ </label> 								 	
								 	</c:when>
								 	<c:when test="${board.small_code eq 5}">
										<label id="detail-top-text" style="margin-right: 4px;">이벤트&nbsp;ㅣ </label> 								 	
								 	</c:when>
								 </c:choose>
								<label id="detail-top-text" style="margin-right: 4px;">${board.id}&nbsp;ㅣ</label>
								<c:choose>
									<c:when test="${board.status == 0}">
										<label id="detail-top-id2" style="color: #FF4379;">미사용중</label>
									</c:when>
									<c:when test="${board.status == 1}">
										<label id="detail-top-id2">사용중</label>
									</c:when>
								</c:choose>
							</div>
							<div class="container p-5" id="form-container">
								<div class="mb-3">
									<label for="id" class="form-label">게시판&nbsp;ID</label> 
									<input type="text" class="form-control" id="id" value="${board.id}" readonly>
								</div>
								
								<div class="mb-3">
									<label for="name" class="form-label">작성자</label> 
									<input type="text" class="form-control" id="name" value="${board.name}" readonly>
								</div>

								<div class="mb-3 ">
									<label for="title" class="form-label">제목</label> 
									<input type="text" class="form-control" id="title" value="${board.title}" readonly>
								</div>

								<div class="mb-3 ">
									<label for="content" class="form-label">내용</label> 
									<input type="text" class="form-control" id="content" value="${board.content}" readonly>
								</div>
								
								<c:if test="${board.small_code eq 5 }">
								<div class="mb-3 ">
									<label for="image" class="form-label">이미지</label><br> 
									<img alt="${board.file_name }" src="../${board.file_path }${board.file_name}"
										 style="width: 600px;" height="300px;">
								</div>
								</c:if>
								<hr class="hr" />

								<div class="d-flex justify-content-center">

									<c:choose>
										<c:when test="${board.status == 0}">
											<div class="col-3 mb-3" style="margin-right: 10px;">
												<button type="button" class="form-control btn btn-primary w-100"
														onclick="confirmRestore(${board.id})">사용&nbsp;전환</button>
											</div>

											<div class="col-3 mb-3">
												<c:choose>
												<c:when test="${board.small_code eq 1 }">
												<button type="button" class="btn btn-outline-secondary w-100"
														onclick="location.href='../notice/notice?currentPage=1'">목록</button>												
												</c:when>
												<c:when test="${board.small_code eq 5 }">
												<button type="button" class="btn btn-outline-secondary w-100"
														onclick="location.href='../notice/event?currentPage=1'">목록</button>												
												</c:when>
												</c:choose>
											</div>									
										</c:when>

										<c:when test="${board.status == 1}">
											<div class="col-3 mb-3" style="margin-right: 10px;">
												<button type="button"
													class="form-control btn btn-primary2 w-100"
													onclick="location.href='noticeUpdateForm?id=${board.id}&userId=${userId }'">수정하기</button>
											</div>
											
											<div class="col-3 mb-3" style="margin-right: 10px;">
												<button type="button" class="btn btn-outline-secondary w-100"
														onclick="confirmDelete(${board.id})">삭제</button>
											</div>
											
											<div class="col-3 mb-3">
												<c:choose>
												<c:when test="${board.small_code eq 1 }">
												<button type="button" class="btn btn-outline-secondary w-100"
														onclick="location.href='../notice/notice?currentPage=1'">목록</button>												
												</c:when>
												<c:when test="${board.small_code eq 5 }">
												<button type="button" class="btn btn-outline-secondary w-100"
														onclick="location.href='../notice/event?currentPage=1'">목록</button>												
												</c:when>
												</c:choose>
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
</body>
</html>