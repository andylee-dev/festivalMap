<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main>
		<div class="d-flex">
			<div class="col-2">
			<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			</div>
			<div class="container p-5 col-10">
			
				<!-- Section1: Title -->				
				<div class="container my-5">
					<h1>내 게시글 관리</h1>
					<hr class="hr" />

			<!-- Section3: Table -->		
			<div class="container col-9 justify-content-center my-2">
				<button type="button" class="btn btn-outline-secondary mt-4" onclick="location.href='../../integratedBoardInsertForm'">등록</button>
			</div>
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container table-container p-4">
						<div class="table-responsive">	
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">제목</th>
									<th scope="col">작성일</th>
									<th scope="col">수정일</th>
									<th scope="col">관리</th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="${page.start}"/>
								<c:forEach var="board" items="${oneBoardList}" varStatus="status">
									<input type="hidden" name="user_id" value="${board.user_id}" id="user_id${status.index}">
									<input type="hidden" name="id" value="${board.id}" id="id${status.index}">
										<tr id="board${status.index}">
											<td>${num}</td>
											<td><a href="../../boardDetail?id=${board.id}&userId=${board.user_id}"><c:if test="${board.status == 1}">[답변완료]</c:if>${board.title}</a></td>
											<td><fmt:formatDate value="${board.created_at}" type="date" pattern="YY/MM/dd"/></td>
											<td><c:if test="${board.status == 0}">답변대기</c:if>
												<c:if test="${board.status == 1}">답변완료</c:if>
											<td><a class="detail-btn" href="../../boardUpdateForm?id=${board.id}&userId=${board.user_id}">관리</a></td>
										</tr>
										<c:set var="num" value="${num + 1}"/>
									</c:forEach>
							</tbody>
						</table>
						</div>
					</div>
				</div>
					<nav aria-label="Page navigation example ">
						<ul class="pagination">
							<c:if test="${page.startPage > page.pageBlock}">
								<li class="page-item">
									<a href="mypost?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
								</li>
							</c:if>
							<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
								<li class="page-item">
									<a href="myPost?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
								</li>
							</c:forEach>
							<c:if test="${page.endPage < page.totalPage}">
								<li class="page-item">
									<a href="myPost?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
								</li>
							</c:if>
						</ul>
					</nav>						
					
					
					
					
					
					
				</div>
			</div>
		</div>
	</main>
</body>
</html>