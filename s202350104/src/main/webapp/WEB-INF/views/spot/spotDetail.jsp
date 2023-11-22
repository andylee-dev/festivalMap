<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SpotDetail</title>

<!-- 지역 코드 넣는 코드  -->
<script src="/js/updateArea.js"></script>
<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- script 영역 -->
<script>

	/* 대분류, 소분류 기능 js */
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
	
	/* 신고 기능 js */
	function report(boardId) {
	    window.open("../reportBoardFoam?boardId=" + boardId, "_blank", "width=600, height=400, top=100, left=100");
	}
	
	/* review 생성 기능 js */
	function showPopUp(userId, bigCode, smallCode, currentPage, contentId, commonCode) {
	    console.log("showPopUp 함수가 호출되었습니다.");		
		//창 크기 지정
		var width = 700;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
	    //윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
	    //연결하고싶은url
	    const url = "../reviewBoardInsertForm?userId="+ userId + "&commonCode=" + commonCode + "&bigCode=" + bigCode + "&smallCode=" + smallCode + "&currentPage=" + currentPage + "&contentId=" + contentId;
	
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "hello popup", windowStatus);
	}
	
	/* review card carousel js */
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
<style type="text/css">
.homeDetail-basic-text-custom
.text-icon-custom 
.icon-custom {
	margin-right: 1px;
}

.homeDetail-basic-text-custom
.text-custom 
.text-ad-custom{
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 0px;
	margin-right: 56px;
}

.homeDetail-basic-text-custom
.text-custom 
.text-md-custom{
	font-size: 18px;
	font-weight: bold;
	margin-bottom: 0px;
	margin-right: 38px;
}


