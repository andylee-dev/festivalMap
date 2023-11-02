<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>태그 수정</title>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			
				<!-- Section1: Title -->
				<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
					<h1 class="border">태그 수정</h1>
				</div>
				
				<!-- Section2: Insert Form -->		
				<div class="border p-3 m-3">
					<c:if test="${msg != null}">${msg}</c:if>
					<form action="updateTagsResult" method="post">
						<input type="hidden" name="id" value="${tags.id}">
						태그번호 ${tags.id} <p>
						태그명 <input type="text" name="name" value="${tags.name}"><p>
						<input type="submit" value="수정">
					</form>
				</div>
			</main>
		</div>
		</div>
	</body>
</html>