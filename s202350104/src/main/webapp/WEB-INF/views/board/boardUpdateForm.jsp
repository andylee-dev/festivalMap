<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardUpdateForm</title>
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

<!-- jQuery 라이브러리 불러오기 -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
</script>

</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	
    <div class="container mt-5">
        <div class="card">
            <div class="card-header">
                <h2 class="text-center">게시판 수정</h2>
            </div>
            <div class="card-body">
                <form action="boardUpdate" method="post">
                    <input type="hidden" name="id" value="${board.id }">
                    <input type="hidden" name="name" value="${board.name }">
                    <div class="mb-3">
                        <label for="title" class="form-label">제목</label>
                        <input type="text" id="title" name="title" class="form-control" required="required" value="${board.title }">
                    </div>
                    <div class="mb-3">
                        <label for="content" class="form-label">내용</label>
                         <textarea id="content" name="content" class="form-control" required="required" rows="5">${board.content }</textarea>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn btn-primary">확인</button>
                        <a href="#" class="btn btn-secondary" onclick="closeAndRedirect()">취소</a>
                    </div>
                </form>
            </div>
        </div>
    </div>
</body>
</html>