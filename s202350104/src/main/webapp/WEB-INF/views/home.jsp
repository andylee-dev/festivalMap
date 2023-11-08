<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Home</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<!-- Main Banner 임시 -->
	<div id="content_title" class="container border p-5">	
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
					<img src="../image/map1.png" class="d-block w-100" alt="..." style="width: 800px; height: 400px;">
				</div>
				<div class="carousel-item">
					<img src="../image/map2.png" class="d-block w-100" alt="..." style="width: 800px; height: 400px;">
				</div>
				<div class="carousel-item">
					<img src="../image/map3.png" class="d-block w-100" alt="..." style="width: 800px; height: 400px;">
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
	</div>	

	<!-- Section1 -->
	<div class="container border p-5">			
		컨텐츠 페이지입니다1
	</div>

	<!-- Section2 -->
	<div class="container border p-5">			
		컨텐츠 페이지입니다2
	</div>

	<!-- Section3 -->
	<div class="container border p-5">			
		<h2>컨텐츠 페이지입니다3</h2>
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
		
</body>
</html>