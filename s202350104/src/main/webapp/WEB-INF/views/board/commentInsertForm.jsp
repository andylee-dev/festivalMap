<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>    
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardUpdateForm</title>


<script>
	function closeAndRedirect() {
    	// 기본 제출 동작 막기
        event.preventDefault();
    	
		// 취소 시 이전페이지 이동
		window.history.back();
	}
</script>

</head>
<body>

	<div id="content_title" class="container p-5 mb-4 text-center"></div>

	<!-- 전체 content 영역  Start-->
	<div class="container p-0 general_board_custom">
	
		<!-- 상단 title 영역  -->
		<div class="container p-0 text-center">
			<div class="row align-items-start insert_title_custom">
				<div class="col">
					<c:choose>
						<c:when test="${smallCode == 1}">
							<h1><strong>공지사항, 수정</strong></h1>
						</c:when>
						<c:when test="${smallCode == 2}">
							<h1><strong>이달의소식, 수정</strong></h1>
						</c:when>
						<c:when test="${smallCode == 3}">
							<h1><strong>자유게시판, 수정</strong></h1>
							<c:if test="${msg!=null }">${msg }</c:if>
						</c:when>
						<c:when test="${smallCode == 4}">
							<h1><strong>포토게시판, 수정</strong></h1>
						</c:when>
						<c:when test="${smallCode == 5}">
							<h1><strong>이벤트, 수정</strong></h1>
						</c:when>
						<c:otherwise>
							<h1><strong>일반 게시물 수정</strong></h1>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>	
		
		<!-- input 영역 -->
		<div class="container p-0 text-left">
			<form action="commentInsert" method="post" enctype="multipart/form-data">
				<input type="hidden" name="id" value="${board.id }"> 
				<input type="hidden" name="name" value="${board.name }"> 
				<input type="hidden" name="user_id" value="${userId }">
				<input type="hidden" name="big_code" value="${board.big_code }">
				<input type="hidden" name="small_code" value="${board.small_code }">
				<input type="hidden" name="comment_group_id" value="${board.comment_group_id }">
				<input type="hidden" name="comment_step" value="${board.comment_step }">
				<input type="hidden" name="comment_indent" value="${board.comment_indent }">
				
				<div class="row row-cols-1 p-0 insert_row_custom">

					<div class="row row-cols-2 p-0 insert_row2_custom">
						<div class="form-group col title_row">
							<label for="title">제&nbsp;목</label>
						</div>
						<div class="form-group col">
							<input type="text" class="form-control title_input" id="title"
								   name="title" required="required" value="답변 : ${board.title }">
						</div>
					</div>
					
					<div class="row row-cols-2 p-0 insert_row2_custom">
						<div class="form-group col text_row">
							<label for="content">내&nbsp;용</label>
						</div>
						<div class="form-group col">
							<textarea class="form-control text_input" id="content"
								name="content" rows="5" required>${board.content }</textarea>
						</div>
					</div>
					
		            <div class="row row-cols-2 p-0 insert_row2_custom">
			            <div class="form-group col img_row">
							<label class="lable2" for="image">이미지 첨부</label> 
						</div>
			            <div class="form-group col">
							<input type="file" class="form-control img_input" name="file">
							<p>기존&nbsp;파일&nbsp;:&nbsp;<span>${board.file_name_custom }</span></p>
						</div>
						</div>									
						
		            <div class="row row-cols-1 p-0 insert_row2_custom">					
			            <div class="form-group col btn_row">
				            <button type="submit" class="btn btn_detail_custom">등록</button>
				            <button class="btn btn_detail_custom" onclick="closeAndRedirect()">취소</button>
			       		</div>
			       	</div>					
					
				</div>
			</form>
		<!-- input 영역 END -->
		</div>		
	<!-- 전체 content 영역  END-->
	</div>	
</body>
</html>