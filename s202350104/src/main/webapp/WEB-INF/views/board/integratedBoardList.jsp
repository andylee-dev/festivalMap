<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>integratedBoard</title>
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
<style>
	a {
		text-decoration: none;
		color: black;
	}
	
	.table-custom th {
        background-color: #FF4379; /* 원하는 배경색으로 대체하세요 */
        color: white; /* 선택사항: 텍스트 색상을 지정하여 가독성을 높일 수 있습니다 */
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

</script>

</head>

<body>
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	<div id="content_title" class="container p-5 mb-4 text-center">
	</div>

	<c:set var="num" value="${page.total-page.start+1 }"/>
	
	<div class="container">
		<div class="text-center" style="margin-bottom: 80px;">
			<c:choose>
				<c:when test="${smallCode == 2}">
					<h1><strong>이달의 소식</strong></h1>
				</c:when>
				<c:when test="${smallCode == 3}">
					<h1><strong>자유게시판</strong></h1>
				</c:when>
				<c:otherwise>
					<h1><strong>공지사항</strong></h1>
				</c:otherwise>
			</c:choose>
		</div>
		
		<div style="margin-bottom: 10px;">
			<table class="table" style="border-top:2px black solid;">
				<thead>
					<tr class="table text-center">
						<c:choose>
							<c:when test="${smallCode == 1}">
								<th scope="col" style="font-size: 24px; text-align: center; position: relative;">
									<a href="/noticBoardList">공지사항</a>
									<div style="width: 100px; height: 11px; left: 419px; top: 318px;  background: #FF4379; border-radius: 20px;
												position: absolute; top: -5px; left: 50%; transform: translateX(-50%);"></div>
		
								</th>
								<th scope="col" style="font-size: 24px;">
									<a href="/magazinBoardList">매거진</a>
								</th>
								<th scope="col" style="font-size: 24px;">
									<a href="/freeBoardList">자유게시판</a>
								</th>							
							</c:when>
							<c:when test="${smallCode == 2}">
								<th scope="col" style="font-size: 24px;">
									<a href="/noticBoardList">공지사항</a>
								</th>
								<th scope="col" style="font-size: 24px; text-align: center; position: relative;">
									<a href="/magazinBoardList">매거진</a>
									<div style="width: 100px; height: 11px; left: 419px; top: 318px;  background: #FF4379; border-radius: 20px;
												position: absolute; top: -5px; left: 50%; transform: translateX(-50%);"></div>								
								</th>
								<th scope="col" style="font-size: 24px;">
									<a href="/freeBoardList">자유게시판</a>
								</th>							
							</c:when>
							<c:when test="${smallCode == 3}">
								<th scope="col" style="font-size: 24px;">
									<a href="/noticBoardList">공지사항</a>
								</th>
								<th scope="col" style="font-size: 24px;">
									<a href="/magazinBoardList">매거진</a>
								</th>
								<th scope="col" style="font-size: 24px; text-align: center; position: relative;">
									<a href="/freeBoardList">자유게시판</a>
									<div style="width: 100px; height: 11px; left: 419px; top: 318px;  background: #FF4379; border-radius: 20px;
												position: absolute; top: -5px; left: 50%; transform: translateX(-50%);"></div>								
								</th>							
							</c:when>													
						</c:choose>
							<th scope="col" style="font-size: 24px;">
								<a href="/photoBoardList">포토게시판</a>
							</th>
							<th scope="col" style="font-size: 24px;">
								<a href="/eventBoardList">이벤트</a>
							</th>
					</tr>	
				</thead>
			</table>
			<div class="d-flex justify-content-end">
				<div style="width: 300px; height: 40px; background: #F7FBF4; border-radius: 23.50px; border: 2px black solid; margin-right: 10px;
							display: flex; align-items: center; justify-content: flex-end; position: relative;">
					<img style="width: 20px; height: 19px; position: absolute; right: 5px; top: 50%; transform: translateY(-50%);" src="../image/icon_search1.png" alt="test"/>
				</div>
				<c:choose>
					<c:when test="${smallCode == 3}">
						<button class="btn btn-custom" onclick="location.href='integratedBoardInsertForm?userId=${userId }&bigCode=${bigCode }&smallCode=${smallCode }'">글쓰기</button>
					</c:when>
				</c:choose>
			</div>
		</div>

		<table class="table">
			<thead>
				<tr class="table table-custom text-center">
					<th scope="col" style="font-size: 18px;">글번호</th>
					<th scope="col" style="font-size: 18px;">제목</th>
					<th scope="col" style="font-size: 18px;">작성자</th>
					<th scope="col" style="font-size: 18px;">작성일</th> 
					<th scope="col" style="font-size: 18px;">조회수</th>
				</tr>
			</thead>
			<tbody>
			<c:forEach var="boards" items="${board }">
				<tr>
					<td class="text-center" style="font-size: 18px; font-weight: bold;">${num }</td>
					<c:choose>
						<c:when test="${smallCode eq 6}">
							<td class="text-center" style="font-size: 18px; font-weight: bold;">
								<a href="boardDetail?id=${boards.id }&userId=${userId}">${boards.content }</a>
							</td>
						</c:when>
						<c:otherwise>
							<td class="text-center" style="font-size: 18px; font-weight: bold;">
								<a href="boardDetail?id=${boards.id }&userId=${userId}">${boards.title }</a>
							</td>
						</c:otherwise>
					</c:choose>
					<td class="text-center" style="font-size: 18px; font-weight: bold;">${boards.name }</td>
					<td class="text-center" style="font-size: 18px; font-weight: bold;">
						<fmt:formatDate value="${boards.created_at }" type="date"
										pattern="YYYY/MM/dd"/></td>
					<td class="text-center" style="font-size: 18px; font-weight: bold;">${boards.read_count }</td>
				</tr>
				<c:set var="num" value="${num - 1 }"/>
			</c:forEach>
			</tbody>
		</table>
		<!-- 페이징 처리 구간 -->
		<nav aria-label="Page navigation example">
			<ul class="pagination justify-content-center" style="display: flex; list-style: none; padding: 0;">
				<c:choose>
					<c:when test="${smallCode eq 1}">
						<li class="page-item">
							<c:if test="${page.startPage > page.pageBlock }">
								<a class="page-link" href="noticBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
							</c:if>
						</li>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a class="page-link" href="noticBoardList?currentPage=${i}">${i}</a>
							</li>						
						</c:forEach>
						<li class="page-item">
							<c:if test="${page.endPage < page.totalPage }">
								<a class="page-link" href="noticBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
							</c:if>
						</li>
					</c:when>
					<c:when test="${smallCode eq 2}">
				   		 <li class="page-item">
				        	<c:if test="${page.startPage > page.pageBlock }">
				            	<a class="page-link" href="magazinBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
				       		</c:if>
				       	</li>
					    <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					        <li class="page-item">
					        	<a class="page-link" href="magazinBoardList?currentPage=${i}">${i}</a>
					        </li>
					    </c:forEach>
					    <li class="page-item">
				        	<c:if test="${page.endPage < page.totalPage }">
				       			<a class="page-link" href="magazinBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
				       	 	</c:if>
				   		</li>
				    </c:when>
				    <c:when test="${smallCode eq 3}">
						<li class="page-item">
							<c:if test="${page.startPage > page.pageBlock }">
								<a class="page-link" href="freeBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
							</c:if>
						</li>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a class="page-link" href="freeBoardList?currentPage=${i}">${i}</a>
							</li>						
						</c:forEach>
						<li class="page-item">
							<c:if test="${page.endPage < page.totalPage }">
								<a class="page-link" href="freeBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
							</c:if>
						</li>
				    </c:when>
				    <c:when test="${smallCode eq 6}">
						<li class="page-item">
							<c:if test="${page.startPage > page.pageBlock }">
								<a class="page-link" href="reviewBoardList?currentPage=${page.startPage - page.pageBlock }">이전</a>
							</c:if>
						</li>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item">
								<a class="page-link" href="reviewBoardList?currentPage=${i}">${i}</a>
							</li>						
						</c:forEach>
						<li class="page-item">
							<c:if test="${page.endPage < page.totalPage }">
								<a class="page-link" href="reviewBoardList?currentPage=${page.startPage + page.pageBlock }">다음</a>
							</c:if>
						</li>
				    </c:when>
				</c:choose>
			</ul>
		</nav>
	</div>

		<!--     <div style="width: 146px; left: 1476px; top: 41px; position: absolute; text-align: center; color: black; font-size: 20px; font-family: Coda Caption; font-weight: 800; word-wrap: break-word">마이페이지</div>
    <div style="width: 101px; height: 31px; left: 1596px; top: 42px; position: absolute; text-align: center; color: black; font-size: 20px; font-family: Coda Caption; font-weight: 800; word-wrap: break-word">비즈니스</div> -->
<!-- 		<img style="width: 20px; height: 19px; left: 1457px; top: 418px; position: absolute"
			 src="https://via.placeholder.com/20x19" /> -->
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>