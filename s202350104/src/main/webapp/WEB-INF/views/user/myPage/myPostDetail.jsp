<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp"%>
<!-- Top bar -->
<%@ include file="/WEB-INF/components/TobBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>myPostDetail</title>
<link rel="stylesheet" type="text/css" href="/css/myPost.css">
<link rel="stylesheet" type="text/css" href="/css/adminTable.css">
<script type="text/javascript">
function confirmDelete(id) {
    if (confirm('정말로 이 항목을 삭제하시겠습니까?')) {
        $.ajax({
            type: 'POST', // 또는 'POST' 등의 HTTP 메서드 사용 가능
            url: 'myPostDelete',
            data: { id: id },
            success: function(result) {
                // 성공적으로 삭제된 경우의 처리
                alert('삭제되었습니다.');
                location.href = '/user/myPage/myPost';
            },
            error: function(xhr, status, error) {
                // 오류 발생 시의 처리
                alert('삭제에 실패했습니다.');
            }
        });
    } else {
        // 취소 버튼을 눌렀을 때의 처리
        // 필요한 로직을 추가하세요.
    }
}
</script>

</head>
<body>
	<main>
		<div class="d-flex">
			<div class="col-2">
				<%@ include file="/WEB-INF/components/MyPageSideBar.jsp"%>
			</div>
			<div class="container p-5 col-10">
				
				<!-- Section1: Title -->
				<div class="container my-5">
					<c:choose>
						<c:when test="${board.small_code eq 6}">
							<h1>${board.content}</h1>						
						</c:when>
						<c:otherwise>
							<h1>${board.title}</h1>								
						</c:otherwise>
					</c:choose>		
					<hr class="hr" />
					
					<div class="container mypost-content-custom">				
						<div class="mb-3">
							<c:choose>
								<c:when test="${board.small_code eq 6}">
									<label for="content" class="mypost-form-label">내용</label> 
									<input type="text" class="form-control text-box" name="content"
										   value="${board.content} " readonly>							
								</c:when>
								<c:otherwise>
									<label for="title" class="mypost-form-label">제목</label> 
									<input type="text" class="form-control text-box" name="title"
										   value="${board.title} " readonly>								
								</c:otherwise>
							</c:choose>
						</div>
						<c:if test="${board.small_code eq 3}">						
						<div class="mb-3">
							<label for="content" class="mypost-form-label">내용</label>
							<textarea class="form-control" name="content" rows="5"
								readonly>${board.content}</textarea>
						</div>

							<div class="mb-3">
								<label for="image" class="mypost-form-label">첨부파일&nbsp;<span>${board.file_name_custom }</span></label><br>
								<img alt="${board.file_name }" src="../${board.file_path }${board.file_name }" 
									 name="image">
							</div>
						</c:if>
					</div>
					<hr class="hr" />
					<div class="text-center">
						<input class="btn btn-primary" type="button" value="수정하기"
							   onclick="">
						<input class="btn btn-primary" type="button" value="목록"
							   onclick="location.href='myPost'">
						<input class="btn btn-primary" type="button" value="삭제"
							   onclick="confirmDelete(${board.id})">							   
					</div>
				</div>
			</div>
		</div>
	</main>
</body>
</html>