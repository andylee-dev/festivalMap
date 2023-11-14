<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>체험 상세 정보</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteConfirm() {
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href="../content/experienceDelete?contentId=${experience.content_id}";
				}
			}
			
			function approveConfirm() {
				var contentId = Number(${experience.content_id});
				if(confirm("승인하시겠습니까?")) {
					location.href="../content/experienceApprove?contentId="+contentId+"&currentPage=${currentPage}";
				}
			}
			
			function openRejectionPopup(contentId) {
			    window.open("rejectionFoam?contentId=" + contentId, "_blank", "width=600, height=400, top=100, left=100");
			}
			
		</script>				
	</head>
	<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">체험 상세 정보</h1>
				</div>
				
				<!-- Section2: Table -->		
				<div class="border p-3 m-3" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
					<table class="table table-striped table-sm">
						<tr>
							<th>컨텐츠 ID</th>
							<td>${experience.content_id}</td>
						</tr>
						<%-- <tr>
							<th>분류</th>
							<td>[${festival.bcode_content}] ${festival.scode_content}</td>
						</tr> --%>
						<tr>
							<th>축제명</th>
							<td>${experience.title}</td>
						</tr>
						<tr>
							<th>전화번호</th>
							<td>${experience.phone}</td>
						</tr>
						<tr>
							<th>이메일</th>
							<td>${experience.email}</td>
						</tr>
						<tr>
							<th>주소</th>
							<td>${experience.postcode}<br>${experience.address}</td>
						</tr>
						<tr>
							<th>개요</th>
							<td>${experience.content}</td>
						</tr>
						<tr>
							<th>내용</th>
							<td>${experience.inform}</td>
						</tr>
						<tr>
							<th>이용요금</th>
							<td>${experience.cost}</td>
						</tr>
						<tr>
							<th>홈페이지</th>
							<td><a href="${experience.homepage}">${experience.homepage}</a></td>
						</tr>
						<tr>
							<th>이미지</th>
							<td>
								<img alt="${experience.title}이미지1" src="${experience.img1}"><br>
								<img alt="${experience.title}이미지2" src="${experience.img2}"><br>
								<img alt="${experience.title}이미지3" src="${experience.img3}"></td>
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
											<c:when test="${experience.is_parking == 0}">N</c:when>
											<c:when test="${experience.is_parking == 1}">Y</c:when>
										</c:choose>
									<li>유모차대여 : 
										<c:choose>
											<c:when test="${experience.is_stroller == 0}">N</c:when>
											<c:when test="${experience.is_stroller == 1}">Y</c:when>
										</c:choose>
									<li>휠체어대여 : 
										<c:choose>
											<c:when test="${experience.is_pet == 0}">N</c:when>
											<c:when test="${experience.is_pet == 1}">Y</c:when>
										</c:choose>
									<li>장애인화장실 : 
										<c:choose>
											<c:when test="${experience.is_credit == 0}">N</c:when>
											<c:when test="${experience.is_credit == 1}">Y</c:when>
										</c:choose>
								</ul>
							</td>
						</tr>
						<tr>
							<th>등록자 ID</th>
							<td>${experience.user_id}</td>
						</tr>
						<tr>
							<th>등록일</th>
							<td><fmt:formatDate value="${experience.created_at}" type="date" pattern="YY/MM/dd"/></td>
						</tr>
					</table>
					 <div align="center">
						<c:if test="${experience.status == 0}">
							<button type="button" class="btn btn-outline-secondary" onclick="approveConfirm()">승인</button>
							<button type="button" class="btn btn-outline-secondary" onclick="openRejectionPopup(${experience.content_id})">반려</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='../content/experience?currentPage=1'">목록</button>
						</c:if>
						<c:if test="${experience.status == 1}">
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='../content/experienceUpdateForm?contentId=${experience.content_id}&currentPage=${currentPage}'">수정</button>
							<button type="button" class="btn btn-outline-secondary" onclick="deleteConfirm()">삭제</button>
							<button type="button" class="btn btn-outline-secondary" onclick="location.href='../content/experience?currentPage=1'">목록</button>
						</c:if>
					</div> 
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>