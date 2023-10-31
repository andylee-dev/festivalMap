<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PhotoBoardDetail</title>
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
				<img src="../image/sea.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="../image/sea2.jpg" class="d-block w-100" alt="...">
			</div>
			<div class="carousel-item">
				<img src="../image/sea3.jpg" class="d-block w-100" alt="...">
			</div>
		</div>
		<button class="carousel-control-prev" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
			<span class="carousel-control-prev-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Previous</span>
		</button>
		<button class="carousel-control-next" type="button"
			data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
			<span class="carousel-control-next-icon" aria-hidden="true"></span> <span
				class="visually-hidden">Next</span>
		</button>
	</div>
<!-- 	<div id="content_title" class="container border p-5 mb-4">
	   <img src="../image/sea.jpg" class="card-img-top" alt="양양비치.jpg">
	</div> -->
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
<%-- 			<tr>
				<td colspan="2">
					<input type="button" value="수정" onclick="location.href='boardUpdateForm?id=${board.id}'">
					<input type="button" value="삭제" onclick="location.href='boardDelete?id=${board.id}'">
				</td>
			</tr> --%>
		</table>
	</div>
</body>
</html>