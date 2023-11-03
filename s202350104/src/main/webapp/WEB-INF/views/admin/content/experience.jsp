<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>experience content</title>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">지역정보 - 체험</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
						<form action="listSearch" method="get">
							<input type="text" name="keyword" placeholder="keyword를 입력하세요">
							<button type="submit">keyword검색</button>
							<input type="hidden" name="big_code" value="15">
							<button type="button" class="btn btn-outline-secondary">초기화</button><p>
								<select name="is_deleted">
									<option value="2">전체</option>
									<option value="0">활성화</option>
									<option value="1">비활성화</option>
								</select>
								<select name="small_code">
									<option value="999">전체</option>
									<c:forEach var="small" items="${listSmallCode}">
									<option value="${small.small_code}">${small.content}</option>
									</c:forEach>
								</select>
							</form>
									
									
				</div>		
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">테마</th>
								<th scope="col">체험명</th>
								<th scope="col">주소</th>
								<th scope="col">작성자</th>
								<th scope="col">신청일</th>
								<th scope="col">승인여부</th>
								<th scope="col">수정</th>
								<th scope="col">삭제/복원</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="experience" items="${listExperience}">
								<tr>
									<td>${num}</td>
									<td>
										<c:if test="${experience.small_code == 1}">자연</c:if>
										<c:if test="${experience.small_code == 2}">전통</c:if>
										<c:if test="${experience.small_code == 3}">산사</c:if>
										<c:if test="${experience.small_code == 4}">이색</c:if>
										<c:if test="${experience.small_code == 5}">레포츠</c:if>										
									</td>
									<td>${experience.title}</td>
									<td>${experience.address}</td>
									<td>${experience.user_id}</td>
									<td><fmt:formatDate value="${experience.created_at}" type="date" pattern="YY/MM/dd"/></td> <!-- 신청일 컬럼?? -->
									<td>
										<c:if test="${experience.status == 0}">승인대기</c:if>
										<c:if test="${experience.status == 1}">승인완료</c:if>
										<!-- 승인반려됐을 경우 status -->
									</td>
									<td>
									<c:if test="${experience.is_deleted == 1}">
									</c:if>
									<c:if test="${experience.is_deleted == 0}">
									<button onclick="location.href=''">수정</button>
									</c:if>
									</td>
									<td>
									<c:if test="${experience.is_deleted == 1}">
									<button onclick="location.href='experienceDelete?contentId=${experience.content_id}'">복원</button>
									</c:if>
									<c:if test="${experience.is_deleted == 0}">
									<button onclick="location.href='experienceDelete?contentId=${experience.content_id}'">삭제</button>
									</c:if>
									</td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>					
					
					<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="experience?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="experience?currentPage=${i}" class="pageblock">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="experience?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
						</c:if>
					</div>
				</div>		
			</main>
		</div>
		</div>
	</body>
</html>