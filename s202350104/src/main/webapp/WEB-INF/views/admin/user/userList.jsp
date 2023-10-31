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
	<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<!-- Section1: Title -->
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="border">일반 회원 리스트</h1>
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
							<th scope="col">id</th>
							<th scope="col">name</th>
							<th scope="col">password</th>
							<th scope="col">nickname</th>
							<th scope="col">birthday</th>
							<th scope="col">phone_num</th>
							<th scope="col">email</th>
							<th scope="col">address</th>
							<th scope="col">status</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="user" items="${listUsers}">
							<tr>
								<td>${user.id}</td>
								<td>${user.name}</td>
								<td>${user.password}</td>
								<td>${user.nickname}</td>
								<td>${user.birthday}</td>
								<td>${user.phone_num}</td>
								<td>${user.email}</td>
								<td>${user.address}</td>
								<td>${user.status}</td>
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