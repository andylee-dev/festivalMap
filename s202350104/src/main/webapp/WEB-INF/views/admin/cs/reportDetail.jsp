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
				<h1 class="border">신고 상세리스트</h1>
			</div>
		<!-- Section3: Table -->		
			<div class="container border p-5">
				<table>
					<tr><th>게시글ID</th><td>${boardDetail.id}</td></tr>
					<tr><th>작성자ID</th><td>${boardDetail.user_id}</td></tr>
					<tr><th>제목</th><td>${boardDetail.title}</td></tr>
					<tr><th>내용</th><td>${boardDetail.content}</td></tr>
				</table>	
				</div>
			<div class="border p-3 m-3">
				<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">신고ID</th>
							<th scope="col">글내용</th>
							<th scope="col">작성일</th>
							<th scope="col">상태</th>
							
						</tr>
					</thead>
					<tbody>
						<c:forEach var="report" items="${reportDetail}">
							<tr>
								<td>${report.user_id}</td>
								<td>${report.content}</td>
								<td>${report.created_at}</td>
								<td>${report.status}</td>
							</tr>
							<tr>
						</c:forEach>
					</tbody>
				</table>
				<button onclick="location.href='reportBoardUpdate?id=${boardDetail.id}'">게시글삭제</button>
				<button onclick="location.href='reportUpdate?id=${boardDetail.id}'">신고글반려</button>
				<button onclick="location.href='report'">이전</button>
			</div>			
		</main>
	</div>
	</div>