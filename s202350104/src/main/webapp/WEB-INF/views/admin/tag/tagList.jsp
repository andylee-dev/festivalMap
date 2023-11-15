<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function tagDelete(pIndex) {
				var deleteId = $('#id'+pIndex).val();
				if(confirm("정말 삭제하시겠습니까?")) {
					$.ajax(
							{
								method:"POST",
								url:"<%=request.getContextPath()%>/admin/tag/deleteTags",
								data:{id : deleteId},
								dataType:'text',
								success:
									function(result) {
											if(result == '1') {
												$('#tag'+pIndex).remove();
												alert("성공적으로 삭제되었습니다.");
												location.reload();
											} else {
												alert("삭제에 실패하였습니다.");
											}		
									}
							}		
					)
				}
			}
		</script>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-10 overflow-auto p-0">
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-grid-fill "></i>
					<label  class="admin-header-title ">태그관리</label>
					</div>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="container col-9 justify-content-center my-5">
					<form action="list" method="POST" class="container justify-content-center">
						<!-- 검색어 -->
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="form-label col-2  mx-2">검색어</label>
								<input  class="col-3  mx-2" type="text" name="keyword" placeholder="검색어를 입력해주세요.">
								<button type="submit" class="btn btn-primary col-1 mx-1">검색</button>
								<button type="reset" class="btn btn-outline-secondary col-1 mx-1">초기화</button>
							</div>
					</form>	
				</div>		
				<div class="container col-9 justify-content-center my-2">
					<button type="button" class="btn btn-outline-secondary mt-4" onclick="location.href='insertTagsForm'">등록</button>
				
				</div>
				<!-- Section3: Table -->		
				<div class="container col-9 justify-content-center my-2 border p-2">
					<table class="table table-striped table-sm text-center mb-2">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">태그명</th>
								<th scope="col">수정</th>
								<th scope="col">삭제</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="tag" items="${listTags}" varStatus="st">
								<tr id="tag${st.index}">
									<td><input type="hidden" value="${tag.id}" id="id${st.index}">${num}</td>
									<td>${tag.name}</td>
									<td><input class="btn btn-primary" type="button" value="수정" onclick="location.href='updateTagsForm?id=${tag.id}'"></td>
									<td><input class="btn btn-outline-secondary" type="button" value="삭제" onclick="tagDelete(${st.index})"></td>
								</tr>
								<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
					<p>총 건수 : ${totalTags}</p>
				</div>		
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item">
								<a href="list?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="list?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="list?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
							</li>
						</c:if>
					</ul>
				</nav>
			</main>
		</div>
		</div>
	</body>
</html>