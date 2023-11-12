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

		</script>
	</head>
		<body>
		<div id="allTags" data-tags="${listAllTags}"></div>
		
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">게시글 태그 관리</h1>
				</div>
		
				<!-- Section2: Search Form -->		
				<div class="border p-3 m-3" data-bs-spy="scroll" data-bs-target="#list-example" data-bs-smooth-scroll="true" class="scrollspy-example" tabindex="0">
					<table class="table table-striped table-sm">
						<tr>
							<th>게시글 번호</th>
							<td>${board.id}</td>
						</tr>
						<tr>
							<th>분류</th>
							<td>${board.big_code}</td>
						</tr>
						<tr>
							<th>제목</th>
							<td>${board.title}</td>
						</tr>
						<tr>
							<th>작성자</th>
							<td>${board.name}</td>
						</tr>
						<tr>
							<th>작성일</th>
							<td><fmt:formatDate value="${board.created_at}" type="date" pattern="YY/MM/dd"/></td>
						</tr>
						<tr>
							<th>내용</th>
							<td>${board.content}</td>
						</tr>
					</table>
					
					<!-- tag 선택 -->

					
					<!-- 수정/목록 버튼 -->
					
				</div>
			</main>
		</div>
		</div>
		
	</body>
</html>