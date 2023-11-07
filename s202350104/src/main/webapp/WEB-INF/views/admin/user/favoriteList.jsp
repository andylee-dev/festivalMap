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
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				<!-- Section1: Title -->
				<div
					class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">찜 목록 리스트</h1>
				</div>

				<!-- Section2: Search Form -->
				<div class="border p-3 m-3">
					<h1 class="border">검색폼</h1>
					<form action="favoriteSearch">
						<select name="search">
							<option value="s_id">ID조회</option>
							<option value="s_name">이름조회</option>
						</select> 
						<input type="text" name="keyword" placeholder="keyword를 입력하세요">
						<button type="submit">keyword검색</button>
					</form>
				</div>

				<!-- Section3: Table -->
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary ">등록</button>
					<table class="table table-striped table-sm">
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
									<td><input type="button" value="수정"></td>
									<td><input type="button" value="삭제"></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</main>
		</div>
	</div>
</body>
</html>