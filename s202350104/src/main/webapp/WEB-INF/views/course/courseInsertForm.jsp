<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>   

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>course Insert</title>
<!-- 부트스트랩 4.5.2 -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<!-- 부트스트랩 5.3.1-->
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

<script type="text/javascript">
	function closeAndRedirect() {
	// 취소 시 이전페이지 이동
	window.history.back();
</script>
	
</head>
<body>
	<h1>여기는 코스 등록 화면입니다.</h1>
	<div class="container mt-5">
		<form action="courseInsert" method="post" enctype="multipart/form-data">
			<div class="form-group">
				<label for="course_title">코스명</label>
				<input type="text" class="form-control" id="course_title" name="course_title" required="required">
			</div>
			<div class="form-group">
				<label for="img1">사진등록(업로드 기능 추가 필요~~~~)ㅠㅠ......</label><p><p><p><p>
			
			</div>
			<div class="form-group">
				<label for="distance">거리(km)</label>
				<input type="text" class="form-control" id="distance" name="distance" required="required">
			</div>
			<div class="form-group">	
				<label for="course_info">코스 설명</label>
				<textarea class="form-control" id="course_info" name="course_info" rows="5"></textarea>
			</div>
			<div class="form-group">	
				<label for="tag">태그 등록~~~~(수정 필요)</label><p><p><p><p>
			
			</div>
			<div class="text-center">
				<button type="submit" class="btn btn-primary">등록</button>
				<button class="btn btn-secondary" onclick="closeAndRedirect()">취소</button>
			</div>
		</form>
	</div>
</body>
</html>