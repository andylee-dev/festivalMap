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
	function getQnaDelete(){
		alert("실행")
		var seluser_id = $('#user_id').val();
		var selid	   = $('#id').val();
		alert(seluser_id);
		alert(selid);
		$.ajax(
				{
					url:"<%=request.getContextPath()%>/admin/cs/qnaDelete",
					data:{	user_id : seluser_id
						,	id		: selid
						 },
					dataType:'text',
					success:function(data){
						alert(".ajax getdeletQna data->"+data);
						if(data == '1'){
							
							alert("성공적으로 삭제 되었습니다.")
							location.href='qna'
						}else{
							alert("삭제되지않았습니다.다시 시도하세요")
						}
					}
				}		
		);
	}	
</script>
		<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
	</head>
	<body>
		<div class="container-fluid">
		<div class="row">
			<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
			<main class="col-10 overflow-auto p-0">
			
				<!-- Section1: Title -->
				<div class="admin-header-container">
					<div class="container m-4">
						<i class="title-bi bi bi-chat-dots-fill"></i>
						<label  class="admin-header-title ">1:1 문의 상세내역 </label>
					</div>
			</div>
			<div class="container my-5">
				<h1>1:1 문의</h1>
				<hr class="hr" />
				<h3 style="color: #FF4379" class="container col-9 justify-content-center align-items-center">문의</h3>
				<c:if test="${msg != null}">${msg}</c:if>
				<form action="qnaUpdateResult" method="post">
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container table-container p-4">
							<input type="hidden" name="user_id" id="user_id" value="${qna.user_id}">
							<input type="hidden" name="id" id="id" value="${qna.id}">	
							<div class="mb-3 ">
						  		<label for="content_id" class="form-label">제목:</label>
						  		<input type="text" class="form-control" name="question_title" value="${qna.question_title} " readonly>
							</div>
							<div class="mb-3 ">
						  		<label for="content_id" class="form-label">내용:</label>
						  		<textarea class="form-control" name="question_content" rows="5" readonly>${qna.question_content}</textarea>
							</div>
						</div>
					</div>
				<h3 style="color: #FF4379" class="container col-9 justify-content-center align-items-center">답변</h3>
				<c:if test="${msg != null}">${msg}</c:if>
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container table-container p-4">
							<div class="mb-3 ">
						  		<label for="content_id" class="form-label">제목:</label>
						  		<input type="text" class="form-control" name="answer_title" value="${qna.answer_title} ">
							</div>
							<div class="mb-3 ">
						  		<label for="content_id" class="form-label">내용:</label>
						  		<textarea class="form-control" name="answer_content" rows="5">${qna.answer_content}</textarea>
							</div>
						</div>
					</div>
				<div class="text-center">
					<input class="btn btn-primary" type="button" value="목록" onclick="location.href='qna'">
					<input class="btn btn-primary" type="submit" value="수정">
					<input class="btn btn-outline-secondary" type="button" onclick="getQnaDelete(${status.index})" value="삭제">
				</div>
				</form>	
			</div>	
			</main>
		</div>
		</div>
	</body>
</html>