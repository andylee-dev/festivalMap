<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Board</title>
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
						<i class="title-bi bi bi-megaphone-fill "></i>
					<c:choose>
						<c:when test="${smallCode == 1}">
							<label  class="admin-header-title ">공지사항 관리</label>
						</c:when>
						<c:when test="${smallCode == 5}">
							<label  class="admin-header-title ">이벤트 관리</label>
						</c:when>
				    	<c:otherwise>
				        	<label  class="admin-header-title ">배너 관리</label> ${msg }
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
							<c:when test="${bigCode eq 3 }">
								<button onclick="location.href='../../bannerInsertForm?userId=${userId }&bigCode=${bigCode }&smallCode=${smallCode }'" 
								id="regist-btn" type="button" class="btn btn-primary btn-sm mb-2">등록</button>						
							</c:when>
							<c:otherwise>
								<button onclick="location.href='../../integratedBoardInsertForm?userId=${userId }&bigCode=${bigCode }&smallCode=${smallCode }'" 
								id="regist-btn" type="button" class="btn btn-primary btn-sm mb-2">등록</button>						
							</c:otherwise>
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
										<c:choose>
											<c:when test="${bigCode eq 2 }">
												<th scope="col">작성자</th>
											</c:when>
											<c:otherwise>
												<th scope="col">타입</th>
											</c:otherwise>
										</c:choose>
										<th scope="col">등록일</th>
										<th scope="col">수정일</th>
										<th scope="col">수정</th>
										<th scope="col">삭제</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="boards" items="${admin }">
										<tr>
											<td>${num }</td>
											<td>${boards.title }</td>
											<c:choose>
												<c:when test="${bigCode eq 2 }">
													<td>${boards.name }</td>
												</c:when>
												<c:otherwise>
													<td>${boards.content }</td>
												</c:otherwise>
											</c:choose>
											<td><fmt:formatDate value="${boards.created_at }" type="date" pattern="YY/MM/dd"/></td>
											<td><fmt:formatDate value="${boards.updated_at }" type="date" pattern="YY/MM/dd"/></td>
											<td><input class="btn btn-primary" onclick="location.href='../../boardUpdateForm?id=${boards.id}&userId=${userId}'" type="button" value="수정 "></td>
											<c:choose>
												<c:when test="${bigCode eq 3 }">
													<td><input class="btn btn-outline-secondary" onclick="location.href='../../bannerDelete?id=${boards.id}&userId=${userId}&smallCode=${boards.small_code }'" type="button" value="삭제"></td>										
												</c:when>
												<c:otherwise>
													<td><input class="btn btn-outline-secondary" onclick="location.href='../../boardDelete?id=${boards.id}&userId=${userId}&smallCode=${boards.small_code }'" type="button" value="삭제"></td>
												</c:otherwise>
											</c:choose>
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
						<c:when test="${bigCode eq 2}">
							<c:choose>
								<c:when test="${smallCode eq 1}">
										<c:if test="${page.startPage > page.pageBlock}">
											<li class="page-item">
											<a href="notice?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
											</li>
										</c:if>
										<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
											<li class="page-item">
											<a href="notice?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
											</li>
										</c:forEach>
										<c:if test="${page.endPage < page.totalPage}">
											<li class="page-item">
											<a href="notice?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
											</li>
										</c:if>
								</c:when>
								<c:when test="${smallCode eq 5}">
										<c:if test="${page.startPage > page.pageBlock}">
											<li class="page-item">
											<a href="event?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
											</li>
										</c:if>
										<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
											<li class="page-item">
											<a href="event?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
											</li>
										</c:forEach>
										<c:if test="${page.endPage < page.totalPage}">
											<li class="page-item">
											<a href="event?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
											</li>
										</c:if>
								</c:when>
							</c:choose>
						</c:when>
						<c:when test="${bigCode eq 3}">
								<c:if test="${page.startPage > page.pageBlock}">
									<li class="page-item">
									<a href="banner?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
									</li>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<li class="page-item">
									<a href="banner?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<li class="page-item">
									<a href="banner?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
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