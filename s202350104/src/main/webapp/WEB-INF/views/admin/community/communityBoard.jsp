<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Community Board</title>
<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-10 overflow-auto p-0">
			
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-file-text-fill "></i>
						<c:choose>
							<c:when test="${smallCode eq 2}">
								<label  class="admin-header-title ">이달의 소식 관리</label>
							</c:when>
							<c:when test="${smallCode eq 3}">
								<label  class="admin-header-title ">자유게시판 관리</label>
							</c:when>
					    	<c:otherwise>
					        	<label  class="admin-header-title ">리뷰 관리</label>
					    	</c:otherwise>
						</c:choose>
					</div>
				</div>
				
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center mt-5">
					<form action="favoriteSearch" method="POST" class="container justify-content-center">	
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="col-form-label col-2  mx-2">검색어</label>
							<div class="col-4">
								<select name="search" class="form-select">
									<option value="s_name">제목조회</option>
								</select> 
							</div>
							<div class="col-5 mx-2 d-flex justify-content-center">	
								<input type="text" name="keyword" class="form-control" placeholder="keyword를 입력하세요">
								<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
							</div>
						</div>	
					</form>
				</div>
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<c:choose>
							<c:when test="${smallCode eq 2}">
								<button onclick="location.href='../../integratedBoardInsertForm?userId=${userId}&bigCode=${bigCode }&smallCode=${smallCode }'" 
								id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4">등록</button>					
							</c:when>			
							<c:when test="${smallCode eq 3}">
								<button onclick="location.href='../../integratedBoardInsertForm?userId=${userId}&bigCode=${bigCode }&smallCode=${smallCode }'" 
								id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4">등록</button>					
							</c:when>			
						</c:choose>
					</div>

				
					<!-- Section3: Table -->													
					<c:set var="num" value="${page.total-page.start+1 }"/>
					<div class="container table-container p-4">
						<div class="table-responsive">
							<table id="userTable" class="table table-md text-center p-3">
								<thead>
									<tr>
										<th scope="col">순번</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">등록일</th>
										<c:if test="${smallCode eq 2 || smallCode eq 3}">
											<th scope="col">수정일</th>
										</c:if>
										<th scope="col">게시여부</th>
										<th scope="col">삭제여부</th>
										<th scope="col">관리</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="boards" items="${admin }">
										<tr>
											<td>${num }</td>
											<c:choose>
												<c:when test="${smallCode eq 6}">
													<td>${boards.content }</td>
												</c:when>
												<c:otherwise>
													<td>${boards.title }</td>
												</c:otherwise>
											</c:choose>
											<td>${boards.name }</td>
											<td><fmt:formatDate value="${boards.created_at }" type="date" pattern="YY/MM/dd"/></td>
											<c:if test="${smallCode eq 2 || smallCode eq 3}">
											<td><fmt:formatDate value="${boards.updated_at }" type="date" pattern="YY/MM/dd"/></td>
											</c:if>	
											<c:choose>
												<c:when test="${boards.status eq 0}">
													<td>N</td>
												</c:when>
												<c:when test="${boards.status eq 1}">
													<td>Y</td>
												</c:when>
											</c:choose>																				
											<c:choose>
												<c:when test="${boards.is_deleted eq 0}">
													<td>N</td>
												</c:when>
												<c:when test="${boards.is_deleted eq 1}">
													<td>Y</td>
												</c:when>
											</c:choose>	
										
											<td><a class="detail-btn" href="communityDetail?id=${boards.id}&userId=${userId}">관리</a></td>
<%-- 											<td><a class="detail-btn" href="../../boardUpdateForm?id=${boards.id}&userId=${userId}">관리</a></td> --%>
<%-- 											<td><a class="detail-btn" href="../../boardDelete?id=${boards.id}&userId=${userId }&smallCode=${boards.small_code }">삭제</a></td> --%>
										</tr>
										<c:set var="num" value="${num - 1 }"/>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
					
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
					<c:choose>
						<c:when test="${smallCode eq 2}">
								<c:if test="${page.startPage > page.pageBlock}">
									<li class="page-item">
										<a href="magazin?currentPage=${page.startPage-page.pageBlock}"
									  	   class="pageblock page-link">[이전]</a>
									</li>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<li class="page-item">
										<a href="magazin?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<li class="page-item">
										<a href="magazin?currentPage=${page.startPage+page.pageBlock}"
									   	   class="pageblock page-link">[다음]</a>
									</li>
								</c:if>
						</c:when>
						<c:when test="${smallCode eq 3}">
								<c:if test="${page.startPage > page.pageBlock}">
									<li class="page-item">
										<a href="board?currentPage=${page.startPage-page.pageBlock}"
									   	   class="pageblock page-link">[이전]</a>
									</li>   
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<li class="page-item">
										<a href="board?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<li class="page-item">
										<a href="board?currentPage=${page.startPage+page.pageBlock}"
									   	   class="pageblock page-link">[다음]</a>
									</li>
								</c:if>
						</c:when>
						<c:when test="${smallCode eq 6}">
								<c:if test="${page.startPage > page.pageBlock}">
									<li class="page-item">
										<a href="review?currentPage=${page.startPage-page.pageBlock}"
									   	   class="pageblock page-link">[이전]</a>
									</li> 
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<li class="page-item">
										<a href="review?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</li> 
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<li class="page-item">
										<a href="review?currentPage=${page.startPage+page.pageBlock}"
									       class="pageblock page-link">[다음]</a>
									</li> 
								</c:if>
						</c:when>
					</c:choose>
					</ul>
				</nav>	
			</main>
		</div>
	</div>
</body>
</html>