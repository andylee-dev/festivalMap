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
				<h1 class="border">타이틀</h1>
			</div>
	
			<!-- Section2: Search Form -->		
			<div class="border p-3 m-3">
				<h1 class="border">검색폼</h1>
				<button type="button" class="btn btn-outline-secondary">검색</button>
				<button type="button" class="btn btn-outline-secondary">초기화</button>
			</div>		
			
			<!-- Section3: Table -->		
			<div class="border p-3 m-3">
				<button type="button" class="btn btn-outline-secondary">등록</button>
				<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">1</th>
							<th scope="col">2</th>
							<th scope="col">3</th>
							<th scope="col">4</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>100</td>
							<td>100</td>
							<td>100</td>
							<td>100</td>
						</tr>
						<tr>
							<td>100</td>
							<td>100</td>
							<td>100</td>
							<td>100</td>
						</tr>
					</tbody>
				</table>
			</div>		
		</main>
	</div>
	</div>

</body>
</html>