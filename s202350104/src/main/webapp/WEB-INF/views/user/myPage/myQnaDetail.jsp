<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myQnaDetail</title>
<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<main>
		<div class="d-flex">
			<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			<div class="container border p-5">
				<div class="container my-5">

					<!-- Section1: Title -->
					<h1>1:1 문의</h1>
					<hr class="hr" />
					<h3 style="color: #FF4379" class="container col-9 justify-content-center align-items-center">문의</h3>
					<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
						<div class="mb-3 ">
							<label for="content_id" class="form-label">제목:</label> 
							<input type="text" class="form-control" name="question_title"
								   value="${qna.question_title} " readonly>
						</div>
						<div class="mb-3 ">
							<label for="content_id" class="form-label">내용:</label>
							<textarea class="form-control" name="question_title" rows="5"
									  readonly>${qna.question_content}</textarea>
						</div>
					</div>
					<h3 style="color: #FF4379" class="container col-9 justify-content-center align-items-center">답변</h3>
					<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
						<div class="mb-3 ">
							<label for="content_id" class="form-label">제목:</label> 
							<input type="text" class="form-control" name="answer_title"
								   value="${qna.answer_title}" readonly>
						</div>
						<div class="mb-3 ">
							<label for="content_id" class="form-label">내용:</label>
							<textarea class="form-control" name="answer_content" rows="5"
								readonly>${qna.answer_content}</textarea>
						</div>
					</div>
					<div class="text-center">
						<input class="btn btn-primary" type="button" value="목록"
							   onclick="location.href='qnaList'">
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>