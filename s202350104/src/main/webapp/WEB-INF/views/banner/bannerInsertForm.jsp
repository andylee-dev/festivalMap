<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>    
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BannerInsertForm</title>

<script>
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
	
	function updateSmallCode(value) {
	    // ID를 사용하여 숨겨진 입력 필드를 가져옵니다.
	    var smallCodeInput = document.getElementById("small_code");

	    // 숨겨진 입력 필드의 값을 업데이트합니다.
	    smallCodeInput.value = value;
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
					<h1><strong>배너, 신규 등록</strong></h1>
					<c:if test="${msg!=null }">${msg }</c:if>					
				</div>
			</div>
		</div>
		
		<!-- input 영역 -->
		<div class="container p-0 text-left">
        	<form action="bannerInsert" method="post" enctype="multipart/form-data">
				<input type="hidden" name="user_id" value="${userId }">
				<input type="hidden" name="big_code" value="${bigCode }">
				<input type="hidden" name="small_code" id="small_code" value="${smallCode }">
				<input type="hidden" name="tagsList" value="" />		

				<div class="row row-cols-1 p-0 insert_row_custom">
					
					<!-- 제목 입력 -->
					<div class="row row-cols-2 p-0 insert_row2_custom">
						<div class="form-group col title_row">
		               		<label for="title">제&nbsp;목</label>				
						</div>
						<div class="form-group col">
		                	<input type="text" class="form-control title_input" id="title" 
		                		   name="title" required="required">					
						</div>
					</div>
					
					<!-- content 입력 -->
					<div class="row row-cols-2 p-0 insert_row2_custom">	
			            <div class="form-group col text_row">
			                <label for="content">내&nbsp;용</label>
			            </div>
			            <div class="form-group col">
			                <textarea class="form-control text_input" id="content" name="content" 
			                		  rows="4" required="required"></textarea>
			            </div>
		            </div>					

					<!-- URL 입력 -->
					<div class="row row-cols-2 p-0 insert_row2_custom">	
			            <div class="form-group col text_row">
			                <label for="url">U&nbsp;R&nbsp;L</label>
			            </div>
			            <div class="form-group col">
		                	<input type="text" class="form-control title_input" id="url" 
		                		   name="url" placeholder="URL주소가 필요한 경우만 입력하세요.">			            
			            </div>
		            </div>
		            
					<!-- 첨부파일 -->
		            <div class="row row-cols-2 p-0 insert_row2_custom">
			            <div class="form-group col img_row">
							<label class="lable2" for="image">이미지 첨부</label> 
						</div>
			            <div class="form-group col">
							<input type="file" class="form-control img_input" name="file">
						</div>
					</div>
					
					<!-- 분류 입력 -->
					<div class="row row-cols-2 p-0 insert_row2_custom">
						<div class="form-group col title_row">
		               		<label for="title">분류코드</label>				
						</div>
						<div class="form-group col radio-custom">
		                	<input type="radio" name="smallCode" value="1"
						   		   onchange="updateSmallCode(1)"> 'Home' 					
							<input type="radio" name="smallCode" value="2" 
								   onchange="updateSmallCode(2)"> 'Footer' 
							<input type="radio" name="smallCode" value="3"
								   onchange="updateSmallCode(3)"> 'Sidebar' 
							<input type="radio" name="smallCode" value="4" 
								   onchange="updateSmallCode(4)"> 'Content'						
						</div>
					</div>						
					
					<!-- 버튼 영역 -->					
		            <div class="row row-cols-1 p-0 insert_row2_custom">					
			            <div class="form-group col btn_row" style="">
				            <button type="submit" class="btn btn_detail_custom">등록</button>
				            <button class="btn btn_detail_custom" onclick="closeAndRedirect()">취소</button>
			       		</div>
			       	</div>					
					
						            						
				</div>		
			</form>
		</div>
		
	<!-- 전체 content 영역  Start-->		
	</div>	
	
</body>
</html>