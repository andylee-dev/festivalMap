<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/AdminHeader.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

<script type="text/javascript">
	function getQnaDelete(pIndex){
		alert("실행")
		var seluser_id = $('#user_id'+pIndex).val();
		var selid	   = $('#id'+pIndex).val();
		alert(seluser_id);
		alert(selid);
		$.ajax(
				{
					url:"<%=request.getContextPath()%>/admin/cs/qnaDelete",
					data:{	user_id : seluser_id
						,	id		: selid
						 },
					dataType:'text',
					success:function(data){
						alert(".ajax getdeletQna data->"+data);
						if(data == '1'){
							$('#qna'+pIndex).remove();
							
							alert("성공적으로 삭제 되었습니다.")
						}else{
							alert("삭제되지않았습니다.다시 시도하세요")
						}
					}
				}		
		);
	}	
</script>
</head>
<body>
	<div class="container-fluid">
	<div class="row">
		<%@ include file="/WEB-INF/components/AdminSideBar.jsp" %>
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<!-- Section1: Title -->
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="border">1:1 문의</h1>
			</div>
	
			<!-- Section2: Search Form -->		
			<div class="border p-3 m-3">
				<h1 class="border">검색폼</h1>
				<button type="button" class="btn btn-outline-secondary">검색</button>
				<button type="button" class="btn btn-outline-secondary">초기화</button>
			</div>		
			
			<!-- Section3: Table -->		
			<div class="border p-3 m-3">
				<table class="table table-striped table-sm">
					<thead>
						<tr>
							<th scope="col">순번</th>
							<th scope="col">이름</th>
							<th scope="col">비밀번호</th>
							<th scope="col">닉네임</th>
							<th scope="col">생년월일</th>
							<th scope="col">문의제목</th>
							<th scope="col">등록일</th>
							<th scope="col">수정일</th>
							<th scope="col">답변여부</th>
							<th scope="col">수정</th>
							<th scope="col">삭제</th>  
						</tr>
					</thead>
					<tbody>
						<c:set var="num" value="${page.start}"/>
						<c:forEach var="qna" items="${listQnaList}"  varStatus="status">
							<input type="hidden" name="user_id" value="${qna.user_id}" id="user_id${status.index}">
							<input type="hidden" name="id" value="${qna.id}" id="id${status.index}">
							<tr id="qna${status.index}">
								<td>${num}</td>
								<td>${qna.name}</td>
								<td>${qna.password}</td>
								<td>${qna.nickname}</td>
								<td>${qna.birthday}</td>
								<td><c:if test="${qna.status == 1}">[답변완료]</c:if>${qna.question_title}</a></td>
								<td><fmt:formatDate value="${qna.created_at}" type="date" pattern="YY/MM/dd"/></td>
								<td><fmt:formatDate value="${qna.updated_at}" type="date" pattern="YY/MM/dd"/></td>
								<td><c:if test="${qna.status == 0}">답변대기</c:if>
									<c:if test="${qna.status == 1}">답변완료</c:if>
								</td>
								<td><input type="button"onclick="location.href='qnaUpdate?user_id=${qna.user_id}&id=${qna.id}'" value="수정"></td>
								<td><input type="button" onclick="getQnaDelete(${status.index})" value="삭제"></td>
							</tr>
							<c:set var="num" value="${num + 1}"/>
						</c:forEach>
					</tbody>
				</table>
			<div align="center">
				<c:if test="${page.startPage > page.pageBlock}">
					<a href="qna?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
				</c:if>
				<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
					<a href="qna?currentPage=${i}">[${i}]</a>
				</c:forEach>
				<c:if test="${page.endPage < page.totalPage}">
					<a href="qna?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
				</c:if>
			</div>
			</div>		
		</main>
	</div>
	</div>
</body>
</html>