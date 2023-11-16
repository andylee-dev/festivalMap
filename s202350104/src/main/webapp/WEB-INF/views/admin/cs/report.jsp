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
		<main class="col-10 overflow-auto p-0">
			<!-- Section1: Title -->
			<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-chat-dots-fill"></i>
				<label class="admin-header-title ">신고리스트 </label>
					</div>
			</div>
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center my-2 border p-2">
				총 신고게시글 :	${totalReport}	 총 신고건수:${totalReportCount}	
					<table id="qnaTable" class="table table-striped table-sm text-center mb-3">
					<thead>
						<tr>
							<th scope="col">게시판ID</th>
							<th scope="col">글제목</th>
							<th scope="col">작성자</th>
							<th scope="col">신고횟수</th>
							<th scope="col">상세보기</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="report" items="${listReport}">
							<tr>
								<td>${report.board_id}</td>
								<td>
								<c:choose>
									<c:when test="${report.title eq null}">
										리뷰작성글입니다
									</c:when>
									<c:otherwise>
										${report.title}
									</c:otherwise> 
								</c:choose>	
								</td>
								<td>${report.name}</td>
								<td>${report.count}</td>
								<td><button class="btn btn-primary" onclick="location.href='reportDetail?boardId=${report.board_id}'">상세보기</button></td>
							</tr>
						</c:forEach>
					</tbody>
					</table>
				</div>	
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item">
								<a href="report?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">	
								<a href="report?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="report?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
							</li>
						</c:if>
					</ul>
				</nav>	
		</main>
	</div>
	</div>
</body>
</html>