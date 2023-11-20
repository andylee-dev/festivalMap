<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>태그 등록</title>
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 overflow-auto">
			
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-grid-fill "></i>
					<label  class="admin-header-title ">새 태그 등록 </label>
					</div>
				</div>
				
				<!-- Section2: Insert Form -->		
				<div class="border p-3 m-3">
					<c:if test="${msg != null}">${msg}</c:if>
					<form action="insertTagsResult" method="post">
						태그명 <input type="text" name="name">
						<input type="submit" value="등록">
					</form>
				</div>
			</main>
		</div>
		</div>
	</body>
</html>