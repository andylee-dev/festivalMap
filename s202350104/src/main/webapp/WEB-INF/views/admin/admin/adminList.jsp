<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>AdminList content</title>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
				
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">관리자설정 - 관리자리스트</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<h1 class="border">검색폼</h1>
					<button type="button" class="btn btn-outline-secondary">검색</button>
					<button type="button" class="btn btn-outline-secondary">초기화</button>
				</div>		
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary ">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">대분류</th>
								<th scope="col">소분류</th>
								<th scope="col">이름</th>
								<th scope="col">비밀번호</th>
								<th scope="col">별명</th>
								<th scope="col">생년월일</th>
								<th scope="col">전화번호</th>
								<th scope="col">이메일</th>
								<th scope="col">주소</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="adminList" items="${listUser}">
								<tr>
									<td>${num}</td>
									<td>${adminList.big_code}</td>
									<td>${adminList.small_code}</td>
									<td>${adminList.name}</td>
									<td>${adminList.password}</td>
									<td>${adminList.nickname}</td>
									<td>${adminList.birthday}</td>
									<td>${adminList.phone_num}</td>
									<td>${adminList.email}</td>
									<td>${adminList.address}</td>
						 			<td><input type="button" value="수정"></td>
									<td><input type="button" value="삭제"></td>					
								 </tr>
								 <c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
				</div>		
			</main>
		</div>
		</div>
		
		<div align="center">
		<c:if test="${page.startPage > page.pageBlock}">
			<a href="adminList?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<a href="adminList?currentPage=${i}" class="pageblock">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<a href="adminList?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
		</c:if>
		</div>
		
	</body>
</html>