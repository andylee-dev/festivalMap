<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>    
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Beta Page</title>

<!-- 지역 코드 넣는 코드  -->
<script src="/js/updateArea.js"></script>

<!-- script 영역 -->
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
    
	document.addEventListener("DOMContentLoaded", function() {
		updateAreaOptions();
		$(".area-dropdown").change(
				function() {
					const selectedArea = $(this).val();
					if (selectedArea) {
						updateSigunguOptions(selectedArea);
					} else {
						$(".sigungu-dropdown").empty().append(
								"<option value='0'>전체</option>");
					}
				});
	});
</script>

</head>
<body>
	<!-- 임시, 여백용-->
	<div id="content_title" class="container whiteSpace_custom" style=""></div>
	
	<!-- keyword, title 영역 -->	
	<div class="container p-0 keyword_title_custom">
		<div class="co1 title_div">
					F E S T I V A L!</div>
		<div class="co1 text_div">
			<h4><strong>어느 축제로 떠나볼까요~♫</strong></h4>
		</div>
		<input class="form-control keyword_input" type="text" name="keyword" placeholder="가고 싶은 축제의 이름이나 키워드를 검색해보세요.">
		<img class="keyword_img" src="../image/icon_search1.png" alt="icon_search1.png"/>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">	
		
	<!-- select 영역 -->
	<div class="container p-0 select_custom">
		<div class="row g-2 text-center">
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom area-dropdown" 
						aria-label="Default select example" name="area">
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select text-center border-3 select_text_custom sigungu-dropdown" 
						aria-label="Default select example" name="sigungu">
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
	
	<!-- 상단 분홍색 title 출력-->
	<div class="container p-0 top_title_custom">
		<div class="row row-cols-1">
			<div class="col title_custom">
				<p>2023 꿈나라 꿈나라 축제</p>
			</div>
		</div>
	</div>
	
	<!-- 상단 tag 출력-->
	<div class="container p-0">
		<div class="row row-cols-6">
			<div class="col-sm-1 hashTag_custom">
				<button value="">#해시태그</button>
			</div>
			<div class="col-sm-1 hashTag_custom">
				<button value="">#해시태그</button>
			</div>
			<div class="col-sm-1 hashTag_custom">
				<button value="">#해시태그</button>
			</div>			
		</div>
	</div>
	
	<!-- 이미지, 기본 정보 출력 -->
	<div class="container p-0 basic-custom">
		<div class="row row-cols-3">
			<div class="col basic-img-custom">
				<img alt="기본 이미지" src="...">
			</div>
			<div class="col basic-sideImg-custom">
				<div class="row row-cols-1">
					<div class="col sideImg-custom">1</div>
					<div class="col sideImg-custom">2</div>
					<div class="col sideImg-custom">3</div>
					<div class="col sideImg-custom">4</div>
					<div class="col sideImg-custom">5</div>
				</div>
			</div>
			<div class="col basic-text-custom">
				<div class="row row-cols-1">
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-md-custom">축제명</p>
						<p>꿈나라꿈나라</p>
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-sm-custom">기간</p>
						<span>꿈나라꿈나라</span>						
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-sm-custom">시간</p>
						<span>꿈나라꿈나라</span>						
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-md-custom">입장료</p>
						<span>꿈나라꿈나라</span>						
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-sm-custom">위치</p>
						<span>꿈나라꿈나라</span>
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-sm-custom">주최</p>
						<span>꿈나라꿈나라</span>
					</div>
	
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>문의전화</p>
						<span>꿈나라꿈나라</span>					
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>문의메일</p>
						<span>꿈나라꿈나라</span>											
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>홈페이지</p>	
						<span>꿈나라꿈나라</span>										
					</div>
					<div class="col text-icon-custom">
						<div class="row row-cols-6">
							<div class="col icon-custom">1</div>
							<div class="col icon-custom">2</div>
							<div class="col icon-custom">3</div>
							<div class="col icon-custom">4</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>	
	
	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">
	
	<!-- 상세정보 출력 -->
	<div class="container p-0">
		<h2 style="color: #FF4379;"><strong>OVERVIEW</strong></h2>
	</div>
	
	<div class="container p-0 content_custom">
		<div class="content_detail"></div>
	</div>

	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">
	
	<!-- 리뷰 영역 -->
	<div class="container p-0">
		<h2 style="color: #FF4379;"><strong>REVIEW</strong></h2>
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
 	<div class="container p-0" style="margin-top: 50px;">
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
			<!-- </div> -->
			</c:forEach>
			</div>
		</div>
<!-- </div> --> 	
	
	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">
	
	<!-- 찾아가기 출력 -->
	<div class="container p-0">
		<h2 style="color: #FF4379;"><strong>찾아가기</strong></h2>
	</div>
	
	<div class="container p-0 map_custom">
		<div class="map_detail">
		
		</div>	
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container p-0 hr_custom">
	
	<!-- 비슷한 축제 출력 -->
	<div class="container p-0">
		<h2 style="color: #FF4379;"><strong>비슷한 축제</strong></h2>
	</div>	

	<div class="container p-0 list_custom">
		<div class="row row-cols-3 g-2">
			<div class="col d-flex justify-content-center">
				<div class="card card_custom border-0">
					<div class="tag_custom">
						<div class="tag_custom2">
							<p class="tag_p">#지역태그</p>
						</div>
						<a href="">
							<img src="..." class="card-img-top"
							alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title_p">축제 제목</p>
						<p class="card-text period_p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet_p">content영역</p>
					</div>
				</div>
			</div>
			
			<div class="col d-flex justify-content-center">
				<div class="card card_custom border-0">
					<div class="tag_custom">
						<div class="tag_custom2">
							<p class="tag_p">#지역태그</p>
						</div>
						<a href="">
							<img src="..." class="card-img-top"
							alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title_p">축제 제목</p>
						<p class="card-text period_p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet_p">content영역</p>
					</div>
				</div>
			</div>
			
			<div class="col d-flex justify-content-center">
				<div class="card card_custom border-0">
					<div class="tag_custom">
						<div class="tag_custom2">
							<p class="tag_p">#지역태그</p>
						</div>
						<a href="">
							<img src="..." class="card-img-top"
							alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title_p">축제 제목</p>
						<p class="card-text period_p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet_p">content영역</p>
					</div>
				</div>
			</div>						
		</div>
	</div>
	
	<div align="center">
		<button onclick="location.href='../festival'">목록</button>
	</div>
</body>
</html>