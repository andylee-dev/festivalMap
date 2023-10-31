<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>PhotoBoard</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet"
      integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9"
      crossorigin="anonymous"/>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm"
        crossorigin="anonymous">
</script>
<style>
	.font-size-large {
		font-size: 6px; /* 원하는 크기로 조정하세요. */
	}
</style>
<script type="text/javascript">
	function showPopUp(id) {
		
		//창 크기 지정
		var width = 650;
		var height = 550;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
	    //윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
	    //연결하고싶은url
	    const url = "photoBoardDetail?id=" + id;
	
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "hello popup", windowStatus);
	}
</script>
</head>
<body>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>

<div id="content_title" class="container border p-5 mb-4">
    <h1>포토게시판</h1>
</div>

<c:set var="num" value="${page.total - page.start + 1}"/>

<div class="container">
    <div class="row">
        <c:forEach var="boards" items="${board}">
            <div class="col-md-4 mb-4">
                <div class="card">
	                   	<a href="javascript:showPopUp(${boards.id})">
	                    	<img src="../image/sea.jpg" class="card-img-top" alt="...">
	                    </a>  
                    <div class="card-body">
						<table>
							<tr>
								<th class="card-text">${boards.title}</th>
							</tr>
							<tr>
								<th>작성자</th>
								<td class="font-size-small">${boards.name }</td>
							</tr>
							<tr>
								<th>작성일</th>
								<td><fmt:formatDate value="${boards.created_at }" 
											 	    type="date" pattern="YYYY/MM/dd"/></td>
							</tr>
						</table>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
</body>
</html>
