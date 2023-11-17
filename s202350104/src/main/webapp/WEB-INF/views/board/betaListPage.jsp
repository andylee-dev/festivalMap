<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%> 
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Beta List Page</title>
</head>
<body>
	<!-- 임시, 여백용-->
	<div id="content_title" class="container"></div>
	
	<!-- 상단 banner 영역 -->
	<div class="container p-0 banner_custom border" style="">
		<div id="carouselExampleIndicators" class="carousel slide"
			 data-bs-ride="carousel" data-bs-interval="3000" data-bs-pause="hover"
			 data-bs-wrap="true">
			 
			 <!-- 중앙 하단 버튼용 -->
			<div class="carousel-indicators">
				<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="0" class="active" aria-current="true"
						aria-label="Slide 1"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="1" aria-label="Slide 2"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="2" aria-label="Slide 3"></button>
			</div>
			
			<!-- 아이템 재료 영역 -->
			<div class="carousel-inner banner_img">
				<div class="carousel-item active">
					<img src="../image/BANNER1.png" class="d-block w-100" alt="메인배너1"/>
				</div>
				<div class="carousel-item">
					<img src="../image/BANNER2.png" class="d-block w-100" alt="메인배너2"/>
				</div>
				<div class="carousel-item">
					<img src="../image/BANNER3.png" class="d-block w-100" alt="메인배너3"/>
				</div>
			</div>
			
			<!-- 좌,우 버튼 영역 -->
			<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true">
					<img src="../image/arrowLeft.png" alt="Previous">
				</span> 
				<span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true">
					<img src="../image/arrowRight.png" alt="Next">
				</span> 
				<span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>
	
	<!-- 상단 분홍색 영역 -->
	<div class="container p-0 top_custom"></div>

	<!-- keyword, title 영역 -->	
	<div class="container p-0 keyword_title_custom border">
		<div class="co1 title_div">
					F E S T I V A L!</div>
		<div class="co1 text_div">
			<h4><strong>어느 축제로 떠나볼까요~♫</strong></h4>
		</div>
		<input class="form-control keyword_input" type="text" placeholder="가고 싶은 축제의 이름이나 키워드를 검색해보세요.">
		<img class="keyword_img" src="../image/icon_search1.png" alt="icon_search1.png"/>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container p-0">	

	<!-- select 영역 -->
	<div class="container p-0 select_custom">
		<div class="row g-2 text-center">
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom" aria-label="Default select example">
					<option selected>시,도 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom" aria-label="Default select example">
					<option selected>시,군,구 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom" aria-label="Default select example">
					<option selected>진행 기간 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom" aria-label="Default select example">
					<option selected>진행 여부 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
		</div>		
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">

	<!-- 목록 영역 -->
	<div class="container p-0 border">
		<div class="row row-cols-3 g-2 border">
			<div class="col d-flex justify-content-center border">
				<div class="card card_custom">
				  <div class="tag_custom" style="">	
					  <div class="tag_custom2" style="">
					  	<p class="tag_p">#지역태그</p>
					  </div>
				  </div>			
				  <img src="../photos/aquarium1.png" class="card-img-top" alt="이미지.jpg">
				  <div class="card-body">
				    <p class="card-text title_p">축제 제목</p>
				    <p class="card-text period_p">2023.00.00 ~ 00.00</p>
				    <p class="card-text contet_p">어쩌구저쩌구</p>
				  </div>
				</div>			
			</div>
			<div class="col d-flex justify-content-center border">
				<div class="card card_custom">
				  <div class="tag_custom" style="">	
					  <div class="tag_custom2" style="">
					  	<p class="tag_p">#지역태그</p>
					  </div>
				  </div>		
				  <img src="../photos/aquarium1.png" class="card-img-top" alt="이미지.jpg">
				  <div class="card-body">
				    <p class="card-text title_p">축제 제목</p>
				    <p class="card-text period_p">2023.00.00 ~ 00.00</p>
				    <p class="card-text contet_p">어쩌구저쩌구</p>
				  </div>
				</div>			
			</div>
			<div class="col d-flex justify-content-center border">
				<div class="card card_custom">
				  <div class="tag_custom" style="">	
					  <div class="tag_custom2" style="">
					  	<p class="tag_p">#지역태그</p>
					  </div>
				  </div>		
				  <img src="../photos/aquarium1.png" class="card-img-top" alt="이미지.jpg">
				  <div class="card-body">
				    <p class="card-text title_p">축제 제목</p>
				    <p class="card-text period_p">2023.00.00 ~ 00.00</p>
				    <p class="card-text contet_p">어쩌구저쩌구</p>
				  </div>
				</div>			
			</div>						
		</div>	
	</div>
	
			<div
			class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
			<!-- HeaderBanner by.엄민용 -->
			<c:forEach var="headers" items="${bannerHeader }">
				<c:choose>
					<c:when test="${headers.title == '축제' }">
						<img alt="축제_headerBanner" src="${headers.image }">
					</c:when>
				</c:choose>
			</c:forEach>
			<!-- HeaderBanner end -->
		</div>
		
				<!-- 검색 -->
		<form action="festival" method="post">
			<div class="border p-3 m-3">
				<select name="area" class="area-dropdown"></select> 
				<select name="sigungu" class="sigungu-dropdown"></select> 
				<input 	type="text" name="keyword" placeholder="키워드를 입력하세요.">

				<button type="submit" class="btn btn-outline-secondary">검색</button>
				<button type="reset" class="btn btn-outline-secondary">초기화</button>
			</div>
		</form>
		
				<!-- 정렬(만드는 중) -->
		<div align="right">
			<select name="ordering">
				<option value="o_id">기본순</option>
				<option value="o_title">이름순</option>
				<option value="o_readcount">조회순</option>
			</select>
		</div>
	
</body>
</html>