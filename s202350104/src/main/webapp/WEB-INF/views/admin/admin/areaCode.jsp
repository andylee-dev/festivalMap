<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>AreaCode content</title>
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
						<i class="title-bi bi bi-gear-fill"></i>
					<label  class="admin-header-title ">관리자설정 - 지역코드관리</label>
					</div>
				</div>
				
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
					<form action="areaCodeSearch" method="POST">
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">지역코드검색</label>
							<div class="col-4 mx-2">
							<select name="area"  class="form-select">
								<option value="">전체</option>
									<c:forEach var="areas" items="${listAreas}">
									<c:if test="${areas.sigungu == 999}">
								<option value="${areas.area}">${areas.content}</option>
									</c:if>
									</c:forEach>
							</select>
						</div>
							<button type="submit" class="btn btn-primary  col-1 mx-1">검색</button>
							<button type="reset" class="btn btn-outline-secondary col-1 mx-1">초기화</button>
						</div>
					</form>
				</div>
				
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" onclick="location.href='areaCodeInsertForm'">등록</button>
					</div>
				<div class="container table-container p-4">
				<div class="table-responsive">	
					<table id="userTable" class="table table-md text-center p-3">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">대분류</th>
								<th scope="col">소분류</th>
								<th scope="col">내용</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="areaCode" items="${listAreaCode}">
								<tr>
									<td>${num}</td>
									<td>${areaCode.area}</td>
									<td>${areaCode.sigungu}</td>
						 			<td>${areaCode.content}</td>
						 			<td><input class="btn btn-primary" type="button" value="수정"
						 				onclick="location.href='areaCodeUpdateForm?area=${areaCode.area}&sigungu=${areaCode.sigungu}&currentPage=${page.currentPage}'"></td>
									<td><input class="btn btn-outline-secondary" type="button" value="삭제"
										onclick="location.href='areaCodeDelete?area=${areaCode.area}&sigungu=${areaCode.sigungu}'"></td>					
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
								<c:choose>
									<c:when test="${path==0}">
										<a href="areaCode?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
									</c:when>
									<c:when test="${path==1}">					
										<a href="areaCodeSearch?area=${area}&currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>							
									</c:when>
								</c:choose>								
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<c:choose>
									<c:when test="${path==0}">
										<a href="areaCode?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</c:when>
									<c:when test="${path==1}">
										<a href="areaCodeSearch?area=${area}&currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</c:when>
								</c:choose>	
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<c:choose>
									<c:when test="${path==0}">
										<a href="areaCode?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
									</c:when>
									<c:when test="${path==1}">
										<a href="areaCodeSearch?area=${area}&currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
									</c:when>
								</c:choose>	
							</li>
						</c:if>
					</ul>
				</nav>
		</main>
		</div>
		</div>
	</body>
</html>