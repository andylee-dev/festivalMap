<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>free Board</title>
</head>
<body>
	<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<c:choose>
						<c:when test="${smallCode == 2}">
							<h1>이달의 소식 관리</h1>
						</c:when>
						<c:when test="${smallCode == 3}">
							<h1>자유게시판 관리</h1>
						</c:when>
				    	<c:otherwise>
				        	<h1>리뷰 관리</h1>
				    	</c:otherwise>
					</c:choose>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<h1 class="border">검색폼</h1>
					<button type="button" class="btn btn-outline-secondary">검색</button>
					<button type="button" class="btn btn-outline-secondary">초기화</button>
				</div>
				
				<!-- Section3: Table -->		
				<c:set var="num" value="${page.total-page.start+1 }"/>
				
				<div class="border p-3 m-3">
					<button onclick="location.href='../../reviewBoardInsertForm?userId=1&bigCode=${bigCode }&smallCode=${smallCode }'" type="button" class="btn btn-outline-secondary">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">제목</th>
								<th scope="col">작성자</th>
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
									<td><fmt:formatDate value="${boards.updated_at }" type="date" pattern="YY/MM/dd"/></td>
									<td><input onclick="location.href='../../boardUpdateForm?id=${boards.id}'" type="button" value="수정 "></td>
									<td><input onclick="location.href='../../boardDelete?id=${boards.id}&userId=${userId }&smallCode=${boards.small_code }'" type="button" value="삭제"></td>
								</tr>
								<c:set var="num" value="${num - 1 }"/>
							</c:forEach>
						</tbody>
					</table>
					<c:choose>
						<c:when test="${smallCode eq 2}">
							<div align="center">
								<c:if test="${page.startPage > page.pageBlock}">
									<a href="magazin?currentPage=${page.startPage-page.pageBlock}"
									   class="pageblock">[이전]</a>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<a href="magazin?currentPage=${i}" class="pageblock">[${i}]</a>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<a href="magazin?currentPage=${page.startPage+page.pageBlock}"
									   class="pageblock">[다음]</a>
								</c:if>
							</div>
						</c:when>
						<c:when test="${smallCode eq 3}">
							<div align="center">
								<c:if test="${page.startPage > page.pageBlock}">
									<a href="board?currentPage=${page.startPage-page.pageBlock}"
									   class="pageblock">[이전]</a>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<a href="board?currentPage=${i}" class="pageblock">[${i}]</a>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<a href="board?currentPage=${page.startPage+page.pageBlock}"
									   class="pageblock">[다음]</a>
								</c:if>
							</div>
						</c:when>
						<c:when test="${smallCode eq 6}">
							<div align="center">
								<c:if test="${page.startPage > page.pageBlock}">
									<a href="review?currentPage=${page.startPage-page.pageBlock}"
									   class="pageblock">[이전]</a>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<a href="review?currentPage=${i}" class="pageblock">[${i}]</a>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<a href="review?currentPage=${page.startPage+page.pageBlock}"
									   class="pageblock">[다음]</a>
								</c:if>
							</div>
						</c:when>
					</c:choose>
				</div>
			</main>
		</div>
	</div>
</body>
</html>