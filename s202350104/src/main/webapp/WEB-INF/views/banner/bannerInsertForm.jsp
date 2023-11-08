<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BannerInsertForm</title>
<!-- 부트스트랩 4.5.2 -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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

<script>
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
	
	function updateSmallCode(value) {
	    // ID를 사용하여 숨겨진 입력 필드를 가져옵니다.
	    var smallCodeInput = document.getElementById("small_code");

	    // 숨겨진 입력 필드의 값을 업데이트합니다.
	    smallCodeInput.value = value;
	}
</script>

</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>

	<div id="content_title" class="container p-5 mb-4 text-center">
		<h2>신규 배너 생성</h2>
		<c:if test="${msg!=null }">${msg }</c:if>
	</div>
	<div class="container mt-5">
		<form action="bannerInsert" method="post" enctype="multipart/form-data">
			<input type="hidden" name="user_id" value="${userId }"> 
			<input type="hidden" name="big_code" value="${bigCode }"> 
			<input type="hidden" name="small_code" id="small_code" value="${smallCode }">
			<div class="form-group">
				<label for="title">제목</label> 
				<input type="text" class="form-control" 
					   id="title" name="title" required>
			</div>
			<div class="form-group">
				<label for="content">내용</label>
				<textarea class="form-control" id="content" 
						  name="content" rows="4" required></textarea>
			</div>
			<div class="form-group">
				<label for="url">URL</label> 
				<input type="text" class="form-control" 
					   name="url" required>
			</div>
			<div class="form-group">
				<label for="image">이미지 첨부</label> 
				<input type="file" class="form-control" name="file">
			</div>			
			<div class="form-group">
				<label for="smallCode">소분류 코드</label><p>
					<input type="radio" name="smallCode" value="1"
						   onchange="updateSmallCode(1)"> Home 
					<input type="radio" name="smallCode" value="2" 
						   onchange="updateSmallCode(2)"> Footer 
					<input type="radio" name="smallCode" value="3"
						   onchange="updateSmallCode(3)"> Sidebar 
					<input type="radio" name="smallCode" value="4" 
						   onchange="updateSmallCode(4)"> Content
			</div>

			<button type="submit" class="btn btn-primary">등록</button>
			<button class="btn btn-secondary" onclick="closeAndRedirect()">취소</button>
		</form>
	</div>

</body>
</html>