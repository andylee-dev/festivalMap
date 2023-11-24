<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.oracle.s202350104.service.map.MapService"%>
<%@page import="com.oracle.s202350104.service.map.KakaoMapSerivce"%>    
<%@ include file="/WEB-INF/components/header.jsp" %>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FestivalDetail</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<!-- 카카오 MAP -->
<% ApplicationContext context=WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
   MapService map=context.getBean("kakaoMapSerivce", MapService.class); String apiKey=map.getApiKey(); %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=apiKey%>&libraries=clusterer"></script>

<!-- 지역 코드 넣는 코드  -->
<script src="/js/updateArea.js"></script>

<!-- script 영역 -->
<script>
function initKakaoMap() {
    console.log("실행중");  
    
	const mappingTitle = '${accomodation.title }';
	const latitude = ${accomodation.mapy };
	const longitude = ${accomodation.mapx };
    
    var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(latitude, longitude), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	 
	// 마커를 표시할 위치와 title 객체 배열입니다 
	var positions = [
	    {
	        title: mappingTitle, 
	        latlng: new kakao.maps.LatLng(latitude, longitude)
	    }
	];
	
	// 마커 이미지의 이미지 주소입니다
	var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_red.png'; 

	for (var i = 0; i < positions.length; i ++) {
	    
	    // 마커 이미지의 이미지 크기 입니다
	    var imageSize = new kakao.maps.Size(64, 69); 
	    
	    // 마커 이미지를 생성합니다    
	    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
	    
	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({
	        map: map, // 마커를 표시할 지도
	        position: positions[i].latlng, // 마커를 표시할 위치
	        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
	        image : markerImage // 마커 이미지 
	    });
	}
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


	/* 대분류, 소분류 기능 js */
	document.addEventListener("DOMContentLoaded", function() {
		initKakaoMap();
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
	
	/* review card carousel js */
    $(document).ready(function () {
        $(".custom-carousel").owlCarousel({
        	items: 1,
            autoWidth: true,
        });

    }); 
	
	/* 클릭한 사진 보여주기 */
	function clickPhoto(event){
		console.log("실행");
		
		var clickedImg = event.target;
		
		var chooseImg = document.getElementById("photo");
		chooseImg.setAttribute("src", clickedImg.getAttribute("src"));
	}
	
	/* URL Link Share */
	function clip() {
	    var textarea = document.createElement("textarea");
	    document.body.appendChild(textarea);
	    
	    var url = window.document.location.href;
	    textarea.value = url;
	    textarea.select();
	    
	    document.execCommand("copy");
	    document.body.removeChild(textarea);
	    
	    swal({
	        title: "URL이 복사되었습니다!!",
	        text: url,
	        icon: "success",
	    })
	}	
	
	
   	function like() {
 	    const favorite = {
			user_id : ${userId},
			content_id: ${accomodation.content_id},
		}
		$.ajax({
			method:"POST",
			url:"/toggleFavoriteAjax",
			data:JSON.stringify(favorite),
			dataType:'json',
			contentType: "application/json",
			success:
				function(result) {
					if(result == 1) {
						alert("찜했습니다.");
					} else {
						alert("찜목록에서 제외했습니다.");
					}		
				}
		})
    }

</script>

</head>

<body>
	<!-- 임시, 여백용-->
	<div id="content_title" class="container homeDetail-whiteSpace-custom"></div>
<!-- 	
	keyword, title 영역	
	<form id="festival" action="festival" method="get">
	<div class="container homeCommon-keyword-title-custom">
		<div class="co1 title-div">accomodation!</div>
		<div class="co1 text-div">
			<h4><strong>좋은 숙박을 알아볼까요~♫</strong></h4>
		</div>
		<input class="form-control keyword-input" type="text" name="keyword" placeholder="가고 싶은 축제의 이름이나 키워드를 검색해보세요.">
		<img class="keyword-img" src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon" onclick="submitForm()"/>
	</div>
	
	경계선 표현
	<hr class="container homeCommon-top-custom">	
		
	select 영역
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
	</form> -->
	
	<!-- 상단 분홍색 title 출력-->
	<div class="homeDetail-topTitle-custom">
		<div class="container homeDetail-topTitle-custom">
			<div class="row row-cols-3">
				<div class="col title-custom">
					<p>${accomodation.title}</p>
				</div>
				<div class="col image-custom">
					<img alt="favorite_icon.png" src="../image/favorite_icon.png" onclick="like()">
				</div>
				<div class="col image-custom">
					<img alt="share_icon.png" src="../image/share_icon.png" onclick="clip(); return false;">
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
				<img id="photo" alt="${accomodation.img1}" src="${accomodation.img1}">
			</div>
			
			<!-- 두번째 작은 이미지 -->
			<div class="col homeDetail-basic-sideImg-custom">
				<div class="row row-cols-1">
					<c:choose>
						<c:when test="${accomodation.img1 != null}">
							<div class="col sideImg-custom">
								<img alt="${accomodation.img1}" src="${accomodation.img1}" onclick="clickPhoto(event)">	
							</div>			
						</c:when>
						<c:otherwise>
							<div class="col sideImg-custom"></div>							
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${accomodation.img2 != null}">
							<div class="col sideImg-custom">
								<img alt="${accomodation.img2}" src="${accomodation.img2}" onclick="clickPhoto(event)">	
							</div>			
						</c:when>
						<c:otherwise>
							<div class="col sideImg-custom"></div>							
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${accomodation.img3 != null}">
							<div class="col sideImg-custom">
								<img alt="${accomodation.img3}" src="${accomodation.img3}" onclick="clickPhoto(event)">	
							</div>			
						</c:when>
						<c:otherwise>
							<div class="col sideImg-custom"></div>							
						</c:otherwise>
					</c:choose>					
					<!-- 추가 이미지 확장용 -->
					<div class="col sideImg-custom"></div>
					<div class="col sideImg-custom"></div>
				</div>
			</div>
			
			<!-- 세번째 요약 content -->
			<div class="col homeDetail-basic-text-custom">
				<div class="row row-cols-1">
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-md-custom">상호명</p>
						<span>${accomodation.title}</span>
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-sm-custom">주소</p>
						<span>${accomodation.address}</span>						
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>우편번호</p>
						<span>${accomodation.postcode}</span>					
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>전화번호</p>
						<span>${accomodation.phone}</span>			
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>홈페이지</p>	
						<span>
							<a href="${accomodation.homepage}">${accomodation.homepage}</a>
						</span>	
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-md-custom">객실수</p>
						<span>${accomodation.room_count}</span>
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p class="text-md-custom">예약처</p>
						<span>${accomodation.reservation_url}</span>
					</div>
	
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>환불규정</p>
						<span>${accomodation.refund}</span>					
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>입실시간</p>
						<span>${accomodation.check_in}</span>										
					</div>
					<div class="col text-custom">
						<img alt="icon.jpg" src="../image/boardStatus1.png">
						<p>퇴실시간</p>	
						<span>${accomodation.check_out}</span>									
					</div>
					<div class="col text-icon-custom">
						<div class="row row-cols-6">
							<div class="row row-cols-2 icon-custom">
								<c:choose>
									<c:when test="${accomodation.is_parking eq 1 }">
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
									<c:when test="${accomodation.is_cook eq 1 }">
										<img alt="restroom_icon.png" src="../image/restroom_icon.png">									
									</c:when>
									<c:otherwise>
										<img alt="disabled_restroom_icon.png" src="../image/disabled_restroom_icon.png">									
									</c:otherwise>					
								</c:choose>	
								<span>조리시설</span>								
							</div>
							<div class="row row-cols-2 icon-custom">
								<c:choose>
									<c:when test="${accomodation.is_pickup eq 1 }">
										<img alt="activate_icon.png" src="../image/activate_icon.png">									
									</c:when>
									<c:otherwise>
										<img alt="disabled_icon.png" src="../image/disabled_icon.png">									
									</c:otherwise>					
								</c:choose>
								<span>픽업여부</span>							
							</div>
							<div class="row row-cols-2 icon-custom"></div>							
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
			<p>개   요 : ${accomodation.content}</p>
		</div>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 리뷰 영역 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>REVIEW</strong></h2>
			<div class="homeDetail-reviewInsert-btn-box">
				<button class="btn" onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${accomodation.content_id},${accomodation.big_code})">리뷰&nbsp;등록</button>
			</div>
	</div>
	
	<div class="container homeDetail-view-custom">
		<div class="row g-2">
			<!-- 평점 현황 -->
			<div class="col-2 box-custom">			
				<div class="row row-cols-1">
					<div class="col box-col-custom">
						<span class="cost-span">${reviewCount }&nbsp;</span>
						<span>/ 5.0</span>
					</div>
					<div class="col box-col-custom">
						<c:forEach begin="1" end="${reviewCount }">⭐</c:forEach>
					</div>
					<div class="col box-col-custom">
    					<hr/>
					</div>
					<div class="col box-col-custom">
						<c:choose>
							<c:when test="${reviewCount < 1.0 && reviewCount >= 0.0}">
								<span>"비추천해요.."</span>
							</c:when>
							<c:when test="${reviewCount < 2.0 && reviewCount >= 1.0}">
								<span>"조금 괜찮아요.."</span>
							</c:when>
							<c:when test="${reviewCount < 3.0 && reviewCount >= 2.0}">
								<span>"보통이에요!"</span>
							</c:when>
							<c:when test="${reviewCount < 4.0 && reviewCount >= 3.0}">
								<span>"즐거웠어요!"</span>
							</c:when>
							<c:otherwise>
								<span>"적극 추천해요!"</span>
							</c:otherwise>
						</c:choose>
					</div>
				</div>										  
			</div>
					
			<!-- 전체 리뷰 현황 -->
			<div class="col dashboardBox-custom">
				<div class="row first-box" style="">
					<div class="col col-sm-8">
						<span class="common-span-font">·</span>
						<span> 전체 리뷰 작성자 중 
						<span class="common-span">${fn:length(reviewBoard) }</span>명이 
							<c:forEach begin="1" end="${reviewCount }">
								<span class="common-span">★</span>
							</c:forEach>
						으로 평가한 축제에요.</span>
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
	
<%-- 	<c:set var="num" value="${page.total-page.start+1 }" /> --%>
	
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
		<div id="map" class="homeDetail-map-detail">
		
		</div>	
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 비슷한 축제 출력 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>비슷한 축제</strong></h2>
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
						<p class="card-text title-p">축제 제목</p>
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
						<p class="card-text title-p">축제 제목</p>
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
						<p class="card-text title-p">축제 제목</p>
						<p class="card-text period-p">2023.00.00&nbsp;~&nbsp;00.00</p>
						<p class="card-text contet-p">content영역</p>
					</div>
				</div>
			</div>						
		</div>
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>