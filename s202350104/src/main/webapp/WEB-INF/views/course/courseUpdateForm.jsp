<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>course UpdateForm</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
</script>

<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
</script>

</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	
	<div class="container mt-5">
		<div class="card">
			<div class="card_header">
				<h2>코스 수정</h2>
			</div>
			<div class="card-body">
				<form action="courseUpdate" method="post">
					<input type="hidden" name="id" value="${course.id }">
					<input type="hidden" name="course_title" value="${course.course_title }">
					<div class="mb-3">
						<label for="course_title" class="form-label">코스 명</label>
						<input type="text" id="course_title" name="course_title" class="form-control" required="required" value="${course.course_title }">
					</div>
					<div class="mb-3">
						<label for="distance" class="form-label">거리(km)</label>
						<input type="text" id="distance" name="distance" class="form-control" required="required" value="${course.distance }">
					</div>
					<div class="mb-3">
						<label for="course_info" class="form-label">코스 내용</label>
						<textarea class="form-control" id="course_info" name="course_info" rows="5">${course.course_info }</textarea>
					</div>
					<div class="text-center">
						<button type="submit" class="btn btn-primary">확인</button>
						<a href="#" class="btn btn-secondary" onclick="closeAndRedirect()">취소</a>
					</div>
				</form>
			</div>
		</div>
	
	
		<c:forEach var="courseContent" items="${courseContent }">
			<c:if test="${courseContent.order_num == 1}">
				<h1>${courseContent.course_title }</h1>
				<div class="container border p-5">
					<img alt="${courseContent.course_title }" src="${courseContent.img1 }">
				</div>
				<div class="container border p-5">
					<ul>
						<li>코스 이름 : ${courseContent.course_title }
						<li>코스 내용 : ${courseContent.course_info }
						<li>코스 거리 : ${courseContent.distance }
						<li>주 소 :	${courseContent.address }
						<li>전화번호 :	${courseContent.phone }
					</ul>
				</div>
			</c:if>
		</c:forEach>
	</div>
	
	<div>
		<c:forEach var="courseContent" items="${courseContent }">
		<div class="container border p-5">
			<a href='../${courseContent.cd_content.toLowerCase() }/detail?contentId=${courseContent.content_id}'>
				<img alt="${courseContent.course_title }" src="${courseContent.img1 }">
			</a>
			<ul>
				<li>코스이름 : <input type="text" id="title" name="title" value="${courseContent.title }"> 
				<li>개요 : <input type="text" id="content" name="content" value="${courseContent.content }">
				<li>홈페이지 : <input type="text" id="homepage" name="homepage" value="${courseContent.homepage }">
			</ul>
		</div>
		</c:forEach>
	</div>
	<!-- review test -->
	<div>
		<h3>review 구역</h3>
	</div>
</body>
</html>