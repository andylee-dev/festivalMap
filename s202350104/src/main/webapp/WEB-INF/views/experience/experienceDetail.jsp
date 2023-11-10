<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험정보 상세</title>
    
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	
	<h1>체험정보 상세</h1>
	<a href="writeForm">writerFromEmp 입력(작업중ㅇㅇㅇ)</a><p>
	<div class="container border p-5">
	<table>
		<tr><th>체험이름</th><td>${experience.title}</td></tr>
		<tr><th>개요</th><td>${experience.content}</td></tr>
		<tr><th>주소</th><td>${experience.address}</td></tr>
		<tr><th>email</th><td>${experience.email}</td></tr>
		<tr><th>전화번호</th><td>${experience.phone}</td></tr>
		<tr><th>홈페이지</th><td>${experience.homepage}</td></tr>
		<tr><th>작성일</th><td>${experience.created_at}</td></tr>
		<tr><th>수용인원</th><td>${experience.capacity}</td></tr>
		<tr><th>체험연령</th><td>${experience.age}</td></tr>
		<tr><th>체험안내</th><td>${experience.inform}</td></tr>
		<tr><th>개장시간</th><td>${experience.open_time}</td></tr>
		<tr><th>휴무일</th><td>${experience.rest_time}</td></tr>
		<tr><th>비용안내</th><td>${experience.cost}</td></tr>
	</table>	
	</div>
	
	<!-- review test -->
		<c:set var="num" value="${page.total-page.start+1 }"/>
		<div class="container border p-5">
		    <div class="text-right"> <!-- 버튼을 오른쪽 정렬하는 부분 -->
		        <button class="btn btn-primary" onclick="location.href='../boardInsertForm?userId=1&bigCode=${bigCode}&smallCode=${smallCode}&contentId=${experience.content_id}'">글쓰기</button>
		    </div>
			<table class="table">
				<tr class="table-primary text-center">
					<th scope="col">구분</th>
					<th scope="col">한줄평</th>
					<th scope="col">작성자</th>
					<th scope="col">작성일</th>
					<th scope="col">평점</th>
					<th scope="col">삭제</th>
				</tr>
				<c:forEach var="review" items="${reviewBoard }">
					<tr>
						<td class="text-center">${num }</td>
							<td class="text-center">
								<a href="../boardDetail?id=${review.id }">${review.content }</a>
							</td>
						<td class="text-center">${review.name }</td>
						<td class="text-center">
							<fmt:formatDate value="${review.created_at }" type="date"
											pattern="YYYY/MM/dd"/></td>
						<td class="text-center">${review.score }</td>
						<td class="text-center">
							<button class="btn btn-danger" onclick="">삭제</button>
						</td>
					</tr>
					<c:set var="num" value="${num - 1 }"/>
			</c:forEach>
			</table>
			<nav aria-label="Page navigation example">
				<ul class="pagination justify-content-center" style="display: flex; list-style: none; padding: 0;">
					<c:choose>
					    <c:when test="${smallCode eq 6}">
							<li class="page-item">
								<c:if test="${page.startPage > page.pageBlock }">
									<a class="page-link" href="reviewBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
								</c:if>
							</li>
							<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
								<li class="page-item">
									<a class="page-link" href="reviewBoardList?currentPage=${i}">${i}</a>
								</li>						
							</c:forEach>
							<li class="page-item">
								<c:if test="${page.endPage < page.totalPage }">
									<a class="page-link" href="reviewBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
								</c:if>
							</li>
					    </c:when>
					</c:choose>
				</ul>
			</nav>	
		</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp" %>
	
	 
</body>
</html>