<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/header.jsp" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
<title>숙박 상세</title>
<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

    .thumbnail {
      cursor: pointer;
      width: 70%;
      height: 70%;
      display: block;
      margin: auto;
    }
    
    #largeImage {
      display: none;
      position: fixed;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      z-index: 999;
    }
    #overlay {
      display: none;
      position: fixed;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background: rgba(0,0,0,0.7);
      z-index: 998;
    }
	.custom-ul {
   	 list-style: none; /* 목록 기호 제거 */
   	 padding: 0;
   	 line-height: 2.5;

	}

	.custom-ul li:before {
    	content: '\2022'; /* 핑크색 원 모양 기호 */
    	color: hotpink; /* 핑크색 */
    	display: inline-block;
    	width: 1em;
    	margin-left: -1em;
	}
	
    
  </style>

<script>
	function showPopUp(userId, bigCode, smallCode, currentPage, contentId, commonCode) {
	    console.log("showPopUp 함수가 호출되었습니다.");			
		//창 크기 지정
		var width = 550;
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
	
	function report(boardId) {
	    window.open("../reportBoardFoam?boardId=" + boardId, "_blank", "width=600, height=400, top=100, left=100");
	}
</script>
</head>
<body>

	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<div style="width: 100%; background: #FF4379; color: white; text-align: left; padding: 10px 0; margin-top: 100px;">
    	<h2 style="padding-left: 50px;">${accomodation.title}</h2>
	</div>
	<div class="container border p-5" style="justify-content: space-between; height: 700px">
    <table>
        <tr>
			<td style="width:10%; height: 100%; text-align:left; margin-left: -40px;">
			 <img class="thumbnail" alt="${accomodation.title}이미지1" src="${accomodation.img1}" style="width: 313px; height: 525px; object-fit: cover; margin-left: 0px;" align="absmiddle">
			</td>
			<td style="width:10%; text-align:center; vertical-align:middle; margin: 16px 0px 16px 0px;">
	   		 <img class="thumbnail" alt="${accomodation.title}이미지2" src="${accomodation.img2}"  style= "object-fit: cover; margin-left: -40px;" align="absmiddle">
	   		 <br><img class="thumbnail" alt="${accomodation.title}이미지3" src="${accomodation.img3}" style= "object-fit: cover; margin-left: -40px;" align="absmiddle">
			</td>
			<td style="width:20%; text-align:left;">
			    <ul class="custom-ul" style="width: 50%; padding-left: 20px;">
        <li><b>상호명</b>  ${accomodation.title}</li>
        <li><b>주소</b>  ${accomodation.address}</li>
        <li><b>우편번호</b>  ${accomodation.postcode}</li>
        <li><b>전화번호</b>  ${accomodation.phone}</li>
        <li><b>홈페이지</b>  <a href="${accomodation.homepage}">${accomodation.homepage}</a></li>
        <li><b>객실수</b>  ${accomodation.room_count}</li>
        <li><b>예약처</b>  <a href="${accomodation.reservation_url}">${accomodation.reservation_url}</a></li>
        <li><b>환불규정</b>  ${accomodation.refund}</li>
        <li><b>입실시간</b>  ${accomodation.check_in}</li>
        <li><b>퇴실시간</b>  ${accomodation.check_out}</li>
    </ul>
    <b>픽업가능</b> 
            <c:choose>
                <c:when test="${accomodation.is_cook == 0}">Y</c:when>
                <c:when test="${accomodation.is_cook == 1}">N</c:when>
            </c:choose>
	<b>조리가능</b>  
    	<c:choose>
        <c:when test="${accomodation.is_cook == 0}">
            <img src="cooking_icon.png" alt="조리가능 아이콘" style="width: 20px; height: 20px; margin-left: 5px;"> <!-- 조리가능 이미지 -->
        </c:when>
        <c:when test="${accomodation.is_cook == 1}">N</c:when>
    	</c:choose>
	
	  <b>주차시설</b>  
    	<c:choose>
        <c:when test="${accomodation.is_parking == 0}">
            <img src="parking_icon.png" alt="주차시설 아이콘" style="width: 20px; height: 20px; margin-left: 5px;"> <!-- 주차시설 이미지 -->
        </c:when>
        <c:when test="${accomodation.is_parking == 1}">N</c:when>
   	 </c:choose>

			
			</td>
           </tr>
    </table>
    </div>
	
<div id="overlay"></div>
	<div id="largeImageContainer">
    <img id="largeImage" src="" alt="Large Image">
    </div>
    <script>
    const thumbnails = document.querySelectorAll('.thumbnail');
    const largeImage = document.getElementById('largeImage');
    const overlay = document.getElementById('overlay');

    thumbnails.forEach(thumbnail => {
        thumbnail.addEventListener('click', function () {
            largeImage.src = this.src;
            largeImage.style.display = 'block';
            overlay.style.display = 'block';
        });
    });

    overlay.addEventListener('click', function () {
        largeImage.style.display = 'none';
        overlay.style.display = 'none';
    });
	</script>
	<div class="container border p-5">
		<h2 style="color: hotpink;">개요</h2>
		<p>${accomodation.content}
	</div>
	<!-- review test -->
	<c:set var="num" value="${page.total-page.start+1 }" />
	<div class="container border p-5">
		<div class="d-flex justify-content-end">
		    <button class="btn btn-primary" onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${accomodation.content_id},${accomodation.big_code})">리뷰쓰기</button>		
		</div><br>
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
					<td class="text-center">
						<a href="../boardDetail?id=${review.id }">${review.content }</a>
					</td>
					<td class="text-center">${review.name }</td>
					<td class="text-center">
						<fmt:formatDate value="${review.created_at }" 
										type="date" pattern="YYYY/MM/dd" /></td>
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
						<li class="page-item">
							<c:if test="${page.startPage > page.pageBlock }">
								<a class="page-link" href="reviewBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
							</c:if>
						</li>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a class="page-link" href="reviewBoardList?currentPage=${i}">${i}</a>
							</li>
						</c:forEach>
						<li class="page-item">
							<c:if test="${page.endPage < page.totalPage }">
								<a class="page-link" href="reviewBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
							</c:if>
						</li>
					</c:when>
				</c:choose>
			</ul>
		</nav>
	</div>

	<h2>지도</h2>
	<div id="map" style="width: 500px; height: 400px; margin: 0 auto;"></div>

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=API키 입력"></script>
	<script>
			var accomodation_mapx=[[${accomodation.mapx}]];
			var accomodation_mapy=[[${accomodation.mapy}]];
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		    mapOption = {
		        center: new kakao.maps.LatLng([[${accomodation.mapy}]], [[${accomodation.mapx}]]), // 지도의 중심좌표
		        level: 3, // 지도의 확대 레벨
		        mapTypeId : kakao.maps.MapTypeId.ROADMAP // 지도종류
		    }; 

		// 지도를 생성한다 
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 지도에 마커를 생성하고 표시한다
		var marker = new kakao.maps.Marker({
		    position: new kakao.maps.LatLng([[${accomodation.mapy}]], [[${accomodation.mapx}]]), // 마커의 좌표
		    map: map // 마커를 표시할 지도 객체
		});

	</script>
	<div align="center">
		<button onclick="location.href='../accomodation'">목록</button>
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
	
</body>
</html>


