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
				<main class="col-10 overflow-auto p-0">
					<!-- Section1: Title -->
					<div class="admin-header-container">
						<div class="container m-4">
							<i class="title-bi bi bi-grid-fill "></i>
						<label  class="admin-header-title ">태그 관리</label>
						</div>
					</div>
					
					<!-- Section2: Insert Form -->		
					<div id="detail-body-container" class="container col-9 my-5">
						<div>
							<h1>태그수정</h1>
						</div>
						<div>
							<hr>
						</div>
						<c:if test="${msg != null}">${msg}</c:if>
						<form action="updateTagsResult" method="post">
							<input type="hidden" name="id" value="${tags.id}">
							번호 ${tags.id} <p>
							태그명 <input type="text" name="name" value="${tags.name}"><p>
							그룹명 <div class="col-8 mx-1">
									<input type="text" name="group_name" class="form-control" id="searchForm" 
									 placeholder="키워드를 입력해주세요." autocomplete="off" list="autoTags" value="${tags.group_name}">
									<datalist id="autoTags">
										<c:forEach var="tag" items="${listAllTags}">
											<option id="${tag.id}" value="${tag.name}">
										</c:forEach>
									</datalist>
								</div>
							<button type="submit" class="btn btn-primary">수정</button>
							<button type="button" class="btn btn-outline-secondary" onclick="deleteTag()">삭제</button>
						</form>
					</div>
				</main>
			</div>
		</div>
	</body>
</html>