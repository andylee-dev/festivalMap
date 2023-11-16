<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>    
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>BoardInsertForm</title>

<script>
	function closeAndRedirect() {
		// 취소 시 이전페이지 이동
		window.history.back();
	}
	
    // 체크박스 선택 수 제한하는 함수
    function limitCheckboxes(checkbox, max) {
        var checkedCheckboxes = document.querySelectorAll('.tag_input:checked');

        if (checkedCheckboxes.length > max) {
            checkbox.checked = false;
        }
    }
	
    document.addEventListener('DOMContentLoaded', function () {
        // 클래스 'tag_input'을 가진 모든 체크박스 가져오기
        var checkboxes = document.querySelectorAll('.tag_input');

        // 각 체크박스에 이벤트 리스너 추가
        checkboxes.forEach(function (checkbox) {
            checkbox.addEventListener('change', function () {
                // 체크박스에 해당하는 라벨 가져오기
                var label = document.querySelector('label[for="' + checkbox.id + '"]');

                // 체크박스가 선택된 경우 배경색 변경
                if (checkbox.checked) {
                    label.style.backgroundColor = '#FF4379'; // 'your_desired_color'를 원하는 색상으로 대체
                } else {
                    label.style.backgroundColor = 'white'; // 체크박스가 선택 해제된 경우 배경색 초기화
                }
            });
        });
    });

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
							<h1><strong>공지사항, 신규 등록</strong></h1>
						</c:when>
						<c:when test="${smallCode == 2}">
							<h1><strong>이달의소식, 신규 등록</strong></h1>
						</c:when>
						<c:when test="${smallCode == 3}">
							<h1><strong>자유게시판, 신규 등록</strong></h1>
							<c:if test="${msg!=null }">${msg }</c:if>
						</c:when>
						<c:when test="${smallCode == 4}">
							<h1><strong>포토게시판, 신규 등록</strong></h1>
						</c:when>
						<c:when test="${smallCode == 5}">
							<h1><strong>이벤트, 신규 등록</strong></h1>
						</c:when>
						<c:otherwise>
							<h1><strong>일반 게시물 등록</strong></h1>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
		
		<!-- input 영역 -->
		<div class="container p-0 text-left">
        	<form action="integratedboardInsert" method="post" enctype="multipart/form-data">
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
		                	<input type="text" class="form-control title_input" id="title" name="title" required>					
						</div>
					</div>
					
					<!-- content 입력 -->
					<div class="row row-cols-2 p-0 insert_row2_custom">	
			            <div class="form-group col text_row">
			                <label for="content">내&nbsp;용</label>
			            </div>
			            <div class="form-group col">
			                <textarea class="form-control text_input" id="content" name="content" rows="4" required></textarea>
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

					<!-- 태그 입력	 -->				
		            <div class="row row-cols-2 p-0 insert_row2_custom">					
						<div class="form-group col tag_row">
						    <label for="tags">#태&nbsp;그 <br><span>(최대 3개 선택)</span></label>
						    
						</div>
						<div class="form-group col tag_row2">
						    <c:forEach var="tag" items="${tagList}">
						        <input type="checkbox" class="btn-check tag_input" name="tagsList" id="btn-check-outlined-${tag.id}" value="${tag.id}" onchange="limitCheckboxes(this, 3)">
						        <label class="btn btn-outline-secondary" for="btn-check-outlined-${tag.id}">#${tag.name}</label>
						    </c:forEach>
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

	<!-- 전체 content 영역  END-->	
	</div>

</body>
</html>