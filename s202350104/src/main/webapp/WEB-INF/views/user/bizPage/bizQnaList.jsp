<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/components/header.jsp" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>bizQnaList</title>
<link href="/css/adminTable.css" rel="stylesheet" type="text/css">
<style type="text/css">
h1 {
	color: black;
	font-size: 32px;
	font-family: Noto Sans;
	font-weight: 600;
	word-wrap: break-word
}
</style>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
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
	<!-- Top bar -->
	<%@ include file="/WEB-INF/components/TobBar.jsp" %>
	<main >
		<div class="d-flex">
			<%@ include file="/WEB-INF/components/BizPageSideBar.jsp" %>
			<div class="container border p-5">
				<div class="container my-5">
				
			<!-- Section1: Title -->
				<h1>biz1:1 문의</h1>
				<hr class="hr" />
	
			<!-- Section2: Search Form -->		
			<div class="container col-9 justify-content-center my-5">
				<form action="qnaList" method="POST" class="container justify-content-center">	
					
					<div class="col-12 my-4 d-flex align-items-center">
						<label for="searchType" class="col-form-label col-2  mx-1">작성일</label>
						<div class="col-7  mx-1 d-flex">	
							<input type="radio" class="btn-check" name="dateOptions" id="TO" value="TO" autocomplete="off" >
							<label class="btn mx-1" for="TO">오늘</label>
							<input type="radio" class="btn-check" name="dateOptions" id="1W" value="1W" autocomplete="off">
							<label class="btn mx-1" for="1W">1주일</label>
							<input type="radio" class="btn-check" name="dateOptions" id="1M" value="1M" autocomplete="off">
						    <label class="btn mx-1" for="1M">1개월</label>
							<input type="radio" class="btn-check" name="dateOptions" id="3M" value="3M" autocomplete="off">
						    <label class="btn mx-1" for="3M">3개월</label>
							<input type="radio" class="btn-check" name="dateOptions" id="6M" value="6M" autocomplete="off">
						    <label class="btn mx-1" for="6M">6개월</label>
							<input type="radio" class="btn-check" name="dateOptions" id="ALL" value="ALL" autocomplete="off" checked>
						    <label class="btn mx-1" for="ALL">전체</label>
							</div>
							<div class="col-3 d-flex">
								<input class="mx-1" type="date" id="startDatePicker" name="startDate" value="${startDate}">
								<input class="mx-1" type="date" id="endDatePicker" name="endDate" value="${endDate}">
							</div>
					</div>
					<!-- 옵션 -->
					<div class="col-12 my-4 d-flex align-items-center ">
					<label for="searchType" class="col-form-label col-2  mx-1">진행 상태</label>
						<div class="form-check mx-2">
						<input class="form-check-input" type="radio" name="status" id="status1" value="0">
						<label class="form-check-label" for="status1">답변대기</label>
						</div>
						<div class="form-check mx-2">
							<input class="form-check-input" type="radio" name="status" id="status2" value="1">
							<label class="form-check-label" for="status2">답변완료</label>
						</div>
					</div>
					<div class="container col-10 d-flex justify-content-center">
						<button type="submit" class="btn btn-primary  col-2 mx-3">검색</button>
						<button type="reset" class="btn btn-outline-secondary col-2 mx-3">초기화</button>
					</div>
				</form>
			</div>
					
			<!-- Section3: Table -->		
			<div class="container col-9 justify-content-center my-2">
				<button type="button" class="btn btn-outline-secondary mt-4" onclick="location.href='insertQnaForm'">등록</button>
			</div>
				<div class="container col-9 justify-content-center align-items-center mb-2 p-3 pt-0">
					<div class="container table-container p-4">
						<div class="table-responsive">
						<table id="userTable" class="table table-md text-center p-3">
							<thead>
								<tr>
									<th scope="col">순번</th>
									<th scope="col">문의제목</th>
									<th scope="col">작성일</th>
									<th scope="col">진행상태</th>
									<th scope="col">관리</th>
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
											<td><fmt:formatDate value="${qna.created_at}" type="date" pattern="YY/MM/dd"/></td>
											<td><c:if test="${qna.status == 0}">답변대기</c:if>
												<c:if test="${qna.status == 1}">답변완료</c:if>
												
											<td><a class="detail-btn" href="updateQnaForm?user_id=${qna.user_id}&id=${qna.id}">관리</a></td>	
										</tr>
									<c:set var="num" value="${num + 1}"/>
								</c:forEach>
							</tbody>
						</table>
						</div>
					</div>
				</div>
					<nav aria-label="Page navigation example ">
						<ul class="pagination">
							<c:if test="${page.startPage > page.pageBlock}">
								<li class="page-item">
									<a href="qnaList?currentPage=${page.startPage-page.pageBlock}" class="pageblock page-link">[이전]</a>
								</li>
							</c:if>
							<c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
								<li class="page-item">
									<a href="qnaList?currentPage=${i}" class="pageblock page-link ${page.currentPage == i ? "active":"" }">${i}</a>
								</li>
							</c:forEach>
							<c:if test="${page.endPage < page.totalPage}">
								<li class="page-item">
									<a href="qnaList?currentPage=${page.startPage+page.pageBlock}" class="pageblock page-link">[다음]</a>
								</li>
							</c:if>
						</ul>
					</nav>	
				</div>
			</div>	
		</div>		
	</main>
</body>
</html>