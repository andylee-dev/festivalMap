<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>축제 상세 정보</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteConfirm() {
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href="../content/accomodationDelete?contentId=${accomodation.content_id}";
				}
			}
			
			function approveConfirm() {
				var contentId = Number(${accomodation.content_id});
				if(confirm("승인하시겠습니까?")) {
					location.href="../content/accomodationApprove?contentId="+contentId+"&currentPage=${currentPage}";
				}
			}
		</script>
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
   			 <div style="overflow-y: auto; max-height: 80vh;">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">축제 상세 정보</h1>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
					<c:if test="${msg != null}">${msg}</c:if>
					<table class="table table-striped table-sm">
						<tr>
							<th>컨텐츠 ID</th>
							<td>${accomodation.content_id}</td>
						</tr>
						<tr>
							<th>분류</th>
							<td>[${accomodation.big_code}] ${accomodation.small_code}</td>
						</tr>
						<tr>
							<th>숙소명</th>
							<td>${accomodation.title}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${accomodation.postcode}<br>${accomodation.address}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${accomodation.phone}</td>
						</tr>
						<tr>
							<th>홈페이지</th>
							<td><a href="${accomodation.homepage}">${accomodation.homepage}</a></td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${accomodation.phone}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${accomodation.email}</td>
						</tr>
						<tr>
							<th>객실수</th>
							<td>${accomodation.room_count}</td>
						</tr>
						
						<tr>
							<th>예약처</th>
							<td>${accomodation.reservation_url}</td>
						</tr>
						
						<tr>
							<th>환불규정</th>
							<td>${accomodation.refund}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>${accomodation.content}</td>
						</tr>
						<tr>
							<th>입실시간</th>
							<td>${accomodation.check_in}</td>
						</tr>
						<tr>
							<th>퇴실시간</th>
							<td>${accomodation.check_out}</td>
						</tr>
						<tr>
							<th>이미지</th>
							<td>
								<img alt="${accomodation.title}이미지1" src="${accomodation.img1}"><br>
								<img alt="${accomodation.title}이미지2" src="${accomodation.img2}"><br>
								<img alt="${accomodation.title}이미지3" src="${accomodation.img3}"></td>
						</tr>
						<tr>
							<th>태그</th>
							<td><!-- 전체 태그 보여주기 --></td>
						</tr>
						<tr>
							<th>가능 여부</th>
							<td>
								<ul>
									<li>픽업 : 
										<c:choose>
											<c:when test="${accomodation.is_pickup == 0}">N</c:when>
											<c:when test="${accomodation.is_pickup == 1}">Y</c:when>
										</c:choose>
									<li>조리 : 
										<c:choose>
											<c:when test="${accomodation.is_cook == 0}">N</c:when>
											<c:when test="${accomodation.is_cook == 1}">Y</c:when>
										</c:choose>
									<li>주차 : 
										<c:choose>
											<c:when test="${accomodation.is_parking == 0}">N</c:when>
											<c:when test="${accomodation.is_parking == 1}">Y</c:when>
										</c:choose>
								</ul>
							</td>
						</tr>
						<tr>
							<th>등록자 ID</th>
							<td>${accomodation.user_id}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td><fmt:formatDate value="${accomodation.created_at}" type="date" pattern="YY/MM/dd"/></td>
						</tr>
						<tr>
							<th>지도</th>
							<td><div id="map" style="width:500px;height:400px; margin: 0 auto;"></div></td>
						</tr>
					</table>
					<script  type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=3d40db7fe264068aa3438b9a0b8b2274"></script>
					<script>
 					   var accomodation_mapx = ${accomodation.mapx};
  				       var accomodation_mapy = ${accomodation.mapy};

    				   var mapContainer = document.getElementById('map');
    				   var mapOption = {
     									   center: new kakao.maps.LatLng(accomodation_mapy, accomodation_mapx),
        								   level: 3,
        								   mapTypeId : kakao.maps.MapTypeId.ROADMAP
   										}; 

    				  var map = new kakao.maps.Map(mapContainer, mapOption);

    				  var marker = new kakao.maps.Marker({
            			  position: new kakao.maps.LatLng(accomodation_mapy, accomodation_mapx),
            			  map: map
        													});
					</script>
					<div align="center">
						<c:if test="${accomodation.status == 0}">
							<button type="button" class="btn btn-outline-secondary" onclick="approveConfirm()">승인</button>
							<button type="button" class="btn btn-outline-secondary">반려</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='../content/accomodation?currentPage=1'">목록</button>
						</c:if>
						<c:if test="${accomodation.status == 1}">
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='../content/accomodationUpdateForm?contentId=${accomodation.content_id}&currentPage=${currentPage}'">수정</button>
							<button type="button" class="btn btn-outline-secondary" onclick="deleteConfirm()">삭제</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='../content/accomodation?currentPage=1'">목록</button>
						</c:if>
					</div>
				</div>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>