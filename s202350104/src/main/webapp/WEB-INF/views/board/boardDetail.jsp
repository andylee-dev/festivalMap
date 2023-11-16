<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardDetail</title>

<script>
	function closeAndRedirect(smallCode) {
	    $.ajax({
	        url: '/',
	        method: 'GET',
	        success: function () {
	            // 취소 버튼 실행 시 이전페이지 이동 + 새로고침
	           	if (smallCode === 1) {
	                // 공지사항 게시판으로 리디렉션
	                location.href = '/noticBoardList';
	            } else if(smallCode === 2) {
	            	// 이달의 소식 게시판으로 리디렉션
	                location.href = '/magazinBoardList';
	            } else if(smallCode === 3){
	            	// 자유게시판으로 리디렉션
	                location.href = '/freeBoardList';
	            } else if(smallCode === 4){
	            	// 자유게시판으로 리디렉션
	                location.href = '/photoBoardList';
	            } else if(smallCode === 5){
	            	// 자유게시판으로 리디렉션
	                location.href = '/eventBoardList';
	            } else{
	            	// 기본 & 오류 처리
	            	//location.href = '/';
	            	window.history.back();
	            }
	        }
	    });
	}
	<!-- 게시판 신고기능 -송환 -->
	function report(boardId) {
	    window.open("reportBoardFoam?boardId=" + boardId, "_blank", "width=600, height=400, top=100, left=100");
	}
</script>
</head>
<body>
	<div id="content_title" class="container p-5 mb-4 text-center">
	</div>

	<!-- 전체 content 영역  Start-->
	<div class="container p-0 general_board_custom" style="width: 100%;">
	
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
							<h1><strong>${board.title }</strong></h1>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>	
			
		<!-- 구분 출력 -->
		<div class="container p-3" > 
			<div class="row row-cols-5 align-items-center division_photo_custom">
				<div class="col-md-1">글번호</div>
				<div class="col-md-6">제&nbsp;목</div>
				<div class="col-md-2">작성자</div>
				<div class="col-md-2">작성일</div>
				<div class="col-md-1">조회수</div>			
			</div>		
		</div>
		
		<!-- 구분별 값 출력 -->
		<div class="container p-3"> 
			<div class="row row-cols-5 align-items-center list_photo_custom">
				<div class="col-md-1">${board.id }</div>
				<div class="col-md-6">${board.title }</div>
				<div class="col-md-2">${board.name }</div>
				<div class="col-md-2">
					<fmt:formatDate value="${board.created_at }" type="date"
									pattern="YYYY.MM.dd"/>				
				</div>
				<div class="col-md-1">${board.read_count }</div>			
			</div>		
		</div>

		<!-- 이미지 출력 -->
		<div class="container p-3">
			<div class="row row-cols-1">
				<div class="col img_detail_custom">
					<img alt="${board.file_name }" src="${board.file_path }${board.file_name}">
				</div>			
			</div>
		</div>
		
		<!-- 상세내용 출력 -->
		<div class="container p-3 detail_custom">
			<div class="row row-cols-1 align-items-start">
				<div class="col">
					<p>${board.content }</p>
				</div>			
			</div>
		</div>
		
		<!-- 해시태그 출력 -->
		<div class="container p-3 tags_detail_custom">
			<div class="row row-cols-1 align-items-start">
				<div class="col tags_row_custom">
					<c:forEach var="tags" items="${hashTag }">
						<span class="badge rounded-pill text-bg-light">#${tags.name }</span>
					</c:forEach>				
				</div>			
			</div>
		</div>
	
		<!-- 기능버튼 출력 -->		
		<div class="container p-3" >
			<div class="row row-cols-4">
				<div class="col-md-1 btn_border_custom">			
					<button class="btn btn_detail_custom" onclick="location.href='boardUpdateForm?id=${board.id}&userId=${userId }'">수&nbsp;정</button>				
				</div>
				<div class="col-md-1 btn_border_custom">			
					<button class="btn btn_detail_custom" onclick="location.href='boardDelete?id=${board.id}&userId=${userId }&smallCode=${board.small_code }'">삭&nbsp;제</button>				
				</div>
 				<div class="col-md-1 btn_border_custom">
					<button class="btn btn_detail_custom" onclick="closeAndRedirect(${board.small_code })">취소</button>			
				</div>
				<div class="col-md-1 btn_border_custom">
					<!-- 게시판 신고기능 -송환 -->
					<button class="btn btn_detail_custom" onclick="report(${board.id})">신&nbsp;고</button>								
				</div>
			</div>
		</div>		
			
		
	<!-- 전체 content 영역  END-->		
	</div>

</body>
</html>