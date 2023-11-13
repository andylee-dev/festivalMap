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
	
	a {
		text-decoration: none;
		color: black;
	}
	
	.table-custom th {
        background-color: #EEFFC2; /* 원하는 배경색으로 대체하세요 */
        color: black; /* 선택사항: 텍스트 색상을 지정하여 가독성을 높일 수 있습니다 */
    }
    
    .border-top {
		 border-color: black;
    }
    
    .btn-custom {
    	background-color: #FF4379;
    	color: white;
    }
    
</style>
<script type="text/javascript">
	function showPopUp(id, userId) {
		
		//창 크기 지정
		var width = 550;
		var height = 600;
		
		//pc화면기준 가운데 정렬
		var left = (window.screen.width / 2) - (width/2);
		var top = (window.screen.height / 4);
		
	    //윈도우 속성 지정
		var windowStatus = 'width='+width+', height='+height+', left='+left+', top='+top+', scrollbars=yes, status=yes, resizable=yes, titlebar=yes';
		
	    //연결하고싶은url
	    const url = "photoEventBoardDetail?id=" + id + "&userId=" + userId;
	
		//등록된 url 및 window 속성 기준으로 팝업창을 연다.
		window.open(url, "hello popup", windowStatus);
	}
</script>
</head>
<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>

	<div id="content_title"	class="container p-5 mb-4 d-flex justify-content-between align-items-center">
	</div>

	<c:set var="num" value="${page.total - page.start + 1}" />

	<div class="container">
		<div class="text-center" style="margin-bottom: 80px;">
			<c:choose>
				<c:when test="${smallCode == 5}">
					<h1><strong>이벤트 게시판</strong></h1>
				</c:when>
				<c:otherwise>
					<h1><strong>포토 게시판</strong></h1>				
				</c:otherwise>
			</c:choose>
		</div>

		<div style="margin-bottom: 10px;">
			<table class="table" style="border-top: 2px black solid;">
				<thead>
					<tr class="table text-center">

						<th scope="col" style="font-size: 24px;">
							<a href="/noticBoardList">공지사항</a>
						</th>
						<th scope="col" style="font-size: 24px;">
							<a href="/magazinBoardList">매거진</a>
						</th>
						<th scope="col" style="font-size: 24px;">
							<a href="/freeBoardList">자유게시판</a>
						</th>
						<c:choose>
							<c:when test="${smallCode == 4}">
								<th scope="col" style="font-size: 24px; position: relative;">
									<a href="/photoBoardList">포토게시판</a>
									<div style="width: 100px; height: 11px; left: 419px; top: 318px; background: #FF4379; border-radius: 20px; position: absolute; top: 0; left: 50%; transform: translateX(-50%);"></div>
								</th>
								<th scope="col" style="font-size: 24px;">
									<a href="/eventBoardList">이벤트</a></th>
							</c:when>
							<c:when test="${smallCode == 5}">
								<th scope="col" style="font-size: 24px;">
									<a href="/photoBoardList">포토게시판</a></th>
								<th scope="col" style="font-size: 24px; position: relative;">
									<a href="/eventBoardList">이벤트</a>
									<div style="width: 100px; height: 11px; left: 419px; top: 318px; background: #FF4379; border-radius: 20px; position: absolute; top: 0; left: 50%; transform: translateX(-50%);"></div>
								</th>
							</c:when>
						</c:choose>
					</tr>
				</thead>
			</table>
			<div class="d-flex justify-content-end">
				<div
					style="width: 300px; height: 40px; background: #F7FBF4; border-radius: 23.50px; border: 2px black solid; margin-right: 10px; display: flex; align-items: center; justify-content: flex-end; position: relative;">
					<img
						style="width: 20px; height: 19px; position: absolute; right: 5px; top: 50%; transform: translateY(-50%);"
						src="../image/icon_search1.png" alt="test" />
				</div>
				<c:choose>
					<c:when test="${smallCode == 4}">
						<button class="btn btn-custom"
							onclick="location.href='integratedBoardInsertForm?userId=${userId }&bigCode=${bigCode }&smallCode=${smallCode }'">글쓰기</button>
					</c:when>
				</c:choose>
			</div>
		</div>

		<div class="row">
			<c:forEach var="boards" items="${board}">
				<div class="col-md-4 mb-4">
					<div class="card">
						<a href="javascript:showPopUp(${boards.id},${userId })"> 
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
														type="date" pattern="YYYY/MM/dd" /></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</c:forEach>
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center" style="display: flex; list-style: none; padding: 0;">
				<c:choose>
					<c:when test="${smallCode eq 4}">
						<li class="page-item">
							<c:if test="${page.startPage > page.pageBlock }">
								<a class="page-link" href="photoBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
							</c:if>
						</li>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a class="page-link" href="photoBoardList?currentPage=${i}">${i}</a>
							</li>						
						</c:forEach>
						<li class="page-item">
							<c:if test="${page.endPage < page.totalPage }">
								<a class="page-link" href="photoBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
							</c:if>
						</li>
					</c:when>
					<c:when test="${smallCode eq 5}">
				   		 <li class="page-item">
				        	<c:if test="${page.startPage > page.pageBlock }">
				            	<a class="page-link" href="eventBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
				       		</c:if>
				       	</li>
					    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					        <li class="page-item">
					        	<a class="page-link" href="eventBoardList?currentPage=${i}">${i}</a>
					        </li>
					    </c:forEach>
					    <li class="page-item">
				        	<c:if test="${page.endPage < page.totalPage }">
				       			<a class="page-link" href="eventBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
				       	 	</c:if>
				   		</li>
				    </c:when>
				</c:choose>
			</ul>
		</nav>	
		</div>
	</div>
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
