<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>	
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">
function closeWindow() {
    window.close();
}

</script>
</head>
<body>
	<h1 align="center">신고하기</h1>	
		<c:if test="${userId == 0}">
		    <div class="container border p-5">
		        <div class="row">
		            <div class="col text-center">
		                <p>로그인 후 신고 가능합니다</p>
		            </div>
		        </div>
		        <div class="row">
		            <div class="col text-center">
		                <button class="btn btn-secondary" onclick="closeWindow()">취소</button>
		            </div>
		        </div>
		    </div>
		</c:if>
		<c:if test="${userId != 0 }">
		<form action="boardReportUpdate">
			
			<div class="container border p-5">
			<table class="table table-bordered">
			<tr class="table-primary">
				<th scope="col" style="text-align: center;">제목</th>
				<td style="background-color: white;">
				<input type="hidden" name="board_id" value="${board.id }">${board.title }</td>
				
				<th scope="col" style="text-align: center;">작성자</th>
				<td style="background-color: white;">
				<input type="hidden" name="user_id" value="${board.user_id }">${board.name }</td>
			</tr>
			
			<tr class="table-primary">
				<th scope="col" style="text-align: center;">신고인</th>
				<td colspan="3" style="background-color: white;">
				<input type="hidden" name="id" value="${userId }">${userId }</td>
			</tr>
			
			<tr class="table-primary">
				<th scope="col" style="text-align: center;">내용</th>
				<td colspan="3" style="background-color: white;">${board.content }</td>
			</tr>
			
			<tr class="table-primary">
				<th scope="col" style="text-align: center;">신고내용</th>
				<td colspan="7"  style="background-color: white;">	
				<input type="text" name="content" class="form-control" placeholder="신고내용을 입력하세요">	
				</td>
			</tr>
			</table>
			<button type="submit" class="btn btn-danger" >신고</button>
			<button class="btn btn-secondary" onclick="closeWindow()">취소</button>
		</div>
		</form>
		</c:if>
</body>
</html>