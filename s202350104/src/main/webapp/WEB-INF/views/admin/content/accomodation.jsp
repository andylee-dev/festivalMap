<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지역정보 숙박</title>
</head>
<body>
	<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<!-- Section1: Title -->
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="border">숙박 리스트</h1>
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
							<th scope="col">지역</th>
							<th scope="col">숙박업장이름</th>
							<th scope="col">주소</th>
							<th scope="col">신청일</th>
							<th scope="col">승인여부</th>
							<th scope="col">수정</th>
							<th scope="col">삭제</th>
						</tr>
					</thead>
					<tbody>
						<c:set var="num" value="${page.start}"/>
						<c:forEach var="accomodations" items="${listAccomodation}">
							<tr>
								<td>${num}</td>
								<td>${accomodations.area} ${accomodations.sigungu}</td>
								<td>${accomodations.title}</td>
								<td>${accomodations.address}</td>
								<td><fmt:formatDate value="${accomodations.created_at}" type="date" pattern="YY/MM/dd"/></td>
								<td>
						 				<c:if test="${accomodations.status == 0 }">승인대기</c:if>
										<c:if test="${accomodations.status == 1 }">승인완료</c:if>
									</td>
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
			<a href="accomodations?currentPage=${page.startPage-page.pageBlock}" class="pageblock">[이전]</a>
		</c:if>
		<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
			<a href="accomodations?currentPage=${i}" class="pageblock">[${i}]</a>
		</c:forEach>
		<c:if test="${page.endPage < page.totalPage}">
			<a href="accomodations?currentPage=${page.startPage+page.pageBlock}" class="pageblock">[다음]</a>
		</c:if>
	</div>
</body>
</html>