</style>	
</head>
<body>
	<!-- 임시, 여백용-->
	<div id="content_title" class="container homeDetail-whiteSpace-custom"></div>
	
	<!-- keyword, title 영역 -->	
	<form id="spot" action="spot" method="get">
	<div class="container homeCommon-keyword-title-custom">
		<div class="co1 title-div">
					S P O T!</div>
		<div class="co1 text-div">
			<h4><strong>어느 명소로 떠나볼까요~♫</strong></h4>
		</div>
		<input class="form-control keyword-input" type="text" name="keyword" placeholder="가고 싶은 명소의 이름이나 키워드를 검색해보세요.">
		<img class="keyword-img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon" onclick="submitForm()"/>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- select 영역 -->
	<div class="container homeCommon-select-custom">
		<div class="row g-2 text-center">
			<div class="col d-flex justify-content-center">
				<select class="form-select area-dropdown" 
						aria-label="Default select example" name="area">
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select sigungu-dropdown" 
						aria-label="Default select example" name="sigungu">
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select" aria-label="Default select example">
					<option selected>진행 기간 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
			<div class="col d-flex justify-content-center">
				<select class="form-select" aria-label="Default select example">
					<option selected>진행 여부 선택</option>
					<option value="1">One</option>
					<option value="2">Two</option>
					<option value="3">Three</option>
				</select>
			</div>
		</div>		
	</div>
	</form>
	
	<!-- 상단 분홍색 title 출력-->
	<div class="homeDetail-topTitle-custom">
		<div class="container homeDetail-topTitle-custom">
			<div class="row row-cols-3">
				<div class="col title-custom">
					<p>${spot.title}</p>
				</div>
				<div class="col image-custom">
					<img alt="favorite_icon.png" src="../image/favorite_icon.png">
				</div>
				<div class="col image-custom">
					<img alt="share_icon.png" src="../image/share_icon.png">
				</div>
			</div>
		</div>
	</div>
	
	<!-- content tag 출력-->
	<div class="container homeDetail-topTags-custom">
		<div class="row row-cols-6">
			<div class="col-sm-1 hashTag-custom">
				<button value="">#해시태그</button>
			</div>
			<div class="col-sm-1 hashTag-custom">
				<button value="">#해시태그</button>
			</div>
			<div class="col-sm-1 hashTag-custom">
				<button value="">#해시태그</button>
			</div>			
		</div>
	</div>
	
	<!-- 이미지, 기본 정보 출력 -->
	<div class="container homeDetail-basic-custom">
		<div class="row row-cols-3">
			<!-- 첫번째 큰 이미지 -->
			<div class="col homeDetail-basic-img-custom">
				<img alt="${spot.img1}" src="${spot.img1}">
			</div>
			
			<!-- 두번째 작은 이미지 -->
			<div class="col homeDetail-basic-sideImg-custom">
				<div class="row row-cols-1">
					<div class="col sideImg-custom">
						<img alt="${spot.img2}" src="${spot.img2}">	
					</div>
					<div class="col sideImg-custom">
						<img alt="${spot.img2}" src="${spot.img2}">					
					</div>
					<div class="col sideImg-custom">
						<img alt="${spot.img2}" src="${spot.img2}">					
					</div>
					<div class="col sideImg-custom">
						<img alt="${spot.img2}" src="${spot.img2}">					
					</div>
					<div class="col sideImg-custom">+5</div>
				</div>
			</div>
			
			<!-- 세번째 요약 content -->
			<div class="col homeDetail-basic-text-custom">
				<div class="row row-cols-1">
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-md-custom">명소명 :</p>
						<p>${spot.title}</p>
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>영업시간 :</p>
						<span>${spot.opening_hours}</span>						
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-md-custom">휴무일 :</p>
						<span>${spot.rest_date}</span>						
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-md-custom">입장료 :</p>
						<c:choose>
							<c:when test="${spot.entrance_fee == '무료' || spot.entrance_fee == null}">
								<span>무료</span>
							</c:when>
							<c:otherwise>
								<span>유료</span>			
							</c:otherwise>						
						</c:choose>					
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-ad-custom">위치 :</p>
						<span>${spot.address}</span>
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>문의전화 :</p>
						<span>${spot.phone}</span>					
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>문의메일 :</p>
						<span>${spot.email}</span>											
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>홈페이지 :</p>	
						<span>
							<a href="${spot.homepage}">${spot.homepage}</a>
						</span>										
					</div>
					<div class="col text-icon-custom">
						<div class="row row-cols-6">
							<div class="row row-cols-2 icon-custom">
								<c:choose>
									<c:when test="${spot.is_parking eq 1 }">
										<img alt="packing_icon.png" src="../image/packing_icon.png">									
									</c:when>
									<c:otherwise>
										<img alt="disabled_packing_icon.png" src="../image/disabled_packing_icon.png">									
									</c:otherwise>					
								</c:choose>	
								<span>주차시설</span>	
						
							</div>
							<div class="row row-cols-2 icon-custom">
								<c:choose>
									<c:when test="${spot.is_stroller eq 1 }">
										<img alt="restroom_icon.png" src="../image/restroom_icon.png">									
									</c:when>
									<c:otherwise>
										<img alt="disabled_restroom_icon.png" src="../image/disabled_restroom_icon.png">									
									</c:otherwise>					
								</c:choose>	
								<span>장애인화장실</span>								
							</div>
							<div class="row row-cols-2 icon-custom">
								<c:choose>
									<c:when test="${spot.is_wheelchair eq 1 }">
										<img alt="activate_icon.png" src="../image/activate_icon.png">									
									</c:when>
									<c:otherwise>
										<img alt="disabled_icon.png" src="../image/disabled_icon.png">									
									</c:otherwise>					
								</c:choose>
								<span>휠체어 대여</span>							
							</div>
							<div class="row row-cols-2 icon-custom">
								<c:choose>
									<c:when test="${spot.is_stroller eq 1 }">
										<img alt="activate_icon.png" src="../image/activate_icon.png">									
									</c:when>
									<c:otherwise>
										<img alt="disabled_icon.png" src="../image/disabled_icon.png">									
									</c:otherwise>					
								</c:choose>	
								<span>유모차 대여</span>							
							</div>
							<div class="row row-cols-2 icon-custom">
								<c:choose>
									<c:when test="${spot.is_pet eq 1 }">
										<img alt="activate_icon.png" src="../image/activate_icon.png">									
									</c:when>
									<c:otherwise>
										<img alt="disabled_icon.png" src="../image/disabled_icon.png">									
									</c:otherwise>					
								</c:choose>	
								<span>반려동물 동반</span>							
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 상세정보 출력 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>OVERVIEW</strong></h2>
	</div>
	
	<div class="container homeDetail-overView_custom">
		<div class="homeDetail-overView-detail">
			<p>개   요 : ${spot.content}</p>
		</div>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 리뷰 영역 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>REVIEW</strong></h2>
			<div class="homeDetail-reviewInsert-btn-box">
				<button class="btn" onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${psot.content_id},${spot.big_code})">리뷰&nbsp;등록</button>
			</div>
	</div>
	
	<div class="container homeDetail-view-custom">
		<div class="row g-2">
			<!-- 평점 현황 -->
			<div class="col-2 box-custom">			
				<div class="row row-cols-1">
					<div class="col box-col-custom">
						<span class="cost-span" style="">4.8 </span>
						<span>/ 5.0</span>
					</div>
					<div class="col box-col-custom">
						<span>⭐⭐⭐⭐⭐</span>
					</div>
					<div class="col box-col-custom">
    					<hr/>
					</div>
					<div class="col box-col-custom">
						<span>"아주 좋았어요!"</span>
					</div>
				</div>										  
			</div>
			
			<!-- 전체 리뷰 현황 -->
			<div class="col dashboardBox-custom">
				<div class="row first-box" style="">
					<div class="col col-sm-8">
						<span class="common-span-font">·</span>
						<span> 전체 리뷰 작성자 중 
						<span class="common-span">000</span>명이 
						<span class="common-span">★★★★★</span>으로 평가한 축제에요.</span>
					</div>
				</div>				
				<div class="row row-cols-3 second-box">
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png"> 볼거리가 많아요</div>
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png">편의시설이 훌륭해요</div>
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png">접근성이 좋아요</div>
				</div>
				<div class="row row-cols-3 third-box">
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png">컨텐츠가 신선해요</div>
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png">남녀노소 즐길 수 있어요</div>
					<div class="col col-sm-4">
						<img alt="test" src="../image/reviewIcon2.png">주변 인프라가 좋아요</div>
				</div>
			</div>
		</div>
	</div>
	
	<c:set var="num" value="${page.total-page.start+1 }" />
	
	<!-- 리뷰 카드 영역 -->
 	<div class="container reviewBox-custom"> 
		<div class="owl-carousel custom-carousel owl-theme"> 	
