<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>integratedBoard</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11.7.3/dist/sweetalert2.min.css">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script type="text/javascript">

	function checkUserIdAndNavigate() {
	    // userId 값 가져오기
	    var userId = ${userId};
	
	    // userId가 0인 경우 알림창 띄우기
	    if (userId == 0) {
	        swal({
	            title: "로그인 후 이용해주세요.",
	            text: "회원이 아니시면 가입 후 이용해주세요.",
	            icon: "warning",
	        }).then((confirmed) => {
	            // 'OK' 누르면 로그인 화면으로 이동
	            if (confirmed) {
	                location.href = '../login';
	            }
	        });
	    } else {
	        // userId가 0보다 큰 경우 페이지 이동
	        location.href = 'integratedBoardInsertForm?userId=${userId}&bigCode=${bigCode}&smallCode=${smallCode}';
	    }
	}
	
	// 서치이미지를 클릭할 때 폼을 제출하는 함수
	$(document).ready(function () {
    	$("#searchIcon").click(function () {
       		$("#freeBoardSearchList").submit();
    	});
	});
</script>

</head>

<body>

	<div id="content_title" class="container p-5 mb-4 text-center">
	</div>
	
	<!-- 글번호 Logic -->
	<c:set var="num" value="${page.total-page.start+1 }"/>
	
	<!-- 전체 content 영역  Start-->
	<div class="container p-0 general_board_custom">
	
		<!-- 상단 title 영역  -->
		<div class="container p-0 text-center header_title_custom">
			<div class="row align-items-start">
				<div class="col">
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
			</div>
		</div>
		
		<!-- 중간 네비게이션 영역 -->
		<div class="container p-3">
			<div class="row align-items-start md_nav_custom">
				<!-- 현재창 활성화 bar 표시(1 = 공지사항, 2 = 이달의 소식, 3 = 자유게시판 활성화) -->				
				<c:choose>
					<c:when test="${smallCode == 1 }">
						<div class="col md_nav_col_active">
							<span><a href="/noticBoardList">공지사항</a></span>
							<div class="md_nav_bar_active"></div>
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
						<div class="col">
							<span><a href="/eventBoardList">이벤트</a></span>
						</div>					
					</c:when>
					
					<c:when test="${smallCode == 2 }">
						<div class="col">
							<span><a href="/noticBoardList">공지사항</a></span>
						</div>
						<div class="col md_nav_col_active">
							<span><a href="/magazinBoardList">매거진</a></span>
							<div class="md_nav_bar_active"></div>					
						</div>
						<div class="col">
							<span><a href="/freeBoardList">자유게시판</a></span>
						</div>
						<div class="col">
							<span><a href="/photoBoardList">포토게시판</a></span>
						</div>
						<div class="col">
							<span><a href="/eventBoardList">이벤트</a></span>
						</div>					
					</c:when>
					
					<c:when test="${smallCode == 3 }">
						<div class="col">
							<span><a href="/noticBoardList">공지사항</a></span>
						</div>
						<div class="col">
							<span><a href="/magazinBoardList">매거진</a></span>
						</div>
						<div class="col md_nav_col_active">
							<span><a href="/freeBoardList">자유게시판</a></span>
							<div class="md_nav_bar_active"></div>						
						</div>
						<div class="col">
							<span><a href="/photoBoardList">포토게시판</a></span>
						</div>
						<div class="col">
							<span><a href="/eventBoardList">이벤트</a></span>
						</div>					
					</c:when>											
				</c:choose>
			</div>
		</div>
		
		<!-- 키워드, 검색창 영역 -->
		<div class="container p-3 keyword_custom">
			<div class="row align-items-start ">
				<!-- 자유게시판만 검색창 같이 출력 -->
				<c:choose>
					<c:when test="${smallCode == 3}">
						<div class="col keyword_div_custom">
							<form id="freeBoardList" action="freeBoardList" method="get">
								<input class="form-control keyword_custom" type="text" name="keyword" placeholder="&nbsp;키워드를 검색해보세요.">
								<img src="../image/icon_search1.png" alt="icon_search1.png" id="searchIcon" onclick="submitForm()"/>																						
							</form>
							<button class="btn btn_custom" onclick="checkUserIdAndNavigate()">글쓰기</button>		
						</div>
					</c:when>
				</c:choose>			
			</div>
		</div>
		
		<!-- 구분 메뉴 영역 -->
		<div class="container p-3">
			<div class="row row-cols-5 align-items-center division_custom">
				<div class="col-md-1">글번호</div>
				<div class="col-md-6">제&nbsp;목</div>
				<div class="col-md-2">작성자</div>
				<div class="col-md-2">작성일</div>
				<div class="col-md-1">조회수</div>			
			</div>		
		</div>
		
		<!-- 목록 출력 영역 -->
		<div class="container p-3 list_container_custom">
		<c:if test="${board.size() == 0}">해당하는 정보가 없습니다.</c:if>				
			<c:forEach var="boards" items="${board }">
				<div class="row row-cols-5 align-items-center list-board-custom">
					<!-- 글번호 Date -->		
					<div class="col-md-1">${num }</div>
					<c:set var="num" value="${num -1 }"/>	
									
					<!-- 게시판 제목 -->
					<div class="col-md-6">
						<c:if test="${boards.comment_indent > 0 }"></c:if>
						<c:choose>
							<c:when test="${boards.small_code eq 3 }">
 								<a href="boardDetail?id=${boards.id }&userId=${userId}">${boards.title }</a>						
							</c:when>
							<c:otherwise>
								<p class="d-inline-flex gap-1 coll-btn-custom m-0">
								  <button class="btn mx-auto" type="button" data-bs-toggle="collapse" data-bs-target="#contentCall${boards.id }"
								  		  aria-expanded="false" aria-controls="collapseExample">
								    ${boards.title }
								  </button>
								</p>							
							</c:otherwise>
						</c:choose>
					</div>
					
					<!-- 게시물 작성자 -->
					<div class="col-md-2">${boards.name }</div>
					
					<!-- 게시물 작성일(최초 생성일) -->
					<div class="col-md-2">		
						<fmt:formatDate value="${boards.created_at }" type="date"
										pattern="YYYY/MM/dd"/>
					</div>
					
					<!-- 게시물 조회수 -->
					<div class="col-md-1">${boards.read_count }</div>
				</div>
				
				<div class="collapse list-coll-custom" id="contentCall${boards.id }">
					<div class="card card-body list-content-custom border-0">
						<p>${boards.content }</p>
					</div>
				</div>
			</c:forEach>
		</div>		
		
		<!-- 페이징 처리 구간 -->
		<nav aria-label="Page navigation example">
			<ul class="pagination">
				<c:choose>
					<c:when test="${smallCode eq 1}">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item"><a
								href="noticBoardList?currentPage=${page.startPage-page.pageBlock}"
								class="pageblock page-link">[이전]</a></li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item"><a href="noticBoardList?currentPage=${i}"
								class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item"><a
								href="noticBoardList?currentPage=${page.startPage+page.pageBlock}"
								class="pageblock page-link">[다음]</a></li>
						</c:if>
					</c:when>

					<c:when test="${smallCode eq 2}">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item"><a
								href="magazinBoardList?currentPage=${page.startPage-page.pageBlock}"
								class="pageblock page-link">[이전]</a></li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item"><a href="magazinBoardList?currentPage=${i}"
								class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item"><a
								href="magazinBoardList?currentPage=${page.startPage+page.pageBlock}"
								class="pageblock page-link">[다음]</a></li>
						</c:if>
					</c:when>

					<c:when test="${smallCode eq 3}">
						<c:choose>
							<c:when test="${listSearch eq 1}">
								<c:if test="${page.startPage > page.pageBlock}">
									<li class="page-item"><a
										href="freeBoardSearchList?currentPage=${page.startPage-page.pageBlock}"
										class="pageblock page-link">[이전]</a></li>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<li class="page-item"><a href="freeBoardSearchList?currentPage=${i}"
										class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<li class="page-item"><a
										href="freeBoardSearchList?currentPage=${page.startPage+page.pageBlock}"
										class="pageblock page-link">[다음]</a></li>
								</c:if>		
							</c:when>
							<c:otherwise>
								<c:if test="${page.startPage > page.pageBlock}">
									<li class="page-item"><a
										href="freeBoardList?currentPage=${page.startPage-page.pageBlock}"
										class="pageblock page-link">[이전]</a></li>
								</c:if>
								<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
									<li class="page-item"><a href="freeBoardList?currentPage=${i}"
										class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
									</li>
								</c:forEach>
								<c:if test="${page.endPage < page.totalPage}">
									<li class="page-item"><a
										href="freeBoardList?currentPage=${page.startPage+page.pageBlock}"
										class="pageblock page-link">[다음]</a></li>
								</c:if>							
							</c:otherwise>
						</c:choose>	
					</c:when>
					
					<c:when test="${smallCode eq 6}">
						<c:if test="${page.startPage > page.pageBlock}">
							<li class="page-item"><a
								href="reviewBoardList?currentPage=${page.startPage-page.pageBlock}"
								class="pageblock page-link">[이전]</a></li>
						</c:if>
						<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
							<li class="page-item"><a href="reviewBoardList?currentPage=${i}"
								class="pageblock page-link ${page.currentPage == i ? 'active':'' }">${i}</a>
							</li>
						</c:forEach>
						<c:if test="${page.endPage < page.totalPage}">
							<li class="page-item"><a
								href="reviewBoardList?currentPage=${page.startPage+page.pageBlock}"
								class="pageblock page-link">[다음]</a></li>
						</c:if>
					</c:when>
				</c:choose>
			</ul>
		</nav>
	
	<!-- 전체 content 영역 END -->
	</div>

	<!-- Footer -->
	<%@ include file="/WEB-INF/components/Footer.jsp"%>
</body>
</html>