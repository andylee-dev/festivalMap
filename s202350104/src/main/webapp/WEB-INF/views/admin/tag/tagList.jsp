<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
		</script>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-10 overflow-auto p-0">
			
				<!-- Section1: 타이틀 -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-grid-fill "></i>
					<label  class="admin-header-title ">태그리스트</label>
					</div>
				</div>
		
				<!-- Section2: 검색폼 -->		
				<div class="container col-9 justify-content-center mt-5">
					<form action="list" method="GET" class="container justify-content-center">
						
						<!-- 검색어 -->
						<div class="col-12 my-4 d-flex align-items-center">
							<label for="searchType" class="col-form-label col-1  mx-2">검색어</label>
							<div class="col-2">
								<select name="searchType" class="form-select">
									<option value="s_tagname">태그명</option>
									<option value="s_groupname">그룹명</option>
								</select>
							</div>
							<div class="col-6 mx-1">
								<input type="text" name="keyword" class="form-control" placeholder="검색어를 입력해주세요.">
							</div>
							<!-- 버튼 -->
							<div class="col-5 mx-1 d-flex justify-content-start">
								<button type="submit" class="btn btn-primary col-2 mx-1">검색</button>
								<button type="reset" class="btn btn-outline-secondary col-2 mx-1">초기화</button>
							</div>
						</div>
					</form>	
				</div>
					
				<!-- Section3: 테이블 -->	
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container d-flex justify-content-end p-0">
						<button id="regist-btn" type="button" class="btn btn-primary btn-sm mb-4" 
						 onclick="location.href='insertTagsForm'">등록</button>
					</div>	
					<div class="container table-container p-4">
					<div class="table-responsive">
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">그룹명</th>
									<th scope="col">태그명</th>
									<th scope="col">회원태그</th>
									<th scope="col">게시판태그</th>
									<th scope="col">컨텐츠태그</th>
									<th scope="col">코스태그</th>
									<th scope="col">총합</th>
									<th scope="col"></th>
								</tr>
							</thead>
							<tbody>
								<c:set var="num" value="${page.start}"/>
								<c:forEach var="tag" items="${listTags}">
									<tr>
										<td>${num}</td>
										<td>
											<c:if test="${tag.group_name == null || tag.group_name == ''}">-</c:if>
											<c:if test="${tag.group_name != null && tag.group_name != ''}">${tag.group_name}</c:if>
										</td>
										<td style="font-weight: bold; color: #FF4379;">${tag.name}</td>
										<td>${tag.userCnt}</td>
										<td>${tag.boardCnt}</td>
										<td>${tag.contentCnt}</td>
										<td>${tag.courseCnt}</td>
										<td>${tag.userCnt + tag.boardCnt + tag.contentCnt + tag.courseCnt}</td>
										<td><a href="updateTagsForm?id=${tag.id}" class="detail-link">관리</a></td>
									</tr>
									<c:set var="num" value="${num + 1}"/>
								</c:forEach>
							</tbody>
						</table>
						<p>총 건수 : ${totalTags}</p>
					</div>	
					</div>
				</div>	
				
				<!-- 페이지 번호 -->
				<nav aria-label="Page navigation example ">
					<ul class="pagination">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item">
								<a href="list?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">Prev</a>
							</li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a href="list?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item">
								<a href="list?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">Next</a>
							</li>
						</c:if>
					</ul>
				</nav>
				
			</main>
		</div>
		</div>
	</body>
</html>