<!-- 		<div class="row row-cols-1 row-cols-md-1 g-4"> -->
			<c:forEach var="review" items="${reviewBoard }">
<!-- 				<div class="col"> -->
					<div class="card reviewCard-custom">
						<div class="row row-cols-2 reviewCard-md-custom">
							
							<div class="col col-4">
								<img class="rounded-circle" src="../image/cuteBear.png" alt="이미지영역">
							</div>
							
							<div class="col col-8">
								<div class="row row-cols-1 reviewCard-content-custom">
									<div class="col reportBtn-box">
										<button class="btn" onclick="report(${review.id})">신고</button>
									</div>
									
									<div class="row row-cols-2 first-content-box">
										<div class="col content-box-first">${review.name }</div>
										<div class="col content-box-second">${boards.user_id }</div>
									</div>

									<div class="col first-calendar-box">
										<fmt:formatDate value="${review.created_at }" type="date"
														pattern="YYYY.MM.dd, hh:mm:ss" />
									</div>
									
									<div class="col first-cost-box">
										<c:forEach begin="1" end="${review.score }">⭐</c:forEach>
									</div>
								</div>
							</div>
							
						</div>

						<div class="card-body row row-cols-1">
							<h5 class="card-title col">
								<strong>${review.content }</strong>
							</h5>
							<p class="card-text col"></p>
						</div>
						
					</div>
			<!-- </div> -->
			</c:forEach>
			</div>
		</div>
