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
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=<%=apiKey%>"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript">
	function getKakaoMap(latitude, longitude){
		const container = document.getElementById('map');
		const options = {
			center: new kakao.maps.LatLng(latitude, longitude),
			level: 3
		};

		const map = new kakao.maps.Map(container, options);
	}

	function getLocation() {
	  if ("geolocation" in navigator) {
	    navigator.geolocation.getCurrentPosition(function(position) {
	      const latitude = position.coords.latitude;
	      const longitude = position.coords.longitude;
	      getKakaoMap(latitude, longitude);
	    });
	  } else {
	    console.log("Geolocation을 지원하지 않는 브라우저입니다.");
	  }
	}

	window.onload = function() {
	  getLocation();
	};

</script>
<script>
	function updateAreaOptions() {
		$.ajax({
			url: "/getAreas",
			method: "GET",
			success: function (areas) {
				// Area select 옵션 업데이트
				$("#area").empty().append("<option value=''>전체</option>");
				$("#sigungu").empty().append("<option value=''>전체</option>");
				areas.forEach(function (area) {
					$("#area").append(
						"<option value='" + area.area + "'>" + area.content
						+ "</option>");
				});
			},
			error: function () {
				alert("Area 정보를 가져오지 못했습니다.");
			}
		});
	}
	
	function updateSigunguOptions(selectedArea) {
		$
			.ajax({
				url: "/getSigungu/" + selectedArea,
				method: "GET",
				success: function (sigungu) {
					// Sigungu select 옵션 업데이트
					$("#sigungu").empty().append(
						"<option value=''>전체</option>");
					sigungu.forEach(function (s) {
						$("#sigungu").append(
							"<option value='" + s.sigungu + "'>"
							+ s.content + "</option>");
					});
				},
				error: function () {
					alert("Sigungu 정보를 가져오지 못했습니다.");
				}
			});
	}
	document.addEventListener("DOMContentLoaded", function() {
		updateAreaOptions();
		$("#area").change(function() {
				const selectedArea = $(this).val();
		if (selectedArea) {
			updateSigunguOptions(selectedArea);
				} else {
			$("#sigungu").empty().append("<option value=''>---</option>");
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
			<div class="container col-3 overflow-auto">
				<div class="container">
					<div class="m-3">
						<label for="area" class="form-label">지역</label>
						<select name="area" id="area" class="form-select col-auto"></select> 
					</div>
					<div class="m-3">
						<label for="sigungu" class="form-label">지역상세</label>
						<select name="sigungu" id="sigungu" class="form-select col-auto"></select>
					</div>
					<div class="m-3">
						<label for="tag" class="form-label">테마별</label>
						<select name="tag" id="tag" class="form-select col-auto"></select>						
						<input type="text" class="form-control" id="searchTag" placeholder="태그 검색하기">
					</div>				
					<hr>
				</div>
				<div class="container-fluid">
					<div class="m-3">
						<label for="area" class="form-label">목록 보기</label>
						<div class="">
							<div class="card" >
							  <img src="..." class="card-img-top" alt="...">
							  <div class="card-body">
							    <h5 class="card-title">Card title</h5>
							    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
							    <a href="#" class="btn btn-primary">Go somewhere</a>
							  </div>
							</div>
							<div class="card" >
							  <img src="..." class="card-img-top" alt="...">
							  <div class="card-body">
							    <h5 class="card-title">Card title</h5>
							    <p class="card-text">Some quick example text to build on the card title and make up the bulk of the card's content.</p>
							    <a href="#" class="btn btn-primary">Go somewhere</a>
							  </div>
							</div>
						</div>
					</div>
				
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