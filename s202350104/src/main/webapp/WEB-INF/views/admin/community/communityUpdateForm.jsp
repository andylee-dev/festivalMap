<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>communityUpdateForm</title>
<link rel="stylesheet" type="text/css"
	href="/css/adminContentsDetail.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
							<c:when test="${board.small_code eq 2 }">
								<label class="admin-header-title ">이달의소식&nbsp;상세&nbsp;정보</label>					
							</c:when>
							<c:when test="${board.small_code eq 3 }">
								<label class="admin-header-title ">자유게시판&nbsp;상세&nbsp;정보</label>				
							</c:when>
							<c:when test="${board.small_code eq 6 }">
								<label class="admin-header-title ">리뷰게시판&nbsp;상세&nbsp;정보</label>					
							</c:when>
						</c:choose>						
					</div>
				</div>


				<div class="container my-5" id="detail-body-container">
					<div>
						<c:choose>
							<c:when test="${board.small_code eq 2 }">
								<h1>이달의소식&nbsp;관리</h1>						
							</c:when>
							<c:when test="${board.small_code eq 3 }">
								<h1>자유게시판&nbsp;관리</h1>					
							</c:when>
							<c:when test="${board.small_code eq 6 }">
								<h1>리뷰게시판&nbsp;관리</h1>						
							</c:when>
						</c:choose>					

						<hr class="hr" />
					</div>
					
					<div>
						<c:choose>
							<c:when test="${board.small_code eq 2 }">
								<h3 style="color: #FF4379">이달의소식&nbsp;상세&nbsp;정보</h3>							
							</c:when>
							<c:when test="${board.small_code eq 3 }">
								<h3 style="color: #FF4379">자유게시판&nbsp;상세&nbsp;정보</h3>						
							</c:when>
							<c:when test="${board.small_code eq 6 }">
								<h3 style="color: #FF4379">리뷰게시판&nbsp;상세&nbsp;정보</h3>						
							</c:when>
						</c:choose>
					</div>
					
					<div class="my-5">
						<div class="" id="detail-main-container">
							<div class="container d-flex justify-content-content"
								 id="detail-top-container" style="width: 240px;">
								 <c:choose>
								 	<c:when test="${board.small_code eq 2}">
										<label id="detail-top-text" style="margin-right: 4px;">이달의매거진&nbsp;ㅣ </label> 								 	
								 	</c:when>
								 	<c:when test="${board.small_code eq 3}">
										<label id="detail-top-text" style="margin-right: 4px;">자유게시판&nbsp;ㅣ </label> 								 	
								 	</c:when>
								 	<c:when test="${board.small_code eq 6}">
										<label id="detail-top-text" style="margin-right: 4px;">리뷰게시판&nbsp;ㅣ </label> 								 	
								 	</c:when>
								 </c:choose>
								<label id="detail-top-text" style="margin-right: 4px;">${board.id}&nbsp;ㅣ</label>
								<c:choose>
									<c:when test="${board.status == 0}">
										<label id="detail-top-id2" style="color: #FF4379;">미사용</label>
									</c:when>
									<c:when test="${board.status == 1}">
										<label id="detail-top-id2">사용</label>
									</c:when>
								</c:choose>
							</div>
							<div class="container p-5" id="form-container">
								<form action="communityUpdate" method="post" enctype="multipart/form-data">
									<div class="mb-3">
										<label for="id" class="form-label">게시판&nbsp;ID</label> 
										<input type="text" class="form-control" name="id" id="id"
											   value="${board.id}" readonly> 
										<input type="hidden" name="status" value="${board.status }"> 
										<input type="hidden" name="is_deleted" value="${board.is_deleted }">
										<input type="hidden" name="userId" value="${userId}">
										<input type="hidden" name="name" value="${board.name}">
										<input type="hidden" name="file" value="">
									</div>

									<div class="mb-3 ">
										<label for="title" class="form-label">제목</label> 
										<input type="text" class="form-control" name="title" id="title"
											   value="${board.title} ">
									</div>

									<div class="mb-3 ">
										<label for="content" class="form-label">내용</label>
										<textarea class="form-control" name="content" id="content"
												  rows="5">${board.content}</textarea>
									</div>
									<c:if test="${board.small_code eq 3}">
									<div class="mb-3">
										<label for="file" class="mypost-form-label">첨부파일&nbsp;<span>${board.file_name_custom }</span></label><br>
										<input type="file" class="form-control img_input" name="file">
									</div>
								 	</c:if>

									<hr class="hr" />

									<div class="d-flex justify-content-center">
										<div class="col-3 mb-3" style="margin-right: 10px;">
											<button type="submit" class="form-control btn btn-primary2 w-100"
													onclick="return confirm('수정하시겠습니까?')">수정</button>
										</div>
										<div class="col-3 mb-3" style="margin-right: 10px;">
											<button type="reset" class="btn btn-outline-secondary w-100"
													onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
										</div>
										<div class="col-3 mb-3">
											<button type="button" class="btn btn-outline-secondary w-100"
													onclick="location.href='../community/communityDetail?id=${board.id}&userId=${userId}'">취소</button>
										</div>
									</div>
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