<!-- </div> -->

	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">	

	<!-- 찾아가기 출력 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>찾아가기</strong></h2>
	</div>
	
	<div class="container homeDetail-map-custom">
		<div class="homeDetail-map-detail">
		
		</div>	
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 비슷한 명소 출력 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>비슷한 명소</strong></h2>
	</div>	

	<div class="container homeList-menu-custom">
		<div class="row row-cols-3 g-6 homeList-mdMenu-custom">
			<div class="col d-flex justify-content-center">
				<div class="card homeList-card-custom">
					<div class="homeList-tag-custom">
						<div class="homeList-tag-custom2">
							<p class="tag-p">#지역태그</p>
						</div>
						<a href="">
							<img src="../photos/aquarium1.png" class="card-img-top"
							alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title-p">명소 제목</p>
						<p class="card-text period-p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet-p">content영역</p>
					</div>
				</div>
			</div>
			
			<div class="col d-flex justify-content-center">
				<div class="card homeList-card-custom">
					<div class="homeList-tag-custom">
						<div class="homeList-tag-custom2">
							<p class="tag-p">#지역태그</p>
						</div>
						<a href="">
							<img src="../photos/aquarium1.png" class="card-img-top" alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title-p">명소 제목</p>
						<p class="card-text period-p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet-p">content영역</p>
					</div>
				</div>
			</div>
			
			<div class="col d-flex justify-content-center">
				<div class="card homeList-card-custom">
					<div class="homeList-tag-custom">
						<div class="homeList-tag-custom2">
							<p class="tag-p">#지역태그</p>
						</div>
						<a href="">
							<img src="../photos/aquarium1.png" class="card-img-top" alt="image.jpg">
						</a>
					</div>

					<div class="card-body">
						<p class="card-text title-p">명소 제목</p>
						<p class="card-text period-p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet-p">content영역</p>
					</div>
				</div>
			</div>						
		</div>
	</div> 		
			
	<!-- review test -->
	<%-- <div class="container border p-5">
		<div class="d-flex justify-content-end">
			<button class="btn btn-primary"
				onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${spot.content_id},${spot.big_code})">리뷰쓰기</button>
		</div>
		<br>
		<table class="table">
			<tr class="table-primary text-center">
				<th scope="col">구분</th>
				<th scope="col">한줄평</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">평점</th>
				<th scope="col">신고</th>
			</tr>
			<c:forEach var="review" items="${reviewBoard }">
				<tr>
					<td class="text-center">${num }</td>
					<td class="text-center"><a
						href="../boardDetail?id=${review.id }">${review.content }</a></td>
					<td class="text-center">${review.name }</td>
					<td class="text-center"><fmt:formatDate
							value="${review.created_at }" type="date" pattern="YYYY/MM/dd" /></td>
					<td class="text-center">
						<c:forEach begin="1" end="${review.score }">★</c:forEach>
					</td>
					<td class="text-center">
						<button class="btn btn-danger" onclick="report(${review.id})">신고</button>
					</td>
				</tr>
				<c:set var="num" value="${num - 1 }" />
			</c:forEach>
		</table>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center"
				style="display: flex; list-style: none; padding: 0;">
				<c:choose>
					<c:when test="${smallCode eq 6}">
						<li class="page-item"><c:if
								test="${page.startPage > page.pageBlock }">
								<a class="page-link"
									href="reviewBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
							</c:if></li>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item"><a class="page-link"
								href="reviewBoardList?currentPage=${i}">${i}</a></li>
						</c:forEach>
						<li class="page-item"><c:if
								test="${page.endPage < page.totalPage }">
								<a class="page-link"
									href="reviewBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
							</c:if></li>
					</c:when>
				</c:choose>
			</ul>
		</nav>
	</div> --%>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>