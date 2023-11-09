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
							<th scope="col">상세보기</th>
						</tr>
					</thead>
					<tbody>
					
						<c:forEach var="report" items="${listReport}">
						<tr>
								<td>${report.board_id}</td>
								<td>${report.content}</td>
								<td>${report.user_id}</td>
								<td>${report.count}</td>
								<td><button onclick="location.href='reportDetail?boardId=${report.board_id}'">상세보기</button></td>
						</tr>
						</c:forEach>
					</tbody>
				</table>
				
				<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="report?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="report?currentPage=${i}" class="pageblock">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="report?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
						</c:if>
					</div>
			</div>		
		</main>

	</div>
	</div>
</body>
</html>