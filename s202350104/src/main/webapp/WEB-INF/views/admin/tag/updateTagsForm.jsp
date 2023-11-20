<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>태그 수정</title>
		<script src="http://code.jquery.com/jquery-latest.min.js"></script>
		<script type="text/javascript">
			function deleteTag() {
				if(confirm("정말 삭제하시겠습니까?")) {
					location.href="deleteTags?tagId=${tags.id}";
				}
			}
		</script>
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
					<label  class="admin-header-title ">태그 수정</label>
					</div>
				</div>
				
				<!-- Section2: Insert Form -->		
				<div class="border p-3 m-3">
					<c:if test="${msg != null}">${msg}</c:if>
					<form action="updateTagsResult" method="post">
						<input type="hidden" name="id" value="${tags.id}">
						번호 ${tags.id} <p>
						태그명 <input type="text" name="name" value="${tags.name}"><p>
						<button type="submit" class="btn btn-primary">수정</button>
						<button type="button" class="btn btn-outline-secondary" onclick="deleteTag()">삭제</button>
					</form>
				</div>
			</main>
		</div>
		</div>
	</body>
</html>