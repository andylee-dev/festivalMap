<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Festival</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteConfirm(id){
				console.log(id);
				if(confirm("정말 삭제하시겠습니까?")){
					var id = Number(id);
					location.href="myLikeDelete?id="+id;
				}
			}
		</script>
	</head>
	
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp"%>
		<div class="d-flex">
			<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			<div class="container border p-5">
				<div class="container my-5">
					<h1>내 찜 목록 관리</h1>
					<p>내 찜 목록을 관리할 수 있습니다.</p>
					<div class="container p-2 my-5">
						<h2>내 찜 목록</h2>
						<hr class="hr" />
						<div class="container w-50 my-5" align="center">
							<table class="table table-striped table-sm">
								<thead>
									<tr>
										<th scope="col">No.</th>
										<th scope="col">컨텐츠ID</th>
										<th scope="col">컨텐츠명</th>
										<th scope="col">찜한 날짜</th>
										<th scope="col">취소</th>
									</tr>
								</thead>
								<tbody>
									<c:set var="num" value="${page.start}" />
									<c:forEach var="myLikeList" items="${myLikeList}">
										<tr>
											<td>${num}</td>
											<td>${myLikeList.id}</td>
											<td>${myLikeList.title}</td>
											<td><fmt:formatDate value="${myLikeList.create_at}" type="date" pattern="YY/MM/dd" /></td>
											<td><button type="button" onclick="deleteConfirm(${myLikeList.id})">취소</button></td>
										</tr>
									<c:set var="num" value="${num + 1 }"/>	
									</c:forEach>
								</tbody>
							</table>
							<ul class="pagination justify-content-center">
								<c:if test="${page.startPage > page.pageBlock}">
									<li class="page-item"><a class="page-link"
										href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${page.startPage-page.pageBlock}"
										class="pageblock">[이전]</a></li>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}"
									end="${page.endPage}">
									<li class="page-item"><a class="page-link"
										href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${i}"
										class="pageblock">${i}</a></li>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<li class="page-item"><a class="page-link"
										href="userList?small_code=2&keyword=${searchOption.keyword}&is_deleted=${searchOption.is_deleted}&startDate=${searchOption.startDate}&endDate=${searchOption.endDate}&currentPage=${page.startPage+page.pageBlock}"
										class="pageblock">[다음]</a></li>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>