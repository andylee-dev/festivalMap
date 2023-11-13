<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
    
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
					url:"<%=request.getContextPath()%>/user/deleteQnaPro",
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
<link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.css" />
	<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/daterangepicker/daterangepicker.js"></script>
	<script type="text/javascript">
		// init
	    $(document).ready(function() {
	        const status = '${searchOption.status != null ? searchOption.status : ""}';
			const dateOptions = '${searchOption.dateOptions != null ? searchOption.dateOptions : ""}';
	        if(status != '') {
	            $('select[name="status"][value="'+status+'"]').attr('checked', 'checked');
	        }
	        if(dateOptions != '') {
	            $('input[name="dateOptions"][value="'+dateOptions+'"]').attr('checked', 'checked');
	        }

	        const dateFormat = {
		          singleDatePicker: true, // 시작 날짜만 선택
		          linkedCalendars: false, // 두 개의 독립된 달력 사용
		          autoApply: true, // 날짜를 선택하면 자동으로 적용
		          locale: {
		            format: 'yyyy-MM-DD',
		          },
		        }
	        const onChangeDate = () => {
	            const date = $('input[name="dateOptions"]:checked').val();
	            let value = [];
	            if (date === "TO") {
	                value = [moment(), moment()]; // 오늘 선택
	            } else if(date === "1W"){
	            	value = [moment(moment()).subtract(1,"W"),moment()];
	            } else if (date === "1M"){
	            	value = [moment(moment()).subtract(1,"M"),moment()];		            	
	            } else if (date === "3M"){
	            	value = [moment(moment()).subtract(3,"M"),moment()];		            	
	            } else if (date === "6M"){
	            	value = [moment(moment()).subtract(6,"M"),moment()];		            	
	            } else if (date === "ALL"){
	            	value = [];
	            }
	            if(value && value.length > 0){
	                $('#startDatePicker').val(value[0].format('yyyy-MM-DD'));
	                $('#endDatePicker').val(value[1].format('yyyy-MM-DD'));
	            } else{
		            $('#startDatePicker').val('');
		            $('#endDatePicker').val('');
	            }
            }
	        $('#startDatePicker').daterangepicker(dateFormat);
	        $('#endDatePicker').daterangepicker(dateFormat);
	        $('input[name="dateOptions"]').change(onChangeDate);        
	        onChangeDate();        
	    }); 
	    
	    function createQueryURL(page) {
	        const startDate = document.querySelector('input[name="startDate"]').value;
	        const endDate = document.querySelector('input[name="endDate"]').value;
	        const dateOptions = document.querySelector('input[name="dateOptions"]:checked') ? document.querySelector('input[name="dateOptions"]:checked').value : '';

	        const params = {
	            dateOptions: dateOptions,
	            startDate: startDate,
	            endDate: endDate,
	            currentPage: page
	        };
	        return 'qnaList?' + Object.entries(params)
			        .filter(([key, value]) => value !== undefined && value !== null && value !== '') // 값이 없는 경우를 필터링합니다.
			        .map(([key, value]) => key+'='+value).join('&');
	    }
	</script>
</head>
<body>
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<div class="d-flex">
	<%@ include file="/WEB-INF/components/MyPageSideBar.jsp" %>
	<div class="container-fluid">
	<div class="row">
		<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
			<!-- Section1: Title -->
			<div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
				<h1 class="border">my1:1 문의</h1>
			</div>
	
			<!-- Section2: Search Form -->
			<div class="border p-3 m-3">
				<form action="qnaList" method="POST">	
					<div class="input-group col-auto mb-3" >
						<span class="input-group-text col-auto">작성일</span>
							<input type="radio" class="btn-check" name="dateOptions" id="TO" value="TO" autocomplete="off" >
							<label class="btn" for="TO">오늘</label>
							<input type="radio" class="btn-check" name="dateOptions" id="1W" value="1W" autocomplete="off">
							<label class="btn" for="1W">1주일</label>
							<input type="radio" class="btn-check" name="dateOptions" id="1M" value="1M" autocomplete="off">
						    <label class="btn" for="1M">1개월</label>
							<input type="radio" class="btn-check" name="dateOptions" id="3M" value="3M" autocomplete="off">
						    <label class="btn" for="3M">3개월</label>
							<input type="radio" class="btn-check" name="dateOptions" id="6M" value="6M" autocomplete="off">
						    <label class="btn" for="6M">6개월</label>
							<input type="radio" class="btn-check" name="dateOptions" id="ALL" value="ALL" autocomplete="off" checked>
						    <label class="btn" for="ALL">전체</label>
							<input type="date" id="startDatePicker" name="startDate" value="${startDate}">
							<input type="date" id="endDatePicker" name="endDate" value="${endDate}">
					</div>
					<div class="input-group mb-3 d-flex align-items-center">
						<span class="input-group-text " >진행 상태</span>
						<div class="form-check mx-2">
							<input class="form-check-input" type="radio" name="status" id="status1" value="0">
							<label class="form-check-label" for="status1">답변대기</label>
						</div>
						<div class="form-check mx-2">
							<input class="form-check-input" type="radio" name="status" id="status2" value="1">
							<label class="form-check-label" for="status2">답변완료</label>
						</div>
					</div>
						<button type="submit" class="btn btn-outline-secondary">검색</button>
						<button type="reset" class="btn btn-outline-secondary">초기화</button>
				</form>
			</div>		
			
			<!-- Section3: Table -->		
			<div class="border p-3 m-3">
				<button type="button" class="btn btn-outline-secondary" onclick="location.href='insertQnaForm'">등록</button>
					<table class="table table-striped table-sm">
						<thead>
							<tr>
								<th scope="col">순번</th>
								<th scope="col">문의제목</th>
								<th scope="col">문의내용</th>
								<th scope="col">작성일</th>
								<th scope="col">진행상태</th>
							</tr>
						</thead>
						<tbody>
							<c:set var="num" value="${page.start}"/>
							<c:forEach var="qna" items="${listQnaList}" varStatus="status">
								<input type="hidden" name="user_id" value="${qna.user_id}" id="user_id${status.index}">
								<input type="hidden" name="id" value="${qna.id}" id="id${status.index}">
									<tr id="qna${status.index}">
										<td>${num}</td>
										<td><a href="qnaDetail?user_id=${qna.user_id}&id=${qna.id}"><c:if test="${qna.status == 1}">[답변완료]</c:if>${qna.question_title}</a></td>
										<td>${qna.question_content}</td>
										<td><fmt:formatDate value="${qna.created_at}" type="date" pattern="YY/MM/dd"/></td>
										<td><c:if test="${qna.status == 0}">답변대기</c:if>
											<c:if test="${qna.status == 1}">답변완료</c:if>
										<td><input type="button" onclick="location.href='updateQnaForm?user_id=${qna.user_id}&id=${qna.id}'" value="수정"></td>
										<td><input type="button" onclick="getQnaDelete(${status.index})" value="삭제"></td>
									</tr>
							<c:set var="num" value="${num + 1}"/>
							</c:forEach>
						</tbody>
					</table>
				<div align="center">
					<c:if test="${page.startPage > page.pageBlock}">
						<a href="qnaList?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
					</c:if>
					<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
						<a href="qnaList?currentPage=${i}">[${i}]</a>
					</c:forEach>
					<c:if test="${page.endPage < page.totalPage}">
						<a href="qnaList?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
					</c:if>
				</div>
			</div>		
		</main>
	</div>
	</div>
	</div>
</body>
</html>