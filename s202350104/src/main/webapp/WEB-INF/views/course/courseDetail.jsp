<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<title>CourseDetail</title>
<!-- 카카오 MAP -->
<% ApplicationContext context=WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
   MapService map=context.getBean("kakaoMapSerivce", MapService.class); String apiKey=map.getApiKey(); %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=apiKey%>&libraries=clusterer"></script>

<!-- 지역 코드 넣는 코드  -->
<script src="/js/updateArea.js"></script>

<!-- script 영역 -->
<script>
	let markers = [];
	let map = null;
	let clusterer = null;
	
	
	function initKakaoMap() {
		if ("geolocation" in navigator) {
			navigator.geolocation.getCurrentPosition(function (position) {
				const latitude = ${courseDetail[0].mapy };
				const longitude = ${courseDetail[0].mapx };
				map = getKakaoMap(latitude, longitude);
				clusterer = new kakao.maps.MarkerClusterer({
					map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체
					averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정
					minLevel: 10,
					// 클러스터 할 최소 지도 레벨
				});
				
				setCenter(latitude, longitude);
				
				const placePosition = new kakao.maps.LatLng(latitude, longitude);
				
				addMarker(placePosition, 0);
			});
		} else {
			console.log("Geolocation을 지원하지 않는 브라우저입니다.");
		}
	}
	
	function setCenter(lat, lng) {
		// 이동할 위도 경도 위치를 생성합니다
		var moveLatLon = new kakao.maps.LatLng(lat, lng);
	
		// 지도 중심을 이동 시킵니다
		map.setCenter(moveLatLon);
	}
	
	function getKakaoMap(latitude, longitude) {
		const container = document.getElementById("map");
		const options = {
			center: new kakao.maps.LatLng(latitude, longitude),
			level: 3,
		};
	
		return new kakao.maps.Map(container, options);
	}
	
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	const infowindow = new kakao.maps.InfoWindow({
		zIndex: 1,
	});
	
	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
		const listEl = document.getElementById("placesList"),
			menuEl = document.getElementById("menu_wrap"),
			fragment = document.createDocumentFragment(),
			bounds = new kakao.maps.LatLngBounds(),
			listStr = "";
	
		// 검색 결과 목록에 추가된 항목들을 제거합니다
		removeAllChildNods(listEl);
	
		// 지도에 표시되고 있는 마커를 제거합니다
		clusterer.removeMarkers(markers);
	
		// 지도에 표시되고 있는 마커를 제거합니다
		removeMarker();
	
		for (var i = 0; i < places.length; i++) {
			// 마커를 생성하고 지도에 표시합니다
			if (!places[i].mapy || !places[i].mapx) continue;
			const placePosition = new kakao.maps.LatLng(
				places[i].mapy,
				places[i].mapx
			);
			console.log(
				"placePosition" +
				placePosition.getLat() +
				"/" +
				placePosition.getLng()
			);
	
			(marker = addMarker(placePosition, i)),
				console.log("marker:" + marker);
	
			itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	
			// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
			// LatLngBounds 객체에 좌표를 추가합니다
			bounds.extend(placePosition);
	
			// 마커와 검색결과 항목에 mouseover 했을때
			// 해당 장소에 인포윈도우에 장소명을 표시합니다
			// mouseout 했을 때는 인포윈도우를 닫습니다
			(function (marker, title) {
				kakao.maps.event.addListener(marker, "mouseover", function () {
					displayInfowindow(marker, title);
				});
	
				kakao.maps.event.addListener(marker, "mouseout", function () {
					infowindow.close();
				});
				// 마커 클릭 이벤트 처리
				kakao.maps.event.addListener(marker, "click", function () {
					// 클릭한 마커의 위치로 지도 확대
					/* map.setLevel(5); */
					bound = new kakao.maps.LatLngBounds();
					bound.extend(marker.getPosition());
					map.setBounds(bound);
					map.setCenter(marker.getPosition());
				});
	
				itemEl.onmouseover = function () {
					displayInfowindow(marker, title);
					map.setCenter(marker.getPosition());
				};
	
				itemEl.onmouseout = function () {
					infowindow.close();
				};
	
				itemEl.onclick = function () {
					bound = new kakao.maps.LatLngBounds();
					bound.extend(marker.getPosition());
					map.setBounds(bound);
					map.setCenter(marker.getPosition());
				};
			})(marker, places[i].title);
	
			fragment.appendChild(itemEl);
		}
		clusterer.addMarkers(markers);
	
		// 검색결과 항목들을 검색결과 목록 Element에 추가합니다
		listEl.appendChild(fragment);
		menuEl.scrollTop = 0;
	
		// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
		map.setBounds(bounds);
	}
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, place) {
		// 카드 요소 생성
		const cardEl = document.createElement("div");
		cardEl.className = "card mb-4";
	
		// 카드 이미지 생성
		const imageEl = document.createElement("img");
		imageEl.src = place.img1;
		imageEl.className = "card-img-top";
		imageEl.style.height = "200px"; // 이미지의 세로 높이를 150px로 설정
		cardEl.appendChild(imageEl);
	
		// 카드 내용 생성
		const cardBodyEl = document.createElement("div");
		cardBodyEl.className = "card-body";
	
		const titleEl = document.createElement("h5");
		titleEl.className = "card-title";
		titleEl.textContent = place.title;
		cardBodyEl.appendChild(titleEl);
	
		const descEl = document.createElement("p");
		descEl.className = "card-text";
		const truncatedDesc = truncateText(place.content, 50); // 50자로 제한
		descEl.innerHTML = truncatedDesc;
		cardBodyEl.appendChild(descEl);
	
		const linkEl = document.createElement("a");
		linkEl.href = place.link;
		linkEl.className = "btn btn-primary";
		linkEl.textContent = "자세히 보기";
		cardBodyEl.appendChild(linkEl);
		cardEl.appendChild(cardBodyEl);
	
		return cardEl;
	}
	
	function truncateText(text, maxLength) {
		if (text.length > maxLength) {
			return ( text.slice(0, maxLength) + "...");
		}
		return text;
	}
	
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
		var imageSrc =
			"https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png", // 마커 이미지 url, 스프라이트 이미지를 씁니다
			imageSize = new kakao.maps.Size(36, 37), // 마커 이미지의 크기
			imgOptions = {
				spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
				spriteOrigin: new kakao.maps.Point(0, idx * 46 + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
				offset: new kakao.maps.Point(13, 37),
				// 마커 좌표에 일치시킬 이미지 내에서의 좌표
			},
			markerImage = new kakao.maps.MarkerImage(
				imageSrc,
				imageSize,
				imgOptions
			),
			marker = new kakao.maps.Marker({
				position: position, // 마커의 위치
				image: markerImage,
			});
		marker.setMap(map); // 지도 위에 마커를 표출합니다
	
		markers.push(marker); // 배열에 생성된 마커를 추가합니다
	
		return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
		for (var i = 0; i < markers.length; i++) {
			markers[i].setMap(null);
		}
		markers = [];
	}
	
	
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
		var content = '<div style="padding:5px;z-index:1;">' + title + "</div>";
	
		infowindow.setContent(content);
		infowindow.open(map, marker);
	}
	
	// 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {
		while (el.hasChildNodes()) {
			el.removeChild(el.lastChild);
		}
	}
	
	function getLocation() {
		if ("geolocation" in navigator) {
			navigator.geolocation.getCurrentPosition(function (position) {
				const latitude = position.coords.latitude;
				const longitude = position.coords.longitude;
				setCenter(latitude, longitude);
			});
		} else {
			console.log("Geolocation을 지원하지 않는 브라우저입니다.");
		}
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
.course-card {
	width: 100%; 
	height: 100%; 
	background: #F4F4F4; 
	border-radius: 10px
}
.card-image-size {
	width: 405px;
	height: 270px; 
	background: #D9D9D9;
}
.ellipsis-text {
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 5; /* 표시할 줄 수 */
    -webkit-box-orient: vertical;
}

</style>

</head>
<body>

	<!-- 임시, 여백용-->
	<div id="content_title" class="container homeDetail-whiteSpace-custom"></div>
	
	<!-- 상단 분홍색 title 출력-->
	<div class="homeDetail-topTitle-custom">
		<div class="container homeDetail-topTitle-custom">
			<div class="row row-cols-3">
				<c:forEach var="courseDetail" items="${courseDetail }">
					<c:if test="${courseDetail.order_num == 1}">
						<div class="col title-custom">
							<p>${courseDetail.course_title}</p>
						</div>
					</c:if>
				</c:forEach>
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
			<c:forEach var="tags" items="${listTags }">
				<div class="col-sm-1 hashTag-custom">
					<c:choose>
						<c:when test="${tags.tag_id > 0}">
							<button value="&{tags.tag_id }">#${tags.name }</button>		
						</c:when>
						<c:otherwise>
							<button>#해시태그</button>	
						</c:otherwise>
					</c:choose>	
				</div>		
			</c:forEach>
		</div>
	</div>
	
	<!-- 이미지, 기본 정보 출력 -->
	<div class="container homeDetail-basic-custom">
		<div class="row row-cols-3">
			<!-- 첫번째 큰 이미지 -->
			<c:forEach var="courseDetail" items="${courseDetail }">
				<c:if test="${courseDetail.order_num == 1}">
					<div class="col homeDetail-basic-img-custom">
						<img alt="${courseDetail.img1}" src="${courseDetail.img1}">
					</div>
					
					<!-- 두번째 작은 이미지 -->
					<div class="col homeDetail-basic-sideImg-custom">
						<div class="row row-cols-1">
							<div class="col sideImg-custom">
								<img alt="${courseDetail.img2}" src="${courseDetail.img2}">	
							</div>
							<div class="col sideImg-custom">
								<img alt="${courseDetail.img2}" src="${courseDetail.img2}">					
							</div>
							<div class="col sideImg-custom">
								<img alt="${courseDetail.img2}" src="${courseDetail.img2}">					
							</div>
							<div class="col sideImg-custom">
								<img alt="${courseDetail.img2}" src="${courseDetail.img2}">					
							</div>
							<div class="col sideImg-custom">+5</div>
						</div>
					</div>
					
					<!-- 세번째 요약 content -->
					<div class="col homeDetail-basic-text-custom">
						<div class="row row-cols-1">
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">코스명</p>
								<p>${courseDetail.course_title }</p>
							</div>
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">코스거리</p>
								<p>${courseDetail.distance }</p>
							</div>
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">소요시간</p>
								<p>${courseDetail.time }</p>
							</div>
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">위치</p>
								<p>#</p>
							</div>
							<div class="col text-custom">
								<img alt="icon.jpg" src="../image/boardStatus1.png">
								<p class="text-md-custom">코스내용</p>
								<p>${courseDetail.course_info }</p>
							</div>
						</div>
					</div>
				</c:if>
			</c:forEach>
		</div>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 상세정보 출력 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>코스 리스트</strong></h2>
	</div>
	
	<div class="container homeDetail-basic-custom">
		<div class="row row-cols-12">
			<div>
				<c:forEach var="courseDetail" items="${courseDetail }">
				<div class="card course-card col-md-6" style="height: 306px; margin: 20px; padding: 18px;">
					<div class="container homeDetail-basic-custom">
						<div class="row">
							<div class="col-md-5">
								<a href='../${courseDetail.cd_content.toLowerCase() }/detail?contentId=${courseDetail.content_id}' style="padding: 0px;">
									<img class="card-image-size" alt="${courseDetail.course_title }" src="${courseDetail.img1 }">
								</a>
							</div>
						
							<div class="col-md-6">
								<ul>
									<li>코스이름 : ${courseDetail.title }
									<li>개요 : <div class="ellipsis-text">
												 ${courseDetail.content }
											 </div>
									<li>주소 : ${courseDetail.address }
									<li>홈페이지 : <a href="${courseDetail.homepage }">${courseDetail.homepage }</a>
									<li>전화번호 : ${courseDetail.phone }
								</ul>
							</div>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
		</div>
	</div>
	
	<!-- 경계선 표현 -->
	<hr class="container homeCommon-top-custom">
	
	<!-- 리뷰 영역 -->
	<div class="container homeDetail-mdTitle-custom">
		<h2><strong>REVIEW</strong></h2>
			<div class="homeDetail-reviewInsert-btn-box">
				<button class="btn" onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${festival.content_id},${festival.big_code})">리뷰&nbsp;등록</button>
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
	
	
	<!-- review test -->
	<div>
		<h3>review 구역</h3>
	</div>
</body>
</html>