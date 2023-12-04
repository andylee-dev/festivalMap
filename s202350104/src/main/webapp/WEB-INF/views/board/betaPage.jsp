<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.oracle.s202350104.service.map.MapService"%>
<%@page import="com.oracle.s202350104.service.map.KakaoMapSerivce"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8" />

<title>Home</title>
<% ApplicationContext context=WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
   MapService map=context.getBean("kakaoMapSerivce", MapService.class); String apiKey=map.getApiKey(); %>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=apiKey%>&libraries=clusterer"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
			let markers = [];
			let map = null;
			let clusterer = null;

			function initKakaoMap() {
				if ("geolocation" in navigator) {
					navigator.geolocation.getCurrentPosition(function (position) {
						const latitude = 37.65397366;
						const longitude = 126.7686849;
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

			
			document.addEventListener("DOMContentLoaded", function () {
				initKakaoMap();
				updateAreaOptions();
				$(".area-dropdown").change(function () {
					const selectedArea = $(this).val();
					if (selectedArea) {
						updateSigunguOptions(selectedArea);
					} else {
						$(".sigungu-dropdown")
							.empty()
							.append("<option value=''>전체</option>");
					}
				});
			});			
			
			
			if(place.big_code == 11){
				linkEl.href = "../festival/detail?contentId=" + place.id;
			} else if(place.big_code == 12){
				linkEl.href = "../restaurant/detail?contentId=" + place.id;
			}
			} else if(place.big_code == 13){
				linkEl.href = "../accomodation/detail?contentId=" + place.id;
			}
			} else if(place.big_code == 14){
				linkEl.href = "../spot/detail?contentId=" + place.id;
			}
			} else if(place.big_code == 15){
				linkEl.href = "../experience/detail?contentId=" + place.id;
			} 
		</script>
<script src="/js/updateArea.js"></script>

<link href="/css/home.css" rel="stylesheet" type="text/css">

</head>

<body>

	<!-- Section3 -->
	<div class="container border p-0">		
		<div class="border d-flex">

			<div id="map" class="col-8" style="width:800px; height: 500px;"></div>
		</div>
	</div>
	
	<div class="position-relative overflow-hidden p-3 p-md-5 m-md-3 text-center bg-body-tertiary">
		<!-- HeaderBanner by.엄민용 -->
		<c:forEach var="headers" items="${bannerHeader }">
			<c:choose>
				<c:when test="${headers.title == '숙박' }">
					<img alt="숙박_headerBanner" src="${headers.image }">
				</c:when>
			</c:choose> 
		</c:forEach>
		<!-- HeaderBanner end -->
	</div>
	
		<!-- 테마버튼 검색 -->
			<div class="type">
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=1'">자연</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=2'" >역사</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=5'" >건축</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=3'">휴양</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=4'" >산업</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=6'" >문화</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=7'" >N개의 경</button>
					<button type= "button" class="theme_type" onclick="location.href='spot1?big_code=14&small_code=8'" >기타</button>
			</div>
			<form action="spot1" method="get">
			<div class="m-3">
				<c:if test="${big_code != null}">
					<input type="hidden" name="big_code" value="${big_code}">
				</c:if>
				<c:if test="${small_code != null}">
					<input type="hidden" name="small_code" value="${small_code}">
				</c:if>
			</div>
			</form>
			
			
			
				
	<div class="container" style="display: flex;">
	  <div class="hashtag-container">
	    <div class="app-tag-container" style="position: relative;  margin-right: 10px; margin-top: 10px">
	      <div class="app-tag" style="position: absolute;">
	        <div class="app-tag-text" style="font-size: 12; display: flex; align-items: center; justify-content: center;">#해시태그</div>
	      </div>
	    </div>
	  </div>
	  
	  <div class="hashtag-container">
	    <div class="app-tag-container" style="position: relative; margin-top: 10px">
	      <div class="app-tag" style="position: absolute;">
	        <div class="app-tag-text" style="font-size: 12; display: flex; align-items: center; justify-content: center;">#해시태그2</div>
	      </div>
	    </div>
	  </div>
	</div>
	<div class="container border-bottem p-5"
		style="justify-content: space-between; height: 700px; border-bottom: 3px solid black;">
		<table>
        <tr>
      <td style="width: 10%; height: 100%; text-align: left; margin-left: -40px;">
        <img id="mainImage" class="thumbnail" alt="${accomodation.title}이미지1"
             src="${accomodation.img1}"
             style="width: 313px; height: 525px; object-fit: cover; margin-left: 0px;"
             align="absmiddle" onclick="openModal(); currentSlide(1)">
      </td>
      <td style="width: 10%; text-align: left; vertical-align: top;">
        <img class="thumbnail" alt="${accomodation.title}이미지1"
             src="${accomodation.img1}"
             style="width: 100px; height: 100px; object-fit: cover; margin-bottom: 10px;" align="absmiddle"
             onclick="document.getElementById('mainImage').src=this.src">
        <img class="thumbnail" alt="${accomodation.title}이미지2"
             src="${accomodation.img2}"
             style="width: 100px; height: 100px; object-fit: cover; margin-bottom: 10px;" align="absmiddle"
             onclick="document.getElementById('mainImage').src=this.src">
        <img class="thumbnail" alt="${accomodation.title}이미지3"
             src="${accomodation.img3}"
             style="width: 100px; height: 100px; object-fit: cover;" align="absmiddle"
             onclick="document.getElementById('mainImage').src=this.src">
      </td>
      
      
				<td style="width: 20%; text-align: left;">
					<ul class="custom-ul">
						<li><span>상호명</span><span>${accomodation.title}</span></li>
						<li><span>주소</span><span>${accomodation.address}</span></li>
						<li><span><b>우편번호</b></span><span>${accomodation.postcode}</span></li>
						<li><span><b>전화번호</b></span><span>${accomodation.phone}</span></li>
						<li><span><b>홈페이지</b></span><a href="${accomodation.homepage}"><span>${accomodation.homepage}</span></a></li>
						<li><span><b>객실수</b></span><span>${accomodation.room_count}</span></li>
						<li><span><b>예약처</b></span><a href="${accomodation.reservation_url}"><span>${accomodation.reservation_url}</span></a></li>
						<li><span><b>환불규정</b></span><span>${accomodation.refund}</span></li>
						<li><span><b>입실시간</b></span><span>${accomodation.check_in}</span></li>
						<li><span><b>퇴실시간</b></span><span>${accomodation.check_out}</span></li>
					</ul>
					<div style="display: flex; justify-content: flex-start; text-align: left; padding-top: 30px">
						<c:choose>
							<c:when test="${accomodation.is_pickup == 0}">
								<div style="text-align: center; margin-right: 5px;">
								<i class="contentyes-bi bi-car-front"></i>
								<div style="margin-top: 10px;"><b>픽업가능</b></div>
								</div>
								</c:when>
							<c:when test="${accomodation.is_pickup == 1}">
							<div style="text-align: center; margin-right: 5px;">
							<i class="contentno-bi bi-car-front"></i>
							<div style="margin-top: 10px;"><b>픽업불가</b></div>
							</div>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${accomodation.is_cook == 0}">
							<div style="text-align: center; margin-right: 5px;">
							<i class="contentyes-bi bi-egg-fried"></i>
							<div style="margin-top: 10px;"><b>조리가능</b></div>
							</div>
							</c:when>
							<c:when test="${accomodation.is_cook == 1}">
							<div style="text-align: center; margin-right: 5px;">
							<i class="contentno-bi bi-egg-fried"></i>
							<div style="margin-top: 10px;"><b>조리불가</b></div>
							</div>
							</c:when>
						</c:choose>
						<c:choose>
							<c:when test="${accomodation.is_parking == 0}">
							<div style="text-align: center; margin-right: 0px;">
							<i class="contentyes-bi bi-p-circle"></i>
							<div style="margin-top: 10px;"><b>주차가능</b></div>
							</div>
							</c:when>
							<c:when test="${accomodation.is_parking == 1}">
							<div style="text-align: center; margin-right: 0px;">
							<i class="contentno-bi bi-sign-no-parking"></i>
							<div style="margin-top: 10px;"><b>주차불가</b></div>
							</div>
							</c:when>
						</c:choose>
					</div>


				</td>
			</tr>
		</table>
	</div>
	
		 <script>
	 document.addEventListener('DOMContentLoaded', function () {
		    var mainImage = document.getElementById('mainImage');
		    var largeImage = document.getElementById('largeImage');
		    var overlay = document.getElementById('overlay');

		    mainImage.addEventListener('click', function () {

		        // 이미지 소스 및 디스플레이 스타일 설정
		        largeImage.src = this.src;
		        largeImage.style.display = 'block'; // 추가된 코드
		        overlay.style.display = 'flex';
		    });

		    overlay.addEventListener('click', function () {

		        // 오버레이 및 큰 이미지 감추기
		        this.style.display = 'none';
		        largeImage.style.display = 'none'; // 추가된 코드
		    });
		});
	</script>

</body>
</html>