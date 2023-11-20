<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp"%>
<%@ taglib prefix="f" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<%@ include file="/WEB-INF/components/AdminUpdateAreas.jsp"%>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp"%>
			<main class="col-10 overflow-auto p-0">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-people-fill "></i>
					<label  class="admin-header-title ">찜 목록 리스트</label>
					</div>
				</div>
				
				<!-- Section2: Search Form -->
				<div class="container col-9 justify-content-center my-5">
					<form action="favoriteSearch" method="POST" container justify-content-center">	
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">검색어</label>
							<div class="col-4">
								<select name="search" class="form-select">
									<option value="s_id">ID조회</option>
									<option value="s_name">이름조회</option>
								</select> 
							</div>	
							<div class="col-5 mx-2 d-flex justify-content-center">	
								<input type="text" name="keyword" class="form-control" placeholder="keyword를 입력하세요">
								<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
							</div>
						</div>	
					</form>
				</div>
				<div class="container col-9 justify-content-center my-2">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='favoriteInsertForm'">등록</button>
				</div>
					
				<!-- Section3: Table -->
				<div class="container col-9 justify-content-center my-2 border p-2">
					<table class="table table-striped table-sm text-center mb-2">
						<thead>
							<tr>
								<th scope="col">회원ID</th>
								<th scope="col">이름</th>
								<th scope="col">컨텐츠ID</th>
								<th scope="col">찜한 날짜</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="favorite" items="${listFavorite}">
								<tr>
									<td>${favorite.user_id}</td>
									<td>${favorite.name}</td>
									<td>${favorite.id}</td>
									<td><fmt:formatDate value="${favorite.create_at}" type="date" pattern="YY/MM/dd"/></td>
									<td><input class="btn btn-primary" type="button" value="수정"></td>
									<td><input class="btn btn-outline-secondary" type="button" value="삭제"></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				
				<nav aria-label="Page navigation example ">
				<ul class="pagination">
					<c:if test="${page.startPage > page.pageBlock}">
    					<li class="page-item">
        					<a href="favoriteList?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
    					</li>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
    					<li class="page-item">
        					<a href="favoriteList?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
    					</li>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage}">
    					<li class="page-item">
        					<a href="favoriteList?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
    					</li>
					</c:if>
				</ul>
			</nav>
			</main>
		</div>
	</div>
</body>
</html>