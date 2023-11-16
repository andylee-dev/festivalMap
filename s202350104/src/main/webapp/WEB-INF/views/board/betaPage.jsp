<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1">
<title>Beta Page</title>
<!-- 리뷰 슬라이딩 라이브러리  owl.carousel -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/owl.carousel.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/assets/owl.carousel.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/owl.carousel@2.3.4/dist/assets/owl.theme.default.min.css">
 
<style type="text/css">
.form-select {
	width: 200px;
	border: 2px black solid;
	border-radius: 23.50px;
	margin-bottom: 5px;
	border: 2px black solid;
}


</style>
<script type="text/javascript">
    $(document).ready(function () {
        $(".custom-carousel").owlCarousel({
            autoWidth: true,
            loop: true
        });
/*         $(".custom-carousel .card").click(function () {
            $(".custom-carousel .card").not($(this)).removeClass("card");
            $(this).toggleClass("card");
        }); */
    });

    
</script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<!-- 임시 -->
	<div id="content_title" class="container">
	</div>
	
	<!-- banner 영역 -->
	<div class="container p-0 border" style="width: 100%; height: 400px; margin-top:100px;">
		<div id="carouselExampleIndicators" class="carousel slide"
			 data-bs-ride="carousel" data-bs-interval="3000" data-bs-pause="hover"
			 data-bs-wrap="true">
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
					<img src="../image/BANNER1.png" class="d-block w-100" alt="메인배너1"
						 style="width: 100%; height: 400px" />
				</div>
				<div class="carousel-item">
					<img src="../image/BANNER2.png" class="d-block w-100" alt="메인배너2"
						 style="width: 100%; height: 400px" />
				</div>
				<div class="carousel-item">
					<img src="../image/BANNER3.png" class="d-block w-100" alt="메인배너3"
						 style="width: 100%; height: 400px" />
				</div>
			</div>
			<button class="carousel-control-prev" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				<span class="carousel-control-prev-icon" aria-hidden="true">
					<img src="../image/arrowLeft.png" alt="Previous">
				</span> <span class="visually-hidden">Previous</span>
			</button>
			<button class="carousel-control-next" type="button"
					data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				<span class="carousel-control-next-icon" aria-hidden="true">
					<img src="../image/arrowRight.png" alt="Next">
				</span> <span class="visually-hidden">Next</span>
			</button>
		</div>
	</div>
	
	<!-- 분홍색 영역 -->
	<div class="container p-0" style="width: 100%; height: 80px; background-color: #FF4379;">
	
	</div>
	
	<!-- 배지, 타이틀 영역 -->	
	<div class="container border p-0" style="height:80px; position: relative;">
		<div class="co1" style="width: 140px; height: 30px; border-radius: 23.50px; border: 3px white solid; 
					display: flex; align-items: center; justify-content: center; background-color: #FF4379; 
					color: white; font-weight: bold; margin-left: 10px; margin-top: 10px;">
					F E S T I V A L!</div>
		<div class="co1" style="margin-left: 15px; flex: 1;">
			<h4><strong>어느 축제로 떠나볼까요~♫</strong></h4>
		</div>
		<input class="form-control" type="text" placeholder="가고 싶은 축제의 이름이나 키워드를 검색해보세요."
			   style="width: 30%; border:none; position: absolute; right: 25px; top: 68%; transform: translateY(-50%);">
		<img style="width: 20px; height: 19px; right: 10px; top: 70%; position:absolute; transform: translateY(-50%);" src="../image/icon_search1.png" alt="test"/>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container p-0" style="border-color: black; border-width: 4px;">
	
	<!-- 셀렉터 영역 -->
	<div class="container p-0" style="height: 50px;">
		<div class="row g-2 text-center">
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3" aria-label="Default select example"
						style="font-size:20px; font-weight: bolder;">
					<option selected>시,도 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3" aria-label="Default select example"
						style="font-size:20px; font-weight: bolder;">
					<option selected>시,군,구 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3" aria-label="Default select example"
						style="font-size:20px; font-weight: bolder;">
					<option selected>진행 기간 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3" aria-label="Default select example"
						style="font-size:20px; font-weight: bolder;">
					<option selected>진행 여부 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
		</div>		
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container p-0" style="border-color: black; border-width: 4px;">
	
	<!-- 리뷰 영역 -->
	<div class="container p-0">
		<h3 style="color: #FF4379;"><strong>REVIEW</strong></h3>
	</div>
	<div class="container p-0">
		<div class="row g-2">
			<!-- 평점 현황 -->
			<div class="col-2" style="width: 180px; height:180px; background-color: #FF4379; 
									  border-radius: 23.50px; display: flex; align-items: center; 
									  justify-content: center;">			
				<div class="row row-cols-1">
					<div class="col" style="text-align: center;">
						<span style="color: white; font-size: 35px; font-weight: bolder;">4.8 </span>
						<span style="color: white; font-size: 16px; font-weight: bolder;">/ 5.0</span>
					</div>
					<div class="col" style="text-align: center;">
						<span style="color: white;">⭐⭐⭐⭐⭐</span>
					</div>
					<div class="col" style="text-align: center;">
    					<hr style="border-color: white; background-color:white; border-width: 4px;">
					</div>
					<div class="col" style="text-align: center;">
						<span style="color: white; font-size: 16px; font-weight: bolder;">"아주 좋았어요!"</span>
					</div>
				</div>										  
			</div>
			<div class="col-2" style="width: 60px; height:180px;">
			
			</div>
			
			<!-- 전체 리뷰 현황 -->
			<div class="col" style="background-color: #FCE7EB; border-radius: 23.50px; font-size: 20px; font-weight: bold;">
				<div class="row" style="margin-left: 20px; margin-top: 15px;">
					<div class="col col-sm-8">
						<span style="color: #FF4379; font-size: 25px;">·</span>
						<span> 전체 리뷰 작성자 중 
						<span style="color: #FF4379;">000
						</span>명이 <span style="color: #FF4379;">★★★★★</span>으로 평가한 축제에요.</span>
					</div>
				</div>				
				<div class="row row-cols-3" style="margin-top: -10px;">
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png" style="width: 80px; height: 80px; margin-right: -20px;"> 볼거리가 많아요</div>
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png" style="width: 80px; height: 80px; margin-right: -20px;">편의시설이 훌륭해요</div>
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png" style="width: 80px; height: 80px; margin-right: -20px;">접근성이 좋아요</div>
				</div>
				<div class="row row-cols-3" style="margin-top: -30px;">
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png" style="width: 80px; height: 80px; margin-right: -20px;">컨텐츠가 신선해요</div>
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png" style="width: 80px; height: 80px; margin-right: -20px;">남녀노소 즐길 수 있어요</div>
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png" style="width: 80px; height: 80px; margin-right: -20px;">주변 인프라가 좋아요</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 리뷰 카드 영역 -->
 	<div class="container p-0" style="height: 40%; margin-top: 50px;">
		<div class="owl-carousel custom-carousel owl-theme"> 	
