<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PhotoEventBoardDetail</title>
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
	function deleteAndRedirect(id, smallCode, userId) {
	    $.ajax({
	        url: 'boardDelete?id=' + id + '&smallCode=' + smallCode + '&userId=' + userId,
	        method: 'GET',
	        success: function () {
	            // 삭제 요청이 성공 후 부모 창 redirect
	           	if (smallCode === 5) {
	                // 이벤트 게시판으로 리디렉션
	                window.opener.location.href = '/eventBoardList';
	            } else {
	                // 그 외의 경우, 포토 게시판으로 리디렉션
	                window.opener.location.href = '/photoBoardList';
	            }
		        window.close();
	        }
	    });
	}
	
	function updateBoard(boardId) {
	    window.opener.location.href = 'boardUpdateForm?id=' + boardId;
	    window.close();
	}

	function closeAndRedirect(smallCode) {
	    $.ajax({
	        url: '/',
	        method: 'GET',
	        success: function () {
	            // 취소 버튼 실행 시 이전페이지 이동 + 새로고침
	           	if (smallCode === 4) {
	                // 포토게시판으로 리디렉션
	                window.opener.location.href = '/photoBoardList';
	            } else if(smallCode === 5) {
	            	// 이벤트게시판으로 리디렉션
	                window.opener.location.href = '/eventBoardList';
	            } else{
	            	// 기본 & 오류 처리
	            	window.opener.location.href = '/home';
	            }
	           	window.close();
	        }
	    });
	}
	<!-- 게시판 신고기능 -송환 -->
	function report(boardId) {
	    window.open("reportBoardFoam?boardId=" + boardId, "_blank", "width=600, height=400, top=100, left=100");
	}
</script>
</head>
<body>
	<div id="carouselExampleIndicators" class="carousel slide">
		<div class="carousel-indicators">
			<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="0" class="active" aria-current="true"
					aria-label="Slide 1"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="1" aria-label="Slide 2"></button>
			<button type="button" data-bs-target="#carouselExampleIndicators"
					data-bs-slide-to="2" aria-label="Slide 3"></button>
		</div>
		<div class="carousel-inner">
			<div class="carousel-item active">
				<img src="../image/sea.jpg" class="d-block w-100" alt="..." style="width: 800px; height: 400px;">
			</div>
			<div class="carousel-item">
				<img src="../image/sea2.jpg" class="d-block w-100" alt="..." style="width: 800px; height: 400px;">
			</div>
			<div class="carousel-item">
				<img src="../image/sea3.jpg" class="d-block w-100" alt="..." style="width: 800px; height: 400px;">
			</div>
		</div>
		<button class="carousel-control-prev" type="button" 
				data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> 
			<span class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
				data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span>
			<span class="visually-hidden">Next</span>
		</button>
	</div>
	<div class="container border p-5">
		<table class="table">
			<tr>
				<th scope="col">제목</th>
				<td>${board.title }</td>
				<th scope="col">작성자</th>
				<td>${board.name }</td>
			</tr>
			<tr>
				<th scope="col">내용</th>
				<td>${board.content }</td>
			</tr>
		</table>
	</div>
	<div class="text-center">
		<button class="btn btn-primary" onclick="updateBoard(${board.id})">수정</button>
		<button class="btn btn-danger" onclick="deleteAndRedirect(${board.id}, ${board.small_code}, ${userId })">삭제</button>
		<button class="btn btn-secondary" onclick="closeAndRedirect(${board.small_code })">취소</button>
		<!-- 게시판 신고기능 -송환 -->
		<button class="btn btn-secondary" onclick="report(${board.id})">신고</button>
	</div>
</body>
</html>