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
	<div id="content_title" class="container p-5 mb-4 text-center"></div>

	<!-- 전체 content 영역  Start-->
	<div class="container p-0 general_board_custom" style="width: 100%;">

		<!-- 상단 title 영역  -->
		<div class="container p-0 text-center header_title_custom">
			<div class="row align-items-start">
				<div class="col">
					<c:choose>
						<c:when test="${smallCode == 2}">
							<h1>
								<strong>이달의 소식</strong>
							</h1>
						</c:when>
						<c:when test="${smallCode == 3}">
							<h1>
								<strong>자유게시판</strong>
							</h1>
						</c:when>
						<c:otherwise>
							<h1>
								<strong>${board.title }</strong>
							</h1>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>

		<!-- 구분 출력 -->
		<div class="container p-3">
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
									pattern="YYYY.MM.dd" />
				</div>
				<div class="col-md-1">${board.read_count }</div>
			</div>
		</div>

		<!-- 이미지 출력 -->
		<div class="container p-3">
			<div class="row row-cols-1">
				<div class="col img_detail_custom">
					<img alt="${board.file_name }"
						 src="${board.file_path }${board.file_name}">
				</div>
			</div>
		</div>

		<!-- 상세내용 출력 -->
		<div class="container p-3 detail_custom">
			<div class="row row-cols-1">
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
						<span class="badge rounded-pill text-bg-light">#${tags.name	}</span>
					</c:forEach>
				</div>
			</div>
		</div>

		<!-- 기능버튼 출력 -->
		<div class="container p-3">
			<div class="row row-cols-4 detail-btn-custom">
				<c:choose>
					<c:when test="${board.small_code eq 3 }">
						<div class="col-md-1">
							<button class="btn" onclick="location.href='boardUpdateForm?id=${board.id}&userId=${userId }'">수&nbsp;정</button>
						</div>
						<div class="col-md-1">
							<button class="btn" onclick="location.href='boardDelete?id=${board.id}&userId=${userId }&smallCode=${board.small_code }'">삭&nbsp;제</button>
						</div>
						<div class="col-md-1">
							<button class="btn" onclick="closeAndRedirect(${board.small_code })">글&nbsp;목&nbsp;록</button>
						</div>
						<div class="col-md-1 detail-report-custom">
							<!-- 게시판 신고기능 -송환 -->
							<button class="btn" onclick="report(${board.id})">신고하기</button>
						</div>
					</c:when>
					<c:otherwise>
						<div class="col-md-1 ">
							<button class="btn" onclick="closeAndRedirect(${board.small_code })">목록</button>
						</div>
					</c:otherwise>
				</c:choose>
			</div>
		</div>

		<c:choose>
			<c:when test="${board.small_code eq 3 }">
				<!-- 댓글 출력 -->
				<div class="container p-3 comment-custom border">
					<div class="row row-cols-1 align-items-start">
						<div class="col">
							<!-- input 영역 -->
							<div class="container p-0">
								<form action="commentInsert" method="post" enctype="multipart/form-data">
									<input type="hidden" name="id" value="${board.id }">
									<input type="hidden" name="name" value="${board.name }"> 
									<input type="hidden" name="user_id" value="${userId }"> 
									<input type="hidden" name="big_code" value="${board.big_code }">
									<input type="hidden" name="small_code"  value="${board.small_code }"> 
									<input type="hidden" name="comment_group_id" value="${board.comment_group_id }">
									<input type="hidden" name="comment_step" value="${board.comment_step }"> 
									<input type="hidden" name="comment_indent" value="${board.comment_indent }">

									<div class="row row-cols-3 p-0">
										<div class="form-group col comment-title">
											<p>댓글작성자닉네임</p>
										</div>

										<div class="form-group col comment-input">
											<input type="text" class="form-control" name="content"
												   required="required" placeholder="댓글을 입력하세요.">
										</div>

										<div class="form-group col comment-btn">
											<button type="submit" class="btn btn_detail_custom">등록</button>
										</div>
									</div>
								</form>

								<!-- input 영역 END -->
							</div>

							<!-- 대댓글 출력  -->
							<div class="container p-3 comments-custom">
								<c:forEach var="comments" items="${comment }">
									<div class="row row-cols-2 align-items-start">
										<div class="col comments-nickname">
											<p>${comments.name }</p>
										</div>

										<div class="col comments-content">
											<p class="d-inline-flex gap-1">
												<c:forEach begin="2" end="${comments.comment_indent }">└▶</c:forEach>
												<button class="btn" type="button" data-bs-toggle="collapse"
														data-bs-target="#collapseExample${comments.id}"
														aria-expanded="false" aria-controls="collapseExample"
														style="width: 900px; text-align: left;">
														${comments.content }</button>

											</p>
											<span class="blink" style="font-size: 16px; font-weight: bold; color: #FF4379; margin-left: -740px; margin-top: 6px;">new</span>
										</div>

										<div class="collapse comments-collapse-custom" id="collapseExample${comments.id}">
											<div class="card card-body comments-body-custom">
												<!-- input 영역 -->
												<div class="container p-0 row row-cols-2">
													<form class="col" action="commentInsert" method="post" enctype="multipart/form-data">
														<input type="hidden" name="id" value="${board.id }">
														<input type="hidden" name="name" value="${comments.name }">
														<input type="hidden" name="user_id" value="${userId }">
														<input type="hidden" name="big_code" value="${board.big_code }"> 
														<input type="hidden" name="small_code" value="${board.small_code }"> 
														<input type="hidden" name="comment_group_id" value="${board.comment_group_id }"> 
														<input type="hidden" name="comment_step" value="${comments.comment_step }"> 
														<input type="hidden" name="comment_indent" value="${comments.comment_indent }">

														<div class="row row-cols-3 p-0">
															<div class="form-group col comment-md-title">
																<p>대댓글</p>
															</div>

															<div class="form-group col comment-md-input">
																<input type="text" class="form-control" name="content"
																	   placeholder="댓글을 입력하세요.">
															</div>

															<div class="form-group col comment-md-btn">
																<button type="submit" class="btn">등록</button>
															</div>
														</div>
													</form>
													<button class="col report-btn" onclick="report(${comments.id})">신고</button> 
													<!-- input 영역 END -->
												</div>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>

						</div>
					</div>
				</div>

			</c:when>
		</c:choose>


	<!-- 전체 content 영역  END-->
	</div>

</body>
</html>