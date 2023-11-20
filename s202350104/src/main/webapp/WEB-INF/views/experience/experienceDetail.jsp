<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>체험정보 상세</title>

<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function showPopUp(userId, bigCode, smallCode, currentPage, contentId, commonCode) {
		
		//창 크기 지정
		var width = 550;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
	    //윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
	    //연결하고싶은url
	    const url = "../reviewBoardInsertForm?userId="+ userId + "&commonCode=" + commonCode + "&bigCode=" + bigCode + "&smallCode=" + smallCode + "&currentPage=" + currentPage + "&contentId=" + contentId;
	
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "hello popup", windowStatus);
	}
	function report(boardId) {
	    window.open("../reportBoardFoam?boardId=" + boardId, "_blank", "width=600, height=400, top=100, left=100");
	}
</script>

</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>

	<h1>체험정보 상세</h1>
		<div class="container border p-5">
		<table>
			<tr>
				<th>체험이름</th>
				<td>${experience.title}</td>
			</tr>
			<tr>
				<th>개요</th>
				<td>${experience.content}</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>${experience.address}</td>
			</tr>
			<tr>
				<th>email</th>
				<td>${experience.email}</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>${experience.phone}</td>
			</tr>
			<tr>
				<th>홈페이지</th>
				<td>${experience.homepage}</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>${experience.created_at}</td>
			</tr>
			<tr>
				<th>수용인원</th>
				<td>${experience.capacity}</td>
			</tr>
			<tr>
				<th>체험연령</th>
				<td>${experience.age}</td>
			</tr>
			<tr>
				<th>체험안내</th>
				<td>${experience.inform}</td>
			</tr>
			<tr>
				<th>개장시간</th>
				<td>${experience.open_time}</td>
			</tr>
			<tr>
				<th>휴무일</th>
				<td>${experience.rest_time}</td>
			</tr>
			<tr>
				<th>비용안내</th>
				<td>${experience.cost}</td>
			</tr>
		</table>
	</div>

	<!-- review test -->
	<c:set var="num" value="${page.total-page.start+1 }" />
	<div class="container border p-5">
		<div class="d-flex justify-content-end">
			<button class="btn btn-primary"
				onclick="javascript:showPopUp(${userId},${bigCode},${smallCode},${currentPage},${experience.content_id},${experience.big_code})">리뷰쓰기</button>
		</div><br>
		<table class="table">
			<tr class="table-primary text-center">
				<th scope="col">구분</th>
				<th scope="col">한줄평</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">평점</th>
				<th scope="col">신고</th>
			</tr>
			<c:forEach var="review" items="${reviewBoard }">
				<tr>
					<td class="text-center">${num }</td>
					<td class="text-center">
						<a href="../boardDetail?id=${review.id }">${review.content }</a></td>
					<td class="text-center">${review.name }</td>
					<td class="text-center">
						<fmt:formatDate value="${review.created_at }" type="date"
						 				pattern="YYYY/MM/dd" /></td>
					<td class="text-center">
						<c:forEach begin="1" end="${review.score }">★</c:forEach>
					</td>
					<td class="text-center">
						<button class="btn btn-danger" onclick="report(${review.id})">신고</button>
					</td>
				</tr>
				<c:set var="num" value="${num - 1 }" />
			</c:forEach>
		</table>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center"
				style="display: flex; list-style: none; padding: 0;">
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
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>