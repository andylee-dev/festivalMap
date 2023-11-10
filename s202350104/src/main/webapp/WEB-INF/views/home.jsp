<%@page import="org.springframework.web.context.support.WebApplicationContextUtils"%>
<%@page import="org.springframework.context.ApplicationContext"%>
<%@page import="com.oracle.s202350104.service.map.MapService"%>
<%@page import="com.oracle.s202350104.service.map.KakaoMapSerivce"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>Home</title>
<%
    ApplicationContext context = WebApplicationContextUtils.getRequiredWebApplicationContext(getServletContext());
	MapService map = context.getBean("kakaoMapSerivce", MapService.class);
	String apiKey = map.getApiKey();
%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=apiKey%>&libraries=clusterer"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	let markers = [];
	let map = null;   
	let clusterer = null;

	function initKakaoMap(){
	  if ("geolocation" in navigator) {
		    navigator.geolocation.getCurrentPosition(function(position) {
		      const latitude = position.coords.latitude;
		      const longitude = position.coords.longitude;
		      map = getKakaoMap(latitude, longitude);
		      clusterer = new kakao.maps.MarkerClusterer({
		          map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		          averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		          minLevel: 10 // 클러스터 할 최소 지도 레벨 
		      });
		      setCenter(latitude,longitude);
		      const placePosition = new kakao.maps.LatLng(latitude, longitude);
		      addMarker(placePosition,0);
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
	
 	function getKakaoMap(latitude, longitude){
		const container = document.getElementById('map');
		const options = {
			center: new kakao.maps.LatLng(latitude, longitude),
			level: 3
		};

		return new kakao.maps.Map(container, options);
	} 

 	function search() {
 	    // Contents 객체를 생성하고 필드에 값을 할당
 	    var contents = {
 	    	status: null,
 	    	area: $("#area").val(),
 	        sigungu: $("#sigungu").val()
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
 	        }
 	    });
 	}

	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	const infowindow = new kakao.maps.InfoWindow({zIndex:1});

	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {

	    const listEl = document.getElementById('placesList'), 
	    menuEl = document.getElementById('menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	    
	    // 지도에 표시되고 있는 마커를 제거합니다
 	    clusterer.removeMarkers(markers);

	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();



	    for ( var i=0; i<places.length; i++ ) {

	        // 마커를 생성하고 지도에 표시합니다
	        if( !places[i].mapy || !places[i].mapx) continue;
	        const placePosition = new kakao.maps.LatLng(places[i].mapy, places[i].mapx);
			    console.log("placePosition"+placePosition.getLat()+"/"+placePosition.getLng());
					        
 	            marker = addMarker(placePosition, i), 
			    console.log("marker:"+marker);

	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);

	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);

	            });

	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	            // 마커 클릭 이벤트 처리
	            kakao.maps.event.addListener(marker, 'click', function () {
	                // 클릭한 마커의 위치로 지도 확대
	                /* map.setLevel(5); */
	                bound = new kakao.maps.LatLngBounds()
	                bound.extend(marker.getPosition());
	                map.setBounds(bound);
	                map.setCenter(marker.getPosition());
	            });

	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	                map.setCenter(marker.getPosition());
	            };

	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };
	            
	            itemEl.onclick = function () {
	                bound = new kakao.maps.LatLngBounds()
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
	function getListItem(index, places) {

	    var el = document.createElement('li');
	    el.innerHTML = index+places.title;
	    console.log("getListItem"+places.title);
/* 	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';

	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           

	    el.innerHTML = itemStr;
	    el.className = 'item'; */

	    return el;
	}
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	    marker.setMap(map); // 지도 위에 마커를 표출합니다

	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

	    return marker;
	}

	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}

	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 

	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }

	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;

	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }

	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}

	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

	    infowindow.setContent(content);
	    infowindow.open(map, marker);
	}

	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}	
	
	function getLocation() {
	  if ("geolocation" in navigator) {
	    navigator.geolocation.getCurrentPosition(function(position) {
	      const latitude = position.coords.latitude;
	      const longitude = position.coords.longitude;
	      setCenter(latitude,longitude);
	    });
	  } else {
	    console.log("Geolocation을 지원하지 않는 브라우저입니다.");
	  }
	}
		

	window.onload = function() {
		initKakaoMap();
	  
	};

</script>
	<script src="/js/updateArea.js"></script>
	<script type="text/javascript">
		document.addEventListener("DOMContentLoaded", function() {
			updateAreaOptions();
			$(".area-dropdown").change(function() {
				const selectedArea = $(this).val();
				if (selectedArea) {
					updateSigunguOptions(selectedArea);
				} else {
					$(".sigungu-dropdown").empty().append("<option value=''>전체</option>");
				}
			});
		});
	</script>
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
		랜덤축제
		취향테스트
		캘린더
	</div>

	<!-- Section2 -->
	<div class="container border p-5">			
		md's pick
	</div>
	
	<!-- Section3 -->
	<div class="container p-0 border">
		<div>
			<h1>지도지도</h1>		
		</div>
		<div class="border d-flex "style="height:600px;">			
			<div id="menu_wrap" class="container col-3 overflow-auto">
				<div class="container">
					<div class="m-3">
						<label for="area" class="form-label">지역</label>
						<select name="area" id="area" class="form-select col-auto area-dropdown"></select> 
					</div>
					<div class="m-3">
						<label for="sigungu" class="form-label">지역상세</label>
						<select name="sigungu" id="sigungu" class="form-select col-auto sigungu-dropdown "></select>
					</div>
					<div class="m-3">
						<label for="tag" class="form-label">테마별</label>
						<select name="tag" id="tag" class="form-select col-auto"></select>						
						<input type="text" class="form-control" id="searchTag" placeholder="태그 검색하기">
					</div>
					<div class="text-center">
					  <button type="button" class="btn btn-primary"onclick="search()">검색</button>
					</div>
					<hr>
				</div>
				<div class="container-fluid">
					<div class="m-3">
						<label for="area" class="form-label">목록 보기</label>
						<ul id="placesList"></ul>
<!-- 						<div class="">						
							<div class="card" >
							  <img src="..." class="card-img-top" alt="...">
							  <div class="card-body">
							    <h5 class="card-title">Card title</h5>
							    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
							    <a href="#" class="btn btn-primary">Go somewhere</a>
							  </div>
							</div>
						</div>
 -->					</div>
				
				</div>

			</div>
			<div id="map" class="col-9"></div>
		
		

		</div>	
	</div>

	<!-- Section4 -->
	<div class="container border p-5">			
		컨텐츠 배너.
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
		
</body>
</html>