<!-- 		<div class="row row-cols-1 row-cols-md-1 g-4"> -->
			<c:forEach var="boards" items="${board }">
<!-- 				<div class="col"> -->
					<div class="card" style="border: 3px solid black; border-radius: 23.50px; margin: 10px;
											 width: 400px;">
						<div class="row row-cols-2" style="margin-top: 10px;">
							
							<div class="col col-4">
								<img src="../image/cuteBear.png"
									 class="card-img-top rounded-circle border" alt="이미지영역"
									 style="width: 100px; height: 100px; margin-left: 15px;">
							</div>
							
							<div class="col col-8">
								<div class="row row-cols-1" style="margin-left: -10px;">
									<div class="row row-cols-2">
										<div class="col" style="font-size: 18px; font-weight: bolder;">${boards.nickname }</div>
										<div class="col" style="text-align: left; font-size: 16px; font-weight: bolder; color: #8C8C8C; margin-left: -20px; margin-top: 4px;">${boards.user_id }</div>
									</div>

									<div class="col" style="font-weight: bolder; color: #8C8C8C; margin-top: 2px;">
										<fmt:formatDate value="${boards.created_at }" type="date"
														pattern="YYYY.MM.dd, hh:mm:ss" />
									</div>
									
									<div class="col" style="margin-top: 2px;">⭐⭐⭐⭐⭐</div>
								</div>
							</div>
						</div>

						<div class="card-body row row-cols-1">
							<h5 class="card-title col">
								<strong>${boards.content }</strong>
							</h5>
							<p class="card-text col">${boards.content }</p>
						</div>
						
						<div class="card-footer row border-0">
							<img src="../image/cuteBear.png" class="card-img-top col" alt="이미지영역"
								 style="width: 100px; height =100px; margin-left: 15px;"> 
							<img src="../image/cuteBear.png" class="card-img-top col" alt="이미지영역"
								 style="width: 100px; height =100px; margin-left: 15px;"> 
							<img src="../image/cuteBear.png" class="card-img-top col" alt="이미지영역"
								 style="width: 100px; height =100px; margin-left: 15px;">
						</div>
					</div>
<!-- 				</div> -->
			</c:forEach>
			</div>
		</div>
<!-- 	</div>
 -->


 
	<!-- 경계선 표현 -->
	<hr class="container p-0"
		style="border-color: black; border-width: 4px;">
</body>
</html>