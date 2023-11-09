<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>맛집 상세 정보</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteConfirm(){
				if(confirm("정말 삭제하시겠습니까?")){
					location.href="restaurantDelete?contentId=${restaurant.content_id}";		
				}
			}
			
			function approveConfirm(){
				var contentId = Number(${restaurant.content_id});
				if(confirm("정말 승인하시겠습니까?")){
					location.href="restaurantApprove?contentId="+contentId+"&currentPage=${currentPage}";
				}
				
			}
		
		
		
		</script>
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
				
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">맛집 상세 정보</h1>
				</div>
					
					<!-- Section2: Table -->		
				<div class="border p-3 m-3" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
					<c:if test="${msg != null}">${msg}</c:if>
					<table class="table table-striped table-sm">
						<tr><th>콘텐츠ID</th><td>${restaurant.content_id}</td></tr>
						<tr><th>분류</th><td>${restaurant.theme}</td></tr>	
						<tr><th>음식점명</th><td>${restaurant.title}</td></tr>
						<tr><th>주소</th><td>${restaurant.address}</td></tr>
						<tr><th>우편번호</th><td>${restaurant.postcode}</td></tr>
						<tr><th>전화번호</th><td>${restaurant.phone}</td></tr>
						<tr><th>대표메뉴</th><td>${restaurant.first_menu}</td></tr>
						<tr><th>추천메뉴</th><td>${restaurant.menu}</td></tr>
						<tr><th>영업시간</th><td>${restaurant.open_time}</td></tr>
						<tr><th>휴무일</th><td>${restaurant.rest_date}</td></tr>
						<tr><th>내용</th><td>${restaurant.content}</td></tr>
						<tr>
							<th>이미지</th>
							<td>
								<div>
									<img src="${restaurant.img1}" alt="${restaurant.img1}이미지1">
								</div>
								<div>
									<img src="${restaurant.img2}" alt="${restaurant.img2}이미지2" width = 150px height = 84px>
									<img src="${restaurant.img3}" alt="${restaurant.img3}이미지3" width = 150px height = 84px>
								</div>
							</td>
						</tr>
						<tr><th>태그</th><td></td></tr>
						<tr>
							<th>가능여부</th>
							<td>
								<ul>	
									<li>흡연: 
										<c:choose>
											<c:when test="${restaurant.is_smoking == 0 }">N</c:when>
											<c:when test="${restaurant.is_smoking == 1 }">Y</c:when>
										</c:choose>	
									 </li>
									 <li>포장:
									 	<c:choose>
									 		<c:when test="${restaurant.is_packing == 0 }">N</c:when>
									 		<c:when test="${restaurant.is_packing == 1 }">Y</c:when>
									 	</c:choose>
									 </li>
									 <li>주차: 
									 	<c:choose>
										 	<c:when test="${restaurant.is_parking == 0}">N</c:when>
										 	<c:when test="${restaurant.is_parking == 1}">Y</c:when>
									 	</c:choose>
									 </li>
								</ul>
							</td>
						</tr>
						<tr><th>등록자ID</th><td></td></tr>
						<tr><th>등록일</th><td></td></tr>
					</table>					
					<div align="center">
						<c:if test="${restaurant.status == 0}">
							<button type="button" class="btn btn-outline-secondary" onclick="approveConfirm()">승인</button>
							<button type="button" class="btn btn-outline-secondary">반려</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='restaurant?currentPage=1'">목록</button>
						</c:if>
						<c:if test="${restaurant.status == 1}">
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='restaurantUpdateForm?contentId=${restaurant.content_id}&currentPage=${currentPage}'">수정</button>
							<button type="button" class="btn btn-outline-secondary" onclick="deleteConfirm()">삭제</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='restaurant?currentPage=1'">목록</button>
						</c:if>
					</div>
				</div>												 
			</main>
		</div>
		</div>
	</body>
</html>