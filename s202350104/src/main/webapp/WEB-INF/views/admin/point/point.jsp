<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>포인트관리</title>
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
						<i class="title-bi bi bi-handbag-fill"></i>
					<label  class="admin-header-title ">포인트관리</label>
					</div>
				</div>	
				
				<!-- Section2: Search Form -->
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm m-2" onclick="location.href='writeFormPoint'">등록</button>
					</div>
				
					<div class="container table-container p-4">
					<div class="table-responsive">
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
								<tr>
									<th scope="col">포인트번호</th>
									<th scope="col">포인트이름</th>
									<th scope="col">내용</th>
									<th scope="col">포인트점수</th>
									<th scope="col">생성날짜</th>
									<th scope="col">수정</th>
								</tr>
							</thead>
								<c:forEach var="point" items="${listPoint}">
								<tr>
									<td>${point.id }</td>
									<td>${point.title }</td>
									<td>${point.content }</td>
									<td>${point.point }</td>
									<td><fmt:formatDate value="${point.create_at}" pattern="yyyy/MM/dd" /></td>
									<td><input class="btn btn-primary" type="button" onclick="location.href='updateFormPoint'" value="수정"></td>
								</tr>
								</c:forEach>
						</table>
					</div>
					</div>
				</div>
<nav aria-label="Page navigation example ">
						<ul class="pagination">
							<c:if test="${page.startPage > page.pageBlock}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="pointhistory?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
										</li>
									</c:when>
									<c:when test="${path ==1}">
										<li class="page-item">
											<a href="pointhistorySearch?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
										</li>
									</c:when>
								</c:choose>
									
							</c:if>
							<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="point?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
										</li>
									</c:when>
									<c:when test="${path == 1}">
										<li class="page-item">
											<a href="pointSearch?currentPage=${i}&keyword=${keyword}&big_code=${big_code}&small_code=${small_code}&is_deleted=${is_deleted}&status=${status}&area=${area}&sigungu=${sigungu}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
										</li>
									</c:when>
								</c:choose>
							</c:forEach>
											
							<c:if test="${page.endPage < page.totalPage}">
								<c:choose>
									<c:when test="${path ==0}">
										<li class="page-item">
											<a href="point?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
										</li>
									</c:when>
									<c:when test="${path ==1}">
										<li class="page-item">
											<a href="pointSearch?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
										</li>
									</c:when>
								</c:choose>
							</c:if>
					</ul>
				</nav>		
			</main>
		</div>
	</div>
</body>
</html>