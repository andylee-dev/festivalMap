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

	<h1>report list</h1>

	<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<!-- Section1: Title -->
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="border">신고 리스트</h1>
			</div>
		<!-- Section3: Table -->		
			<div class="border p-3 m-3">
				<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">게시판ID</th>
							<th scope="col">글내용</th>
							<th scope="col">작성자</th>
							<th scope="col">신고횟수</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="report" items="${listReport}">
							<tr>
								<td>${report.board_id}</td>
								<td>${report.content}</td>
								<td>${report.user_id}</td>
								<td>${report.count}</td>
								<td colspan="2">상세보기</td>
								
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