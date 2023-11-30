<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPostUpdateForm</title>
<link rel="stylesheet" type="text/css" href="/css/myPost.css">
<link rel="stylesheet" type="text/css" href="/css/adminTable.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
	<main>
		<div class="d-flex">
			<div class="col-2">
				<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			</div>
			<div class="container p-5 col-10">

				<!-- Section1: Title -->
				<div class="container my-5">
					<c:choose>
						<c:when test="${board.small_code eq 6}">
							<h1>${board.content}</h1>
						</c:when>
						<c:otherwise>
							<h1>${board.title}</h1>
						</c:otherwise>
					</c:choose>
					<hr class="hr" />
					
					<div class="container mypost-content-custom">
						<form action="myPostUpdate" method="post" enctype="multipart/form-data">
								<input type="hidden" name="id" value="${board.id }"> 
								<input type="hidden" name="status" value="${board.status }"> 
								<input type="hidden" name="is_deleted" value="${board.is_deleted }">
								<input type="hidden" name="userId" value="${userId}">
								<input type="hidden" name="name" value="${board.name}">						
							<div>
								<div class="mb-3">
									<c:choose>
										<c:when test="${board.small_code eq 6}">
											<label for="content" class="mypost-form-label">내용</label>
											<input type="text" class="form-control text-box"
												name="content" value="${board.content} ">
										</c:when>
										<c:otherwise>
											<label for="title" class="mypost-form-label">제목</label>
											<input type="text" class="form-control text-box" name="title"
												value="${board.title} ">
										</c:otherwise>
									</c:choose>
								</div>
								<c:if test="${board.small_code eq 3}">
									<div class="mb-3">
										<label for="content" class="mypost-form-label">내용</label>
										<textarea class="form-control" name="content" rows="5">${board.content}</textarea>
									</div>

									<div class="mb-3">
										<label for="file" class="mypost-form-label">첨부파일&nbsp;<span>${board.file_name_custom }</span></label><br>
										<input type="file" class="form-control img_input" name="file">
									</div>
								</c:if>
							</div>
							<hr class="hr" />
							<div class="d-flex justify-content-center">
								<div class="col-3 mb-3" style="margin-right: 10px;">
									<button type="submit"
										class="form-control btn btn-primary2 w-100"
										onclick="return confirm('수정하시겠습니까?')">수정</button>
								</div>
								<div class="col-3 mb-3" style="margin-right: 10px;">
									<button type="reset" class="btn btn-outline-secondary w-100"
										onclick="return confirm('입력하신 내용이 초기화됩니다. 정말 진행하시겠습니까?')">초기화</button>
								</div>
								<div class="col-3 mb-3">
									<button type="button" class="btn btn-outline-secondary w-100"
										onclick="location.href='../myPage/myPostDetail?id=${board.id}&userId=${userId}'">취소</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>