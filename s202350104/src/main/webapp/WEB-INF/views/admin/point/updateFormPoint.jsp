<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>포인트 수정</title>
</head>
<body>
    <!-- Top bar -->
    <%@ include file="/WEB-INF/components/TobBar.jsp" %>
    <h1>포인트 수정</h1>
    <div class="border p-3 m-3">
        <form action="updatePoint" method="post">
            <input type="hidden" name="id" value="${point.id}" />
            <label for="title">포인트 제목:</label><br>
            <input type="text" id="title" name="title" value="${point.title}"><br>
            <label for="content">포인트 내용:</label><br>
            <textarea id="content" name="content">${point.content}</textarea><br>
            <label for="point">포인트 점수:</label><br>
            <input type="text" id="point" name="point" value="${point.point}"><br><br>
            <input type="submit" value="수정">
        </form>
    </div>
</body>
</html>
