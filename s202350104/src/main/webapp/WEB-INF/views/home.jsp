<%@ page language="java" contentType="text/html; charset=UTF-8" 
	pageEncoding="UTF-8"%>
<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.oracle.s202350104.service.map.MapService"%>
<%@page import="com.oracle.s202350104.service.map.KakaoMapSerivce"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
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
						const latitude = position.coords.latitude;
						const longitude = position.coords.longitude;
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
						search();
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

			function search() {
				// Contents 객체를 생성하고 필드에 값을 할당
				var contents = {
					status: null,
					area: $("#area").val(),
					sigungu: $("#sigungu").val(),
				};

				$.ajax({
					url: "/api/searchContents",
					method: "POST",
					contentType: "application/json",
					data: JSON.stringify(contents), // Contents 객체를 data에 할당
					success: function (data) {
						console.log(data);
						displayPlaces(data);
						clusterer.addMarkers(markers);
					},
					error: function () {
						alert("contents 정보를 가져오지 못했습니다.");
					},
				});
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
				cardEl.className = "card mb-4 home-card-custom";

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
				linkEl.className = "btn home-card-btn";
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

			// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
			function displayPagination(pagination) {
				var paginationEl = document.getElementById("pagination"),
					fragment = document.createDocumentFragment(),
					i;

				// 기존에 추가된 페이지번호를 삭제합니다
				while (paginationEl.hasChildNodes()) {
					paginationEl.removeChild(paginationEl.lastChild);
				}

				for (i = 1; i <= pagination.last; i++) {
					var el = document.createElement("a");
					el.href = "#";
					el.innerHTML = i;

					if (i === pagination.current) {
						el.className = "on";
					} else {
						el.onclick = (function (i) {
							return function () {
								pagination.gotoPage(i);
							};
						})(i);
					}

					fragment.appendChild(el);
				}
				paginationEl.appendChild(fragment);
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
			function openPopup() {
				const width = 600;
				const height = 600;
				
				// 화면 가운데 띄우기 위한 계산
				const top = (window.screen.height - height) / 2;
				const left = (window.screen.width - width) / 2;
				
				window.open('/festival/test', 'PopupWindow', 
				    'width='+width,
				    'height='+height,
				    'top='+top,
				    'left='+left
				);
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
			
		</script>
<script src="/js/updateArea.js"></script>

<style type="text/css">
	
	.form-label {
		font-size: 20px;
		font-family: 'Nanum+Pen+Script', sans-serif;
		font-weight: bold;
	}
	
	.form-select, .form-control {
		border: 2px black solid;
		border-radius: 23.50px;
		margin-bottom: 5px;
	}
</style>

<link href="/css/home.css" rel="stylesheet" type="text/css">
</head>

<body>

<main>
	<!-- Top 분홍색 영역  -->
	<div id="content_title" class="container"></div>
	<div class="home-topTitle-box-custom">	
		<div class="container p-5 home-topTitle-box-custom">
			<div class="home-topTitle">
				I N T R O D U C I N G</div>
		</div>
	</div>	
	
	<!-- Main banner 영역 -->
	<div class="container home-mainBanner-box-custom" style="">
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
				<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="3" aria-label="Slide 4"></button>
				<button type="button" data-bs-target="#carouselExampleIndicators"
						data-bs-slide-to="4" aria-label="Slide 5"></button>
			</div>
			<div class="carousel-inner">
				<div class="carousel-item active">
					<img src="../image/BANNER1.png" class="d-block w-100 item-img" alt="메인배너1">
				</div>
				<div class="carousel-item">
					<img src="../image/mainBanner1.png" class="d-block w-100 item-img" alt="메인배너2">
				</div>
				<div class="carousel-item">
					<img src="../image/mainBanner2.png" class="d-block w-100 item-img" alt="메인배너3">
				</div>
				<div class="carousel-item">
					<img src="../image/mainBanner3.png" class="d-block w-100 item-img" alt="메인배너4">
				</div>
				<div class="carousel-item">
					<img src="../image/mainBanner4.png" class="d-block w-100 item-img" alt="메인배너5">
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


	<!-- Section1 -->
	<div class="container home-pick-box-custom">
		<div class="home-pick-batch">MD's&nbsp;Pick</div>
		<div class="home-pick-title">
			<h4><strong>나&nbsp;가을타나봐~♫</strong></h4>
			<h4><strong>신선한&nbsp;가을&nbsp;축제의&nbsp;바람이&nbsp;불어요~♬</strong></h4>
		</div>
	
	    <div class="row row-cols-2  home-pickMd-box-custom">					
			<div class="card col home-pick-card">
				<img class="card-img-top" src="../image/mdpick.png" alt="PickImage">
				<div class="card-body">
					<p class="card-text">인스타 감성샷 필수코스! 핑크뮬리의 계절이 돌아왔다!</p>
					<p class="card-text text-custom" style="">이제 가을 축제의 스테디 셀러로 자리매김한 퐁실 몽글 바로 그 갈대! 핑크뮬리가 올 해
										  에도 한 가득 피었어요. 한 때에는 특정 지역에서만 볼 수 있었던 핑크뮬리지만, 인기몰이
										  덕분에 이제는 다양한 지역에서도 찾아볼 수 있게 되었는데요, 이 곳 휴애리...</p>
				</div>			
			</div>
			<div class="card col home-pick-card">
				<img src="../image/mdpick.png" class="card-img-top" alt="PickImage">
				<div class="card-body">
					<p class="card-text">인스타 감성샷 필수코스! 핑크뮬리의 계절이 돌아왔다!</p>
					<p class="card-text text-custom">이제 가을 축제의 스테디 셀러로 자리매김한 퐁실 몽글 바로 그 갈대! 핑크뮬리가 올 해
										  에도 한 가득 피었어요. 한 때에는 특정 지역에서만 볼 수 있었던 핑크뮬리지만, 인기몰이
										  덕분에 이제는 다양한 지역에서도 찾아볼 수 있게 되었는데요, 이 곳 휴애리...</p>
				</div>			
			</div>				
			<div class="card col home-pick-card">
				<img src="../image/mdpick.png" class="card-img-top" alt="PickImage">
				<div class="card-body">
					<p class="card-text">인스타 감성샷 필수코스! 핑크뮬리의 계절이 돌아왔다!</p>
					<p class="card-text text-custom">이제 가을 축제의 스테디 셀러로 자리매김한 퐁실 몽글 바로 그 갈대! 핑크뮬리가 올 해
										  에도 한 가득 피었어요. 한 때에는 특정 지역에서만 볼 수 있었던 핑크뮬리지만, 인기몰이
										  덕분에 이제는 다양한 지역에서도 찾아볼 수 있게 되었는데요, 이 곳 휴애리...</p>
				</div>			
			</div>
			<div class="card col home-pick-card">
				<img src="../image/mdpick.png" class="card-img-top" alt="PickImage">
				<div class="card-body">
					<p class="card-text">인스타 감성샷 필수코스! 핑크뮬리의 계절이 돌아왔다!</p>
					<p class="card-text text-custom">이제 가을 축제의 스테디 셀러로 자리매김한 퐁실 몽글 바로 그 갈대! 핑크뮬리가 올 해
										  에도 한 가득 피었어요. 한 때에는 특정 지역에서만 볼 수 있었던 핑크뮬리지만, 인기몰이
										  덕분에 이제는 다양한 지역에서도 찾아볼 수 있게 되었는데요, 이 곳 휴애리...</p>
				</div>			
			</div>
		</div>	
	</div>
	
	<!-- Section2 -->
	<div class="container home-chucheon-box-custom">
		<div class="home-chucheon-batch">고민은&nbsp;NO&nbsp;!</div>
		<div class="home-chucheon-title">
			<h4><strong>어떤&nbsp;축제를&nbsp;가야하지?&nbsp;어떤&nbsp;코스로&nbsp;가야하지?</strong></h4>
			<h4><strong>고민하지&nbsp;마세요.&nbsp;페스티맵이&nbsp;있잖아요!</strong></h4>
		</div>
		<div class="row row-cols-3 home-chucheon-card-box">
			<div class="row row-cols-2 chucheon-card">
				<div class="col chucheon-card-se">
					<p>내&nbsp;M.B.T.I는&nbsp;뭘까?</p>
					<span>나의&nbsp;축제&nbsp;취향&nbsp;?!</span>
				</div>
				<div class="col chucheon-card-se">
					<a class="dropdown-item" href="/festival/recommend">
					<img alt="..." src="../image/chucheon_icon.png"></a>
				</div>
			</div>
			<div class="row row-cols-2 chucheon-card">
				<div class="col chucheon-card-se">
					<p>랜덤으로&nbsp;골라!!</p>
					<span>페맵&nbsp;랜덤&nbsp;축제!</span>
				</div>
				<div class="col chucheon-card-se">
					<img alt="..." src="../image/chucheon_icon.png" onclick="openPopup()">
				</div>
			</div>
			<div class="row row-cols-2 chucheon-card">
				<div class="col chucheon-card-se">
					<p>한눈에&nbsp;보는&nbsp;축제!!</p>
					<span>전국&nbsp;축제&nbsp;달력</span>
				</div>
				<div class="col chucheon-card-se">
					<a class="dropdown-item" href="/festival/calendar">			
					<img alt="..." src="../image/chucheon_icon.png"></a>
				</div>
			</div>			
		</div>	
	</div>

	<!-- Section3 -->
		<div class="container home-map-box-custom">
			<div class="home-map-batch">
				<h1>·</h1>
				&nbsp;LIVE
			</div>
			<div class="home-map-title">
				<h4>
					<strong>지금 축제중인 지역</strong>
				</h4>
			</div>

			<!-- Map icon 영역 -->
			<div class="container p-5"
				style="height: 80px; background-color: #B7E24D; position: relative;">
				<img alt="mapIcon1" src="../image/mapicon5.png" width="60px;"
					height="60px;" style="position: absolute; left: 10; top: 18;">
				<img alt="mapIcon1" src="../image/mapicon1.png" width="60px;"
					height="60px;" style="position: absolute; right: 167; top: 18;">
				<img alt="mapIcon1" src="../image/mapicon2.png" width="60px;"
					height="60px;" style="position: absolute; right: 114; top: 18;">
				<img alt="mapIcon1" src="../image/mapicon3.png" width="60px;"
					height="60px;" style="position: absolute; right: 62; top: 18;">
				<img alt="mapIcon1" src="../image/mapicon4.png" width="60px;"
					height="60px;" style="position: absolute; right: 10; top: 18;">
			</div>

			<!-- Map Menu 영역 -->
			<div class="container home-map-menu-custom">
				<div id="menu_wrap" class="row row-cols-2 home-map-nav-box-custom">
					<div class="col home-menu-detail">
						<div class="row row-col-1">
							<div class="col home-menu-sm">
								<label for="area" class="form-label">지역별_구분</label> 
								<select name="area" id="area"
									    class="form-select col-auto area-dropdown"></select>
							</div>
						</div>
						<div class="row row-col-1">
							<div class="col home-menu-sm">
								<label for="sigungu" class="form-label"><strong>상세지역</strong></label>
								<select name="sigungu" id="sigungu"
										class="form-select col-auto sigungu-dropdown"></select>
							</div>
						</div>
						<div class="row row-col-1">
							<div class="col home-menu-ssm">
								<label for="tag" class="form-label"><strong>테마별</strong></label>
							</div>
						</div>
						<div class="row row-col-3">
							<div class="col home-menu-md hashTag-custom">
								<button>#다이나믹한</button>
								<button>#포토스팟</button>
								<button>#내일로</button>
								<button>#향토적인</button>
								<button>#트랜디</button>
								<button>#7080</button>
								<button>#MZ추천</button>
								<button>#매년주최</button>
								<button>#이번에만</button>
							</div>
						</div>
						<div class="row row-col-1">
							<div class="col home-menu-sm">
								<input type="text" class="form-control" id="searchTag" placeholder="태그 검색하기" /> 
								<img src="../image/icon_search1.png" alt="icon_search1.png" />
							</div>
						</div>
						<div class="row row-col-1">
							<div class="col home-menu-lg overflow-auto">
								<label for="area" class="form-label">목록 보기</label>
								<div id="placesList"></div>
							</div>
						</div>

					</div>
					<div class="col home-map-custom">
						<div id="map" class="home-map-img-detail"></div>
					</div>
				</div>
			</div>
		</div>

	<!-- Section4 -->
	<div class="container home-ad-box-custom">
		<div class="home-ad-batch">AD</div>
		<div class="home-ad-title">
			<h4><strong>이런 곳도 있어요!</strong></h4>
		</div>
		<div>
			<img alt="AD_Bannder" src="../image/ADBanner.png" width="100%" height="auto">
		</div>
	</div>

</main>
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>