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
			<!-- Section2: Search Form -->
			<div class="container col-9 justify-content-center my-5">
				<form action="qna" method="POST" class="container justify-content-center">
						<!-- 검색어 -->
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">검색어</label>
							<div class="col-4">
							<select name="searchType" name="searchType" class="form-select" >
								<option selected value="name">게시물명</option>
								<option value="nickname">작성자</option>
							</select>
						</div>
			                <div class="col-5 mx-2 d-flex justify-content-center">	
								<input type="text" name="keyword" class="form-control" placeholder="keyword를 입력하세요">
								<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
							</div>
						</div>
					</form>
				</div>		
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center my-2 border p-2">
					<table id="qnaTable" class="table table-striped table-sm text-center mb-3">
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