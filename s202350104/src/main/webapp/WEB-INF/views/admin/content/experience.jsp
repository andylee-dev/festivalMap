<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>  

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>experience content list</h1>

	<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<!-- Section1: Title -->
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="border">체험 리스트</h1>
			</div>
	
			<!-- Section2: Search Form -->		
			<div class="border p-3 m-3">
				<h1 class="border">검색폼</h1>
				<button type="button" class="btn btn-outline-secondary">검색</button>
				<button type="button" class="btn btn-outline-secondary">초기화</button>
			</div>		
			
			<!-- Section3: Table -->		
			<div class="border p-3 m-3">
				<button type="button" class="btn btn-outline-secondary ">등록</button>
				<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">등록IDddd</th>
							<th scope="col">체험이름</th>
							<th scope="col">상태</th>
							<th scope="col">주소</th>
							<th scope="col">우편번호</th>
							<th scope="col">이메일</th>
							<th scope="col">전화번호</th>
							<th scope="col">홈페이지</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="experience" items="${listExperience}">
							<tr>
								<td>${experience.id}</td>
								<td>${experience.title}</td>
								<td>${experience.status}</td>
								<td>${experience.address}</td>
								<td>${experience.postcode}</td>
								<td>${experience.email}</td>
								<td>${experience.phone}</td>
								<td>${experience.homepage}</td>
								
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>		
		</main>
	</div>
	</div>

</body>
</html>