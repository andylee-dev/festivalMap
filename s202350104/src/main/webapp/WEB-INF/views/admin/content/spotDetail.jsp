<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>명소 상세 정보</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteConfirm() {
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href="spotDelete?contentId=${spot.content_id}";
				}
			}
			
			function approveConfirm() {
				var contentId = Number(${spot.content_id});
				if(confirm("승인하시겠습니까?")) {
					location.href="spotApprove?contentId="+contentId+"&currentPage=${currentPage}";
				}
			}
			// 승인하고나서 승인이 완료되었습니다 메세지도 띄울 수 있었으면 좋겠다
		</script>
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-10 overflow-auto p-0">
			
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-pencil-square "></i>
						<label  class="admin-header-title ">명소 상세 정보 </label>					
					</div>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
					<c:if test="${msg != null}">${msg}</c:if>
					<table class="table table-striped table-sm">
						<tr>
							<th>컨텐츠 ID</th>
							<td>${spot.content_id}</td>
						</tr>
						<tr>
							<th>분류</th>
							<td>[${spot.bcode_content}] ${spot.scode_content}</td>
						</tr>
						<tr>
							<th>명소명</th>
							<td>${spot.title}</td>
						</tr>
						<tr>
							<th>영업시간</th>
							<td>${spot.opening_hours}</td>
						</tr>
						<tr>
							<th>휴무일</th>
							<td>${spot.rest_date}</td>
						</tr>
						<tr>
							<th>입장료</th>
							<td>${spot.entrance_fee}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${spot.phone}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${spot.email}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${spot.postcode}<br>${spot.address}</td>
						</tr>
						<tr>
							<th>개요</th>
							<td>${spot.content}</td>
						</tr>
						<tr>
							<th>홈페이지</th>
							<td><a href="${spot.homepage}">${spot.homepage}</a></td>
						</tr>
						<tr>
							<th>이미지</th>
							<td>
								<img alt="${spot.title}이미지1" src="${spot.img1}"><br>
								<img alt="${spot.title}이미지2" src="${spot.img2}"><br>
								<img alt="${spot.title}이미지3" src="${spot.img3}"></td>
						</tr>
						<tr>
							<th>태그</th>
							<td><!-- 전체 태그 보여주기 --></td>
						</tr>
						<tr>
							<th>가능 여부</th>
							<td>
								<ul>
									<li>주차시설 : 
										<c:choose>
											<c:when test="${spot.is_parking == 0}">N</c:when>
											<c:when test="${spot.is_parking == 1}">Y</c:when>
										</c:choose>
									<li>유모차대여 : 
										<c:choose>
											<c:when test="${spot.is_stroller == 0}">N</c:when>
											<c:when test="${spot.is_stroller == 1}">Y</c:when>
										</c:choose>
									<li>휠체어대여 : 
										<c:choose>
											<c:when test="${spot.is_wheelchair == 0}">N</c:when>
											<c:when test="${spot.is_wheelchair == 1}">Y</c:when>
										</c:choose>
									<li>장애인화장실 : 
										<c:choose>
											<c:when test="${spot.is_restroom == 0}">N</c:when>
											<c:when test="${spot.is_restroom == 1}">Y</c:when>
										</c:choose>
									<li>반려동물동반 : 
										<c:choose>
											<c:when test="${spot.is_pet == 0}">N</c:when>
											<c:when test="${spot.is_pet == 1}">Y</c:when>
										</c:choose>	
								</ul>
							</td>
						</tr>
						<tr>
							<th>등록자 ID</th>
							<td>${spot.user_id}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td><fmt:formatDate value="${spot.created_at}" type="date" pattern="YY/MM/dd"/></td>
						</tr>
					</table>
					<div align="center">
						<c:if test="${spot.status == 0}">
							<button type="button" class="btn btn-outline-secondary" onclick="approveConfirm()">승인</button>
							<button type="button" class="btn btn-outline-secondary">반려</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='spot?currentPage=${currentPage}'">목록</button>
						</c:if>
						<c:if test="${spot.status == 1}">
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='spotUpdateForm?contentId=${spot.content_id}&currentPage=${currentPage}'">수정</button>
							<button type="button" class="btn btn-outline-secondary" onclick="deleteConfirm()">삭제</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='spot'">목록</button> <%-- ?currentPage=${currentPage} --%>
						</c:if>
					</div>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>