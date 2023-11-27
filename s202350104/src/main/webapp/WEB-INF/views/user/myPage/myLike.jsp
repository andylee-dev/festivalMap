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
					location.href="myLikeDelete?content_id="+id;
				}
			}
		</script>
		<style type="text/css">
			h1 {
				color: black;
				font-size: 32px;
				font-family: Noto Sans;
				font-weight: 600;
				word-wrap: break-word
			}
			
			h2 {
				color: #FF4379;
				font-family: Noto Sans;
				font-size: 24px;
				font-style: normal;
				font-weight: 600;
				line-height: normal;
				padding-bottom: 10px;
			}
			
			button {
				white-space: nowrap;
			}
		</style>
	</head>
	
	<body>
		<!-- Top bar -->
		<%@ include file="/WEB-INF/components/TobBar.jsp"%>
		<div class="d-flex">
			<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			<div class="container border p-5">
			
			
			!-- Section1: Title -->				
				<div class="container my-5">
					<h1>내 찜 관리</h1>
					<p>내 찜 목록을 관리할 수 있습니다.</p>
					<hr class="hr" />
					
					
					<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container table-container p-4">
						<div class="table-responsive">	
						<table id="userTable" class="table table-md text-center p-3">
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
								<c:set var="num" value="${page.start}"/>
								<c:set var="num" value="${page.start}" />
									<c:forEach var="myLikeList" items="${myLikeList}">
										<tr>
											<td>${num}</td>
											<td>${myLikeList.content_id}</td>
											<td>${myLikeList.title}</td>
											<td><fmt:formatDate value="${myLikeList.create_at}" type="date" pattern="YY/MM/dd" /></td>
											<td><button type="button" class="btn btn-primary" onclick="deleteConfirm(${myLikeList.content_id})">취소</button></td>
										</tr>
									<c:set var="num" value="${num + 1 }"/>	
									</c:forEach>
							</tbody>
						</table>
						</div>
					</div>
				</div>
					
	
							<ul class="pagination justify-content-center">
								<c:if test="${page.startPage > page.pageBlock}">
									<li class="page-item"><a class="page-link"
										href="myLike?currentPage=${page.startPage-page.pageBlock}"
										class="pageblock">[이전]</a></li>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}"
									end="${page.endPage}">
									<li class="page-item"><a class="page-link"
										href="myLike?&currentPage=${i}"
										class="pageblock">${i}</a></li>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<li class="page-item"><a class="page-link"
										href="myLike?&currentPage=${page.startPage+page.pageBlock}"
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