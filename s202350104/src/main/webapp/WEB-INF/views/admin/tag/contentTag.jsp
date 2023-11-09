<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>컨텐츠 태그</title>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">컨텐츠 태그 관리</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3">
					<h1 class="border">검색폼</h1>
					<button type="button" class="btn btn-outline-secondary">검색</button>
					<button type="button" class="btn btn-outline-secondary">초기화</button>
				</div>		
				
				<!-- Section3: Table -->		
				<div class="border p-3 m-3">
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=11'">축제</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=12'">맛집</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=13'">숙박</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=14'">명소</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=15'">체험</button>
					<button type="button" class="btn btn-outline-secondary" onclick="location.href='contentTag?bigCodeStr=16'">코스</button>
					
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">분류</th>
								<th scope="col">컨텐츠 번호</th>
								<th scope="col">이름</th>
								<th scope="col">태그명</th>
								<th scope="col">수정</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="tag" items="${listTags}">
								<tr>
									<td>${num}</td>
									<td>${tag.cc_content}</td>
									<td>${tag.content_id}</td>
									<td>${tag.title}</td>
									<td>${tag.name}
									</td>
									<td><input type="button" value="수정"></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
					<p>총 건수 : ${totalTags}</p>
					
					<div align="center">
						<c:if test="${page.startPage > page.pageBlock}">
							<a href="contentTag?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<a href="contentTag?currentPage=${i}" class="pageblock">[${i}]</a>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<a href="contentTag?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
						</c:if>
					</div>
				</div>		
			</main>
		</div>
		</div>
		
	</body>
</html>