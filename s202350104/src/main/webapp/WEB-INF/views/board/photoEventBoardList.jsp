<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
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

<link href="/css/board.css" rel="stylesheet" type="text/css">

<script type="text/javascript">
	function showPopUp(id, userId) {
		
		//창 크기 지정
		var width = 800;
		var height = 700;
		
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

	<div id="content_title" class="container p-5 mb-4 text-center">
	</div>

	<c:set var="num" value="${page.total - page.start + 1}" />

	<!-- 전체 content 영역  Start-->
	<div class="container p-0 general_board_custom">

		<!-- 상단 title 영역  -->
		<div class="container p-0 text-center header_title_custom">
			<div class="row align-items-start">
				<div class="col">
					<c:choose>
						<c:when test="${smallCode == 4}">
							<h1>
								<strong>포토게시판</strong>
							</h1>
						</c:when>
						<c:when test="${smallCode == 5}">
							<h1>
								<strong>이벤트</strong>
							</h1>
						</c:when>
					</c:choose>
				</div>
			</div>
		</div>

		<!-- 중간 네비게이션 영역 -->
		<div class="container p-3">
			<div class="row align-items-start md_nav_custom">
				<!-- 현재창 활성화 bar 표시(4 = 포토게시판, 5 = 이벤트) -->
				<c:choose>
					<c:when test="${smallCode == 4 }">
						<div class="col">
							<span><a href="/noticBoardList">공지사항</a></span>
						</div>
						<div class="col">
							<span><a href="/magazinBoardList">매거진</a></span>
						</div>
						<div class="col">
							<span><a href="/freeBoardList">자유게시판</a></span>
						</div>
						<div class="col md_nav_col_active">
							<span><a href="/photoBoardList">포토게시판</a></span>
							<div class="md_nav_bar_active"></div>
						</div>
						<div class="col">
							<span><a href="/eventBoardList">이벤트</a></span>
						</div>
					</c:when>

					<c:when test="${smallCode == 5 }">
						<div class="col">
							<span><a href="/noticBoardList">공지사항</a></span>
						</div>
						<div class="col">
							<span><a href="/magazinBoardList">매거진</a></span>
						</div>
						<div class="col">
							<span><a href="/freeBoardList">자유게시판</a></span>
						</div>
						<div class="col">
							<span><a href="/photoBoardList">포토게시판</a></span>
						</div>
						<div class="col md_nav_col_active">
							<span><a href="/eventBoardList">이벤트</a></span>
							<div class="md_nav_bar_active"></div>
						</div>
					</c:when>
				</c:choose>
			</div>
		</div>


		<!-- 키워드, 검색창 영역 -->
		<div class="container p-3 keyword_custom">
			<div class="row align-items-start ">
				<!-- 포토게시판만 검색창 같이 출력 -->
				<c:choose>
					<c:when test="${smallCode == 4}">
						<div class="col keyword_div_custom">
							<input class="form-control keyword_custom" type="text" placeholder="&nbsp;키워드를 검색해보세요."> 
								<img src="../image/icon_search1.png" alt="test" />
							<button class="btn btn_custom" onclick="location.href='integratedBoardInsertForm?userId=${userId }&bigCode=${bigCode }&smallCode=${smallCode }'">글쓰기</button>
						</div>
					</c:when>
				</c:choose>
			</div>
		</div>

		<!-- 목록 출력 영역 -->
		<div class="container p-3 cardList_custom">
			<div class="row align-items-center">
				<c:forEach var="boards" items="${board}">
					<div class="col-6 col-md-4">
						<!-- content-->
						<div class="card card_custom">
							<a href="javascript:showPopUp(${boards.id},${userId })"> 
								<img src="${boards.file_path }${boards.file_name }" class="card-img-top img_custom" alt="${boards.file_name }">
							</a>
							<!-- title, 작성자, 작성일 영역 -->
							<div class="card-body card_body_custom">
								<div class="row row-cols-1">
									<div class="row row-cols-3">
										<div class="col-md-10" style="margin-top: 30px;">
											<p>${boards.title }</p>
										</div>
										<div class="col-md-1" style="margin-left: -60px; ">
											<img alt="동그라미1.jpg" src="../image/boardStatus1.png">
										</div>
										<div class="col-md-1" style="margin-left: 15px;">
											<img alt="동그라미2.jpg" src="../image/boardStatus2.png">										
										</div>
									</div>
									<div class="col">
										<p class="card_p_custom">작성자&nbsp;&nbsp;&nbsp;&nbsp;
										<span>${boards.name }</span></p>								
									</div>
									<div class="col">
										<p class="card_p_custom">작성시간&nbsp;
										<span>
											<fmt:formatDate value="${boards.created_at }" type="date"
															pattern="YYYY.MM.dd hh:mm:ss"/>
										</span></p>		 							
									</div>
								</div>
							</div>
						</div>
					</div>
				</c:forEach>
			</div>
		</div>

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
	
	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>
