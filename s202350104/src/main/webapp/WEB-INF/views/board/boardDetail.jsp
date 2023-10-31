<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardDetail</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
	crossorigin="anonymous" />
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
	crossorigin="anonymous">
	
</script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>

	<div id="content_title" class="container border p-5 mb-4">
		<h1>게시판 상세정보</h1>
	</div>
	<div class="container border p-5">
		<table class="table">
			<tr class="table-primary">
				<th scope="col">제목</th>
				<td>${board.title }</td>
				<th scope="col">작성자</th>
				<td>${board.name }</td>
				<th scope="col">작성일</th>
				<td><fmt:formatDate value="${board.created_at }" type="date"
									pattern="YYYY/MM/dd"/>
				</td>
				<c:if test="${board.updated_at != null}">
        			<th scope="col">수정일</th>
       		   		<td><fmt:formatDate value="${board.updated_at}" type="date" 
       		   							pattern="YYYY/MM/dd" />
       		   		</td>
    			</c:if>
			</tr>
			<tr class="table-primary">
				<th scope="col">내용</th>
				<td>${board.content }</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="button" value="수정" onclick="location.href='boardUpdateForm?id=${board.id}'">
					<input type="button" value="삭제" onclick="location.href='boardDelete?id=${board.id}'">
				</td>
			</tr>
		</table>
	</div>
</body>
</html>