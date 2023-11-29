<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPost</title>
<link rel="stylesheet" type="text/css" href="/css/myPost.css">
<link rel="stylesheet" type="text/css" href="/css/adminTable.css">
</head>
<body>
	<main>
		<div class="d-flex">
			<div class="col-2">
				<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			</div>
			<div class="container p-5 col-10">

				<!-- Section1: Title -->
				<div class="container my-5">
				<h1>내&nbsp;게시글&nbsp;관리</h1>
				<hr class="hr" />

				<!-- Section3: Table -->
				<div class="col my-first-title">
					<h2>내&nbsp;게시글&nbsp;현황</h2>
				</div>
					
				<c:set var="num" value="${page.total-page.start+1 }" />
				<div class="container my-board-custom">
					<div class="table-responsive">
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">등록일</th>
										<th scope="col">수정일</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="boards" items="${oneBoardList }">
										<tr>
											<td>${num }</td>
											<td>${boards.title }</td>
											<td>${boards.name }</td>
											<td><fmt:formatDate value="${boards.created_at }"
													type="date" pattern="YY/MM/dd" /></td>
											<td><fmt:formatDate value="${boards.updated_at }"
													type="date" pattern="YY/MM/dd" /></td>
											<td><a class="detail-btn" style="color: #FF4379;"
												href="myPostDetail?id=${boards.id}&userId=${boards.user_id}">관리</a></td>
										</tr>
										<c:set var="num" value="${num - 1 }" />
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
				
				
					<!-- Section3: Table -->
					<div class="col my-first-title">
						<h2>내&nbsp;Review&nbsp;현황</h2>
					</div>
					<c:set var="num" value="${page.total-page.start+1 }" />
					<div class="container my-board-custom">
						<div class="table-responsive">
							<table id="userTable" class="table table-md text-center p-3">
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">등록일</th>
										<th scope="col">수정일</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="boards" items="${oneReviewList }">
										<tr>
											<td>${num }</td>
											<td>${boards.content }</td>
											<td>${boards.name }</td>
											<td><fmt:formatDate value="${boards.created_at }"
													type="date" pattern="YY/MM/dd" /></td>
											<td><fmt:formatDate value="${boards.updated_at }"
													type="date" pattern="YY/MM/dd" /></td>
											<td><a class="detail-btn" style="color: #FF4379;"
												href="myPostDetail?id=${boards.id}&userId=${boards.user_id}">관리</a></td>
										</tr>
										<c:set var="num" value="${num - 1 }" />
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>				

				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item"><a
								href="myPost?currentPage=${page.startPage-page.pageBlock}"
								class="pageblock page-link">[이전]</a></li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item"><a href="myPost?currentPage=${i}"
								class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item"><a
								href="myPost?currentPage=${page.startPage+page.pageBlock}"
								class="pageblock page-link">[다음]</a></li>
						</c:if>
					</ul>
				</nav>
			</div>
		</div>
	</main>
</body>